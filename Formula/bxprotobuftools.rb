class Bxprotobuftools < Formula
  desc "C++ tools for Protocol Buffers based serialization"
  homepage "https://github.com/BxCppDev/bxprotobuftools"
  url "https://github.com/BxCppDev/bxprotobuftools/archive/0.2.0.tar.gz"
  version "0.2.0"
  sha256 "47f4b4010a96876bae8673531ce85469848fc1dc0d9c05c8dc0d5bcced2ffd16"
  head "https://github.com/BxCppDev/bxprotobuftools.git", :branch => "develop"

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
