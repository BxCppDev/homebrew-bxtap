class Camp < Formula
  desc     "Tegesoft C++ reflection library"
  homepage "https://github.com/tegesoft/camp"
  url      "https://github.com/tegesoft/camp.git",
           :using => :git,
           :revision => "a07257adfde4fb8503bbb9675f83d727e3d65e22"
  version  "0.8.0"

  needs  :cxx11

  depends_on "cmake" => :build
  depends_on "bxcppdev/bxtap/boost"

  # This appears to be a more robust way of defining options
  # so that the dependency is always installed
  option "with-doxygen", "Build with doxygen documentation"
  if build.with? "doxygen"
    depends_on "doxygen" => [:optional, :build]
  end

  def install
    system "touch", "LICENSE.LGPL3.txt"
    mkdir "brew-camp-build" do
      ENV.cxx11
      system "cmake", "..", *std_cmake_args
      system "make", "-j#{ENV.make_jobs}"
      system "make", "doc" if build.with? "doxygen"
      system "make", "install"
    end
  end

  test do
    system "false"
  end
end
