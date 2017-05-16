class Bxrabbitmq < Formula
  desc "C++ RabbitMQ client and server management API"
  homepage "https://github.com/BxCppDev/bxrabbitmq"
  url "https://github.com/BxCppDev/bxrabbitmq/archive/0.2.0.tar.gz"
  version "0.2.0"
  sha256 "f975d86359c6550ca68b73c8954543aeafa147f3c3dbc6f396784bd8bcccd5dd"

  needs :cxx11
  depends_on "cmake" => :build
  depends_on "rabbitmq-c"
  depends_on "pkg-config"

  option "without-test", "Inhibit test programs"
  option "with-manager", "Built the RabbitMQ server management API"
  if build.with? "manager"
    depends_on "bxjsontools" => [:optional, "with-manager"]
    depends_on "curlpp" => [:optional, "with-manager"]
  end

  def install
    ENV.cxx11
    mkdir "brew-bxrabbitmq-build" do
      args = std_cmake_args
      args << "-DBXRABBITMQ_ENABLE_TESTING=OFF"        if build.without? "test"
      args << "-DBXRABBITMQ_WITH_MANAGER=ON"           if build.with? "manager"
      args << "-DBxJsontools_DIR=#{prefix}/lib/cmake/" if build.with? "manager"
      system "cmake", "..", *args
      system "make"
      if build.with? "test"
        system "make", "test"
      end
      system "make", "install"
    end
  end

  test do
    system bin/"bxrabbitmq-query", "--help"
  end

end
