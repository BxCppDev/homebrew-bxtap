class Bxrabbitmq < Formula
  desc "C++ RabbitMQ client and server management API"
  homepage "https://github.com/BxCppDev/bxrabbitmq"
  url "https://github.com/BxCppDev/bxrabbitmq/archive/0.3.0.tar.gz"
  version "0.3.0"
  sha256 "4630e430b36780c253c7a16fd5ae8b88aa57f9617c3e0ca35016f6647757eeed"
  head "https://github.com/BxCppDev/bxrabbitmq.git", :branch => "develop"

  needs :cxx11
  depends_on "bxcppdev/bxtap/cmake" => :build
  depends_on "rabbitmq-c"
  depends_on "pkg-config"

  option "without-test", "Inhibit test programs"
  option "with-manager", "Built the RabbitMQ server management API"
  if build.with? "manager"
    depends_on "bxcppdev/bxtap/bxjsontools"
    depends_on "bxcppdev/bxtap/curlpp"
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
