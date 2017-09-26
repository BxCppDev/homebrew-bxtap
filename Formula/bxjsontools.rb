class Bxjsontools < Formula
  desc     "C++ JSON serialization API"
  homepage "https://github.com/BxCppDev/bxjsontools"

  stable do
    url      "https://github.com/BxCppDev/bxjsontools/archive/0.2.0.tar.gz"
    version  "0.2.0"
    sha256   "3b9db47372c0dfc0ec74db1008cb211c1a3dc74ed804c633053aa57fb82f0111"
  end

  head do
    url     "https://github.com/BxCppDev/bxjsontools.git", :branch => "develop"
    version "0.3.0"
  end

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
