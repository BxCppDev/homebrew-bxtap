lass ProtobufJava < Formula
  desc "Protocol Buffers Java API"
  homepage "https://developers.google.com/protocol-buffers/"
  url "https://github.com/google/protobuf/releases/download/v3.0.0/protobuf-java-3.0.0.tar.gz"
  version "3.0.0"
  sha256 "411eb52ee294386cf04e0fcc5a68a93280c90d90908915f0ce2a28a695d42702"

  option "with-brew-java",  "Use Linuxbrew Java"
  option "with-brew-maven", "Use Linuxbrew Maven"

  if build.with? "brew-java"
    depends_on "jdk" => :build
  end
  if build.with? "brew-maven"
    depends_on "maven" => :build
  end
  depends_on "protobuf-cpp"

  def install
    system "cd" , "java"
    system "mvn" , "test"
    system "mvn" , "install"
    system "mvn" , "package"
    system "mkdir" , "#{prefix}"/lib/java/
    system "cp" , "./core/target/protobuf-java-3.0.0.jar",            "#{prefix}"/lib/java/
    system "cp" , "./core/target/protobuf-java-3.0.0.util-3.0.0.jar", "#{prefix}"/lib/java/
  end


end
