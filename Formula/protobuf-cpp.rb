class ProtobufCpp < Formula
  desc "Protocol Buffers"
  homepage "https://developers.google.com/protocol-buffers/"
  url "https://github.com/google/protobuf/releases/download/v3.0.0/protobuf-cpp-3.0.0.tar.gz"
  version "3.0.0"
  sha256 "318e8f375fb4e5333975a40e0d1215e855b4a8c581d692eb0eb7df70db1a8d4e"

  option "with-test", "Run build-time check"

  needs :cxx11
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    ENV.cxx11
    system "./autogen.sh"
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
           "--prefix=#{prefix}", "--with-zlib"
    system "make"
    system "make", "check" if build.with?("test") || build.bottle?
    system "make", "install"
  end

  test do
    testdata = <<-EOS.undent
      syntax = "proto3";
      package test;
      message TestCase {
        string name = 4;
      }
      message Test {
        repeated TestCase case = 1;
      }
    EOS
    (testpath/"test.proto").write testdata
    system bin/"protoc", "test.proto", "--cpp_out=."
    #system "python", "-c", "import google.protobuf" if build.with? "python"
    #system "python3", "-c", "import google.protobuf" if build.with? "python3"
  end

end
