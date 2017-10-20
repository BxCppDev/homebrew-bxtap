class Bxprotobuftools < Formula
  desc     "C++ tools for Protocol Buffers based serialization"
  homepage "https://github.com/BxCppDev/bxprotobuftools"

  stable do
    url     "https://github.com/BxCppDev/bxprotobuftools/archive/0.3.0.tar.gz"
    version "0.3.0"
    sha256  "112805d7cad3aa9c4020974814315aaae2c3bc1af5820e978aded39710917082"
  end

  head do
    url     "https://github.com/BxCppDev/bxprotobuftools.git", :branch => "develop"
    version "0.3.1"
   end

  option "without-test", "Inhibit test programs"

  needs :cxx11
  depends_on "cmake" => :build
  depends_on "bxcppdev/bxtap/protobuf"

  def install
    ENV.cxx11
    mkdir "brew-bxprotobuftools-build" do
      args = std_cmake_args
      args << "-DPROTOBUF_ROOT=#{HOMEBREW_PREFIX}/Cellar/protobuf/3.3.0"
      args << "-DBXPROTOBUFTOOLS_ENABLE_TESTING=OFF" if build.without? "test"
      system "cmake", "..", *args
      system "make", "-j#{ENV.make_jobs}"
      if build.with? "test"
        system "make", "test"
      end
      system "make", "install"
    end
  end

  test do
    system bin/"bxprotobuftools-query", "--help"
  end

end
