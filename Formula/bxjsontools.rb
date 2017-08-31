class Bxjsontools < Formula
  desc     "C++ JSON serialization API"
  homepage "https://github.com/BxCppDev/bxjsontools"
  url      "https://github.com/BxCppDev/bxjsontools/archive/0.2.0.tar.gz"
  version  "0.2.0"
  sha256   "c4d71d5257f9534d84c8d41e37b25565b07756636dbdbe3221a19d11689d162f"
  head     "https://github.com/BxCppDev/bxjsontools.git", :branch => "develop"

  needs :cxx11
  depends_on "cmake" => :build

  option "without-test", "Inhibit test programs"

  def install
    ENV.cxx11
    mkdir "brew-bxjsontools-build" do
      args = std_cmake_args
      args << "-DBXJSONTOOLS_ENABLE_TESTING=OFF" if build.without? "test"
      system "cmake", "..", *args
      system "make"
      if build.with? "test"
        system "make", "test"
      end
      system "make", "install"
    end
  end

  test do
    system bin/"bxjsontools-query", "--help"
  end

end
