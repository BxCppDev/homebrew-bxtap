class Bxrabbitmq < Formula
  desc     "C++ RabbitMQ client and server management API"
  homepage "https://github.com/BxCppDev/bxrabbitmq"

  stable do
    url     "https://github.com/BxCppDev/bxrabbitmq/archive/0.4.1.tar.gz"
    version "0.4.2"
    sha256  "34d7379698ef09d5e1fcc19d37c66e4434654bcb5f8ffae3930d508f49076af1"
   end

  head do
    url     "https://github.com/BxCppDev/bxrabbitmq.git", :branch => "master"
    version "0.4.3"
  end

  devel do
    url     "https://github.com/BxCppDev/bxrabbitmq.git", :branch => "develop"
    version "0.4.3"
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
      system "make", "-j#{ENV.make_jobs}"
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
