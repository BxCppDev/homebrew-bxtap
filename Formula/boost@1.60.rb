# Imported from https://github.com/SuperNEMO-DBD/
require 'formula'

class UniversalPython < Requirement
  satisfy(:build_env => false) { archs_for_command("python").universal? }

  def message; <<-EOS.undent
    A universal build was requested, but Python is not a universal build

    Boost compiles against the Python it finds in the path; if this Python
    is not a universal build then linking will likely fail.
    EOS
  end
end

class UniversalPython3 < Requirement
  satisfy(:build_env => false) { archs_for_command("python3").universal? }

  def message; <<-EOS.undent
    A universal build was requested, but Python 3 is not a universal build

    Boost compiles against the Python 3 it finds in the path; if this Python
    is not a universal build then linking will likely fail.
    EOS
  end
end

class BoostAT160 < Formula
  homepage 'http://www.boost.org'
  stable do
    url "https://downloads.sourceforge.net/project/boost/boost/1.60.0/boost_1_60_0.tar.bz2"
    sha256 "686affff989ac2488f79a97b9479efb9f2abae035b5ed4d8226de6857933fd3b"

    # Handle compile failure with boost/graph/adjacency_matrix.hpp
    # https://github.com/Homebrew/homebrew/pull/48262
    # https://svn.boost.org/trac/boost/ticket/11880
    # patch derived from https://github.com/boostorg/graph/commit/1d5f43d
    patch :DATA
  end

  head 'https://github.com/boostorg/boost.git'

  # # CMake Support resource
  # depends_on "cmake" => :build
  # resource "BoostCMakeSupport" do
  #   url "https://github.com/SuperNEMO-DBD/BoostCMakeSupport.git", :using => :git
  # end

  keg_only "Conflicts with production version Boost 1.63"

  env :userpaths

  option :universal
  option 'with-icu4c', 'Build regexp engine with icu support'
  option 'with-single', 'Enable building single-threading variant'
  option 'with-static', 'Enable building static library variant'
  option 'with-mpi', 'Build with MPI support'
  option :cxx11

  depends_on :python => :optional
  depends_on :python3 => :optional
  depends_on UniversalPython if build.universal? and build.with? "python"
  depends_on UniversalPython3 if build.universal? and build.with? "python3"

  if build.with?("python3") && build.with?("python")
    odie "boost: --with-python3 cannot be specified when using --with-python"
  end

  if build.with? 'icu4c'
    if build.cxx11?
      depends_on 'homebrew/core/icu4c' => 'c++11'
    else
      depends_on 'homebrew/core/icu4c'
    end
  end

  if build.with? 'mpi'
    if build.cxx11?
      depends_on 'open-mpi' => 'c++11'
    else
      depends_on :mpi => [:cc, :cxx, :optional]
    end
  end

  fails_with :llvm do
    build 2335
    cause "Dropped arguments to functions when linking with boost"
  end

  def install
    # https://svn.boost.org/trac/boost/ticket/8841
    if build.with? 'mpi' and build.with? 'single'
      raise <<-EOS.undent
        Building MPI support for both single and multi-threaded flavors
        is not supported.  Please use '--with-mpi' together with
        '--without-single'.
      EOS
    end

    if build.cxx11? and build.with? 'mpi' and (build.with? 'python' \
                                               or build.with? 'python3')
      raise <<-EOS.undent
        Building MPI support for Python using C++11 mode results in
        failure and hence disabled.  Please don't use this combination
        of options.
      EOS
    end

    ENV.universal_binary if build.universal?

    # Force boost to compile using the appropriate GCC version.
    open("user-config.jam", "a") do |file|
      if OS.mac?
        file.write "using darwin : : #{ENV.cxx} ;\n"
      else
        file.write "using gcc : : #{ENV.cxx} ;\n"
      end
      file.write "using mpi ;\n" if build.with? 'mpi'

      # Link against correct version of Python if python3 build was requested
      if build.with? 'python3'
        py3executable = `which python3`.strip
        py3version = `python3 -c "import sys; print(sys.version[:3])"`.strip
        py3prefix = `python3 -c "import sys; print(sys.prefix)"`.strip

        file.write <<-EOS.undent
          using python : #{py3version}
                       : #{py3executable}
                       : #{py3prefix}/include/python#{py3version}m
                       : #{py3prefix}/lib ;
        EOS
      end
    end

    # we specify libdir too because the script is apparently broken
    bargs = ["--prefix=#{prefix}", "--libdir=#{lib}"]

    if build.with? 'icu'
      icu4c_prefix = Formula['icu4c'].opt_prefix
      bargs << "--with-icu=#{icu4c_prefix}"
    else
      bargs << '--without-icu'
    end

    # Handle libraries that will not be built.
    without_libraries = []

    # The context library is implemented as x86_64 ASM, so it
    # won't build on PPC or 32-bit builds
    # see https://github.com/Homebrew/homebrew/issues/17646
    if Hardware::CPU.ppc? || Hardware::CPU.is_32_bit? || build.universal?
      without_libraries << "context"
      # The coroutine library depends on the context library.
      without_libraries << "coroutine"
    end

    # Boost.Log cannot be built using Apple GCC at the moment. Disabled
    # on such systems.
    without_libraries << "log" if ENV.compiler == :gcc || ENV.compiler == :llvm
    without_libraries << "python" if (build.without? 'python' \
                                      and build.without? 'python3')
    without_libraries << "mpi" if build.without? 'mpi'

    bargs << "--without-libraries=#{without_libraries.join(',')}"

    args = ["--prefix=#{prefix}",
            "--libdir=#{lib}",
            "-d2",
            "-j#{ENV.make_jobs}",
            "--layout=tagged",
            "--user-config=user-config.jam",
            "install"]

    if build.with? "single"
      args << "threading=multi,single"
    else
      args << "threading=multi"
    end

    if build.with? "static"
      args << "link=shared,static"
    else
      args << "link=shared"
    end

    args << "address-model=32_64" << "architecture=x86" << "pch=off" if build.universal?

    # Trunk starts using "clang++ -x c" to select C compiler which breaks C++11
    # handling using ENV.cxx11. Using "cxxflags" and "linkflags" still works.
    if build.cxx11?
      args << "cxxflags=-std=c++11"
      if ENV.compiler == :clang
        args << "cxxflags=-stdlib=libc++" << "linkflags=-stdlib=libc++"
      end
    end

    system "./bootstrap.sh", *bargs
    system "./b2", *args

    # # Install cmake support files
    # resources.each do |r|
    #   r.stage do
    #     boost_support_args = std_cmake_args
    #     boost_support_args << "-Dboost_VERSION=#{version}"
    #     boost_support_args << "-Dboost_SINGLE=TRUE" if build.with? "single"
    #     boost_support_args << "-Dboost_STATIC=TRUE" if build.with? "static"
    #     system "cmake", *boost_support_args
    #   end
    # end
  end

  def caveats
    s = ''
    # ENV.compiler doesn't exist in caveats. Check library availability
    # instead.
    if Dir["#{lib}/libboost_log*"].empty?
      s += <<-EOS.undent

      Building of Boost.Log is disabled because it requires newer GCC or Clang.
      EOS
    end

    if Hardware::CPU.ppc? || Hardware::CPU.is_32_bit? || build.universal?
      s += <<-EOS.undent

      Building of Boost.Context and Boost.Coroutine is disabled as they are
      only supported on x86_64.
      EOS
    end

    s
  end
end
__END__
diff -Nur boost_1_60_0/boost/graph/adjacency_matrix.hpp boost_1_60_0-patched/boost/graph/adjacency_matrix.hpp
--- boost_1_60_0/boost/graph/adjacency_matrix.hpp       2015-10-23 05:50:19.000000000 -0700
+++ boost_1_60_0-patched/boost/graph/adjacency_matrix.hpp       2016-01-19 14:03:29.000000000 -0800
@@ -443,7 +443,7 @@
     // graph type. Instead, use directedS, which also provides the
     // functionality required for a Bidirectional Graph (in_edges,
     // in_degree, etc.).
-    BOOST_STATIC_ASSERT(type_traits::ice_not<(is_same<Directed, bidirectionalS>::value)>::value);
+    BOOST_STATIC_ASSERT(!(is_same<Directed, bidirectionalS>::value));

     typedef typename mpl::if_<is_directed,
                                     bidirectional_tag, undirected_tag>::type
