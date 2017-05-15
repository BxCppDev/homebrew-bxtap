class Bxjsontools < Formula
  desc ""
  homepage ""
  url "https://github.com/BxCppDev/bxjsontools/archive/0.1.0.tar.gz"
  version "0.1.0"
  sha256 "cc52b108182347b5599cf930d6af6f4dc25f51a2b89864cf7451485103851bf4"

  depends_on "cmake" => :build

  def install
   ENV.cxx11
   # ENV.deparallelize
   mkdir "brew-bxjsontools-build" do
     args = std_cmake_args
     args << "-DBXJSONTOOLS_ENABLE_TESTING=OFF" if build.with? "without-test"
     system "cmake", "..", *args
     system "make"
     system "make", "install"
   end
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test bxjsontools`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
