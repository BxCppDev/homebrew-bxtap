class Doxygen < Formula
  desc     "Generate documentation for several programming languages"
  homepage "http://www.doxygen.org/"
  revision 1
  head     "https://github.com/doxygen/doxygen.git"

  stable do
    url "https://ftp.stack.nl/pub/users/dimitri/doxygen-1.8.13.src.tar.gz"
    mirror "https://mirrorservice.org/sites/ftp.debian.org/debian/pool/main/d/doxygen/doxygen_1.8.13.orig.tar.gz"
    sha256 "af667887bd7a87dc0dbf9ac8d86c96b552dfb8ca9c790ed1cbffaa6131573f6b"

    # Remove for > 1.8.13
    # "Bug 776791 - [1.8.13 Regression] Segfault building the breathe docs"
    # Upstream PR from 4 Jan 2017 https://github.com/doxygen/doxygen/pull/555
    patch do
      url "https://github.com/doxygen/doxygen/commit/0f02761a158a5e9ddbd5801682482af8986dbc35.patch?full_index=1"
      sha256 "6705eb83b419ad9a696290c624b8ff363ff39b94b250008d0ef36200254c2a08"
    end
  end

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "a5e7436a64a38db42f85d8f48c683423288933d61e7607b82883388c73a8a724" => :sierra
    sha256 "d42d176ead71b9276a1f55d13936132fd51627ceec4ab309de3abb79def891a1" => :el_capitan
    sha256 "215437e6278729e060526ada23b9e2c75eb93028269c4613610b9391b8976c81" => :yosemite
    sha256 "8a230a42a775c53722683ee9a725e573d0d98bd817772bd7ba795c7e9165162a" => :x86_64_linux # glibc 2.19
  end

  option "with-graphviz", "Build with dot command support from Graphviz."
  option "with-qt", "Build GUI frontend with Qt support."
  option "with-llvm", "Build with libclang support."

  deprecated_option "with-dot" => "with-graphviz"
  deprecated_option "with-doxywizard" => "with-qt"
  deprecated_option "with-libclang" => "with-llvm"
  deprecated_option "with-qt5" => "with-qt"

  # depends_on "cmake" => :build
  # depends_on "graphviz" => :optional
  # if build.with? "qt"
  #   depends_on "bxcppdev/bxtap/qt5-base" => :optional
  # end
  # depends_on "llvm" => :optional
  # depends_on "bison" unless OS.mac?
  # depends_on "bxcppdev/bxtap/flex" unless OS.mac?

  def install
    args = std_cmake_args
    if OS.mac?
      args << "-DCMAKE_OSX_DEPLOYMENT_TARGET:STRING=#{MacOS.version}"
    end
    args << "-Dbuild_wizard=ON" if build.with? "qt"
    args << "-Duse_libclang=ON -DLLVM_CONFIG=#{Formula["llvm"].opt_bin}/llvm-config" if build.with? "llvm"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "-j#{ENV.make_jobs}"
    end
    bin.install Dir["build/bin/*"]
    man1.install Dir["doc/*.1"]
  end

  test do
    system "#{bin}/doxygen", "-g"
    system "#{bin}/doxygen", "Doxyfile"
  end
end
