class Bxjsontools < Formula
  desc     "C++ JSON serialization API"
  homepage "https://github.com/BxCppDev/bxjsontools"

  stable do
    url      "https://github.com/BxCppDev/bxjsontools/archive/0.2.1.tar.gz"
    version  "0.2.1"
    sha256   "a97337c8f5c6cfbb17d3551a60773fa89d66a6799a4579bdb225ab76bd032f8a"
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
