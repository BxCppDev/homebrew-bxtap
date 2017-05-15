class Bxrabbitmq < Formula
  desc "C++ RabbitMQ client and server management API"
  homepage "https://github.com/BxCppDev/bxrabbitmq"
  url "https://github.com/BxCppDev/bxrabbitmq/archive/0.1.0.tar.gz"
  version "0.1.0"
  sha256 "eada5771b6b2a6f558cc57e0f664c8578bd77523f4155e3032555f74f60433b2"

  needs :cxx11
  depends_on "cmake" => :build
  depends_on "rabbitmq-c"
  depends_on "pkg-config"

  option "with-manager", "Built the RabbitMQ server management API"
  if build.with? "manager"
    depends_on "bxjsontools" => [:optional, "with-manager"]
    depends_on "curlpp" => [:optional, "with-manager"]
  end

  def install
    ENV.cxx11
    mkdir "brew-bxrabbitmq-build" do
      args = std_cmake_args
      args << "-DBXRABBITMQ_WITH_MANAGER=ON" if build.with? "manager"
      args << "-DBxJsontools_DIR=#{prefix}/lib/cmake/" if build.with? "manager"
      system "cmake", "..", *args
      system "make"
      system "make", "install"
    end
  end

  test do
    system bin/"bxrabbitmq-query", "--help"
  end

end
