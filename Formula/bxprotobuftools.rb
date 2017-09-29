class Bxprotobuftools < Formula
  desc     "C++ tools for Protocol Buffers based serialization"
  homepage "https://github.com/BxCppDev/bxprotobuftools"

  stable do
    url     "https://github.com/BxCppDev/bxprotobuftools/archive/0.2.1.tar.gz"
    version "0.2.1"
    sha256 "2ad1a9e78ad5e2a9f2e6c1fb2d4ced2308686ef543b8585978705eccfaba4095"
  end

  head do
    url     "https://github.com/BxCppDev/bxprotobuftools.git", :branch => "develop"
    version "0.3.0"
   end

  option "without-test", "Inhibit test programs"

  needs :cxx11
  # depends_on "bxcppdev/bxtap/cmake" => :build
  depends_on "cmake" => :build
  depends_on "bxcppdev/bxtap/protobuf@3.3.0"

  def install
    ENV.cxx11
    mkdir "brew-bxprotobuftools-build" do
      args = std_cmake_args
      args << "-DPROTOBUF_ROOT=#{HOMEBREW_PREFIX}/Cellar/protobuf@3.3.0/3.3.0"
      args << "-DBXPROTOBUFTOOLS_ENABLE_TESTING=OFF" if build.without? "test"
      system "cmake", "..", *args
      system "make"
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
