class Bxjsontools < Formula
  desc "C++ Class Library for JSON serialization"
  homepage "https://github.com/BxCppDev/bxjsontools"

  head "https://github.com/BxCppDev/bxjsontools",
      :branch => "master",
      :tag => "0.1.0"

  option 'without-test', 'Disable test programs'

  depends_on "cmake" => :build
  # depends_on "boost"

  def install
    ENV.cxx11
    mkdir "brew-bxjsontools-build" do
      args = std_cmake_args
      args << "-DBXJSONTOOLS_ENABLE_TESTING=OFF" if build.with? "without-test"
      system "cmake", "../", *args
      system "make"
      ### system "make", "test" if not build.with? "without-test"
      system "install"
    end
  end
end
