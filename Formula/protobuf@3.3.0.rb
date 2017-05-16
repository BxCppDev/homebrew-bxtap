class ProtobufAT330 < Formula
  desc "Protocol Buffers C++ API"
  homepage "https://developers.google.com/protocol-buffers/"
  url "https://github.com/google/protobuf/archive/v3.3.0.tar.gz"
  version "3.3.0"
  sha256 "94c414775f275d876e5e0e4a276527d155ab2d0da45eed6b7734301c330be36e"

  needs :cxx11
  option "with-java", "Build the Java Protocol Buffers runtime library"
  option "with-test", "Run build-time check"
  option "with-brew-build", "Use Linuxbrew build tools"

  if  build.with? "brew-build"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
    # depends_on "curl" => :build
    # depends_on "make" => :build
    # depends_on "gcc5" => :build
    # depends_on "unzip" => :build
  end

  if  build.with? "java"
    option "with-brew-java", "Use Linuxbrew Java jdk"
  end

  def install
    ENV.cxx11
    system "./autogen.sh"
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
           "--prefix=#{prefix}", "--with-zlib"
    system "make"
    system "make", "check" if build.with?("test") || build.bottle?
    system "make", "install"
    if build.with? "java"
      Dir.chdir("./java/")
      system "mvn", "test"
      system "mvn", "install"
      system "mvn", "package"
      system "cp" , "./core/target/protobuf-java-3.0.0.jar",            "#{prefix}/lib/"
      system "cp" , "./core/target/protobuf-java-3.0.0.util-3.0.0.jar", "#{prefix}/lib/"
    end

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
