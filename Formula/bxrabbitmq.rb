class Bxrabbitmq < Formula
  desc     "C++ RabbitMQ client and server management API"
  homepage "https://github.com/BxCppDev/bxrabbitmq"

  stable do
    url     "https://github.com/BxCppDev/bxrabbitmq/archive/0.3.1.tar.gz"
    version "0.3.1"
    sha256   "0ac8e1b3b22c491601e49a364c504f29c3d559394a34817840626dfbb8119379"
   end

  head do
    url     "https://github.com/BxCppDev/bxrabbitmq.git", :branch => "develop"
    version "0.4.0"
  end

  needs :cxx11

  depends_on "cmake" => :build
  depends_on "rabbitmq-c"
  depends_on "pkg-config"

  option "without-test", "Inhibit test programs"
  option "with-manager", "Built the RabbitMQ server management API"
  if build.with? "manager"
    depends_on "bxcppdev/bxtap/bxjsontools"
    depends_on "curlpp"
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
