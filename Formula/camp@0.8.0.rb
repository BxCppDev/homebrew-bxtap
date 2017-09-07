class CampAT080 < Formula
  desc "Tegesoft C++ reflection library"
  homepage "https://github.com/tegesoft/camp"
  url "https://github.com/tegesoft/camp.git",
      :using => :git,
      :revision => "a07257adfde4fb8503bbb9675f83d727e3d65e22"
  version "0.8.0"

  option :cxx11
  needs :cxx11 if build.cxx11?

  option "with-system-cmake",   "Use system cmake"
  unless build.with? "system-cmake"
    depends_on "cmake" => :build
  end

  option "with-doxygen",        "Build with doxygen documentation"
  option "with-system-doxygen", "Use system doxygen"
  if build.with? "doxygen"
    unless build.with? "system-doxygen"
      # depends_on "bxcppdev/bxtap/doxygen" => [:optional, :build]
      depends_on "doxygen" => [:optional, :build]
    end
  end

  option "with-system-boost",   "Build with doxygen documentation"
  unless build.with? "system-boost"
    if build.cxx11?
      depends_on "bxcppdev/bxtap/boost" => "c++11"
    else
      depends_on "bxcppdev/bxtap/boost"
    end
  end

  def install
    system "touch", "LICENSE.LGPL3.txt"
    mkdir "brew-camp-build" do
      ENV.cxx11 if build.cxx11?
      system "cmake", "..", *std_cmake_args
      system "make"
      system "make", "doc" if build.with? "doxygen"
      system "make", "install"
    end
  end

  test do
    system "false"
  end
end
