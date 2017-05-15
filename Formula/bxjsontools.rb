class bxjsontools < Formula
  desc "C++ Class Library for JSON serialization"
  homepage "https://github.com/BxCppDev/bxjsontools"

  stable do
    url "https://github.com/BxCppDev/bxjsontools",
      :using => :git,
      :tag => "0.1.0"
    version "0.1.0"
  end

  devel do
    url "https://github.com/BxCppDev/bxjsontools",
      :using => :git
  end

  option :cxx11
  option 'without-test', 'Disable test programs'

  depends_on "cmake" => :build
  # depends_on "boost"

  def install
    ENV.cxx11 if build.cxx11?
    mkdir "brew-bxjsontools-build" do
      args = std_cmake_args
      args << "-DBXJSONTOOLS_ENABLE_TESTING=OFF" if build.with? "without-test"
      system "cmake", "../", *args
      system "make"
      system "make", "test" if build.with? OS.linux?
      system "install"
    end
  end
end
