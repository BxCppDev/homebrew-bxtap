class Bxjsontools < Formula
  desc ""
  homepage ""
  url "https://github.com/BxCppDev/bxjsontools/archive/0.1.0.tar.gz"
  version "0.1.0"
  sha256 "cc52b108182347b5599cf930d6af6f4dc25f51a2b89864cf7451485103851bf4"

  needs :cxx11
  depends_on "cmake" => :build


  def install
    ENV.cxx11
    mkdir "brew-bxjsontools-build" do
      args = std_cmake_args
      args << "-DBXJSONTOOLS_ENABLE_TESTING=OFF" if build.with? "without-test"
      system "cmake", "..", *args
      system "make"
      system "make", "install"
    end
  end

  test do
    system bin/"bxjsontools-query", "--help"
  end

end
