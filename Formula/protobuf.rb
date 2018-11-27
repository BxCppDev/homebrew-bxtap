class Protobuf < Formula
  desc     "Protocol Buffers C++ API"
  homepage "https://developers.google.com/protocol-buffers/"

  url      "https://github.com/google/protobuf/archive/v3.3.0.tar.gz"
  version  "3.3.0"
  sha256   "9a36bc1265fa83b8e818714c0d4f08b8cec97a1910de0754a321b11e66eb76de"

  needs :cxx11
  #option "with-brew-gcc5", "Use Linuxbrew gcc5"

  option "with-java", "Build the Java Protocol Buffers runtime library"
  # option "with-brew-java", "Use Linuxbrew Java JDK"
  # option "with-brew-maven", "Use Linuxbrew Apache Maven"
  option "with-test", "Run build-time check"

  # depends_on "autoconf" => :build
  # depends_on "automake" => :build
  # depends_on "libtool" => :build
  # depends_on "curl" => :build
  # depends_on "make" => :build
  # if build.with? "brew-gcc5"
  #   depends_on "gcc5" => :build
  # end
  # depends_on "unzip" => :build

  # if build.with? "java"
  #   option "with-brew-java", "Use Linuxbrew Java jdk"
  # end

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
      # system "echo", "================ TEST JAVA ==============="
      # system "pwd"
      # system "echo", "#{buildpath}"
      system "mvn", "test"
      system "mvn", "install"
      system "mvn", "package"
      system "cp", "#{buildpath}/java/core/target/protobuf-java-3.3.0.jar",      "#{prefix}/bin/"
      system "cp", "#{buildpath}/java/util/target/protobuf-java-util-3.3.0.jar", "#{prefix}/bin/"
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
