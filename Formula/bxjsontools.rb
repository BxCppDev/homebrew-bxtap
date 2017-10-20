class Bxjsontools < Formula
  desc     "C++ JSON serialization API"
  homepage "https://github.com/BxCppDev/bxjsontools"

  stable do
    url      "https://github.com/BxCppDev/bxjsontools/archive/0.3.0.tar.gz"
    version  "0.3.0"
    sha256   "5f7661eb44c011ce136059848eceb09ccb38baa718c2585c89a6f18fab2ab488"
  end

  head do
    url     "https://github.com/BxCppDev/bxjsontools.git", :branch => "master"
    version "0.3.1"
  end

  devel do
    url     "https://github.com/BxCppDev/bxjsontools.git", :branch => "develop"
    version "0.3.1"
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
      system "make", "-j#{ENV.make_jobs}"
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
