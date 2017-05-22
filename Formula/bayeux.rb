# Imported from SuperNEMO-DBD/homebrew-cadfael/Formula/bayeux.rb

class Bayeux < Formula
  desc "Bayeux Library"
  homepage "https://github.com/BxCppDev/Bayeux"

  stable do
    version "3.0.0"
    url "https://github.com/BxCppDev/Bayeux/archive/Bayeux-3.0.0.tar.gz"
    sha256 "fdaaac2dc738d0875b06b795a16d3017775f26de7f57ed836408b8c8a5349f3b"
  end

  head do
    version "3.0.0"
    url "https://github.com/BxCppDev/Bayeux.git"
  end

  depends_on "cmake" => :build

  option "with-devtools", "Build debug tools for Bayeux developers"

  option "with-brew-doxygen", "Use Linuxbrew Doxygen"
  option "with-brew-gsl", "Use Linuxbrew GNU Scientific Library (GSL)"
  option "with-brew-readline", "Use Linuxbrew readline Library"
  option "with-brew-qt5", "Use Linuxbrew QT5 Core Libraries"

  if  build.with? "brew-doxygen"
    depends_on "bxcppdev/bxtap/doxygen" => :build
  end

  if  build.with? "brew-gsl"
    depends_on "gsl"
  end

  if  build.with? "brew-readline"
    depends_on "readline"
  end

  needs :cxx11
  depends_on "icu4c" => "c++11"
  depends_on "bxcppdev/bxtap/boost" => ["c++11", "with-icu4c"]
  depends_on "bxcppdev/bxtap/camp" => "c++11"
  depends_on "bxcppdev/bxtap/clhep" => "c++11"
  depends_on "bxcppdev/bxtap/geant4" => "c++11"
  depends_on "bxcppdev/bxtap/root6"
  depends_on "bxcppdev/bxtap/qt5-base"

  # if  build.with? "brew-qt5"
  #   depends_on "bxcppdev/bxtap/qt5-base"
  # end

  def install
    ENV.cxx11
    mkdir "bayeux.build" do
      bx_cmake_args = std_cmake_args
      bx_cmake_args << "-DCMAKE_INSTALL_LIBDIR=lib"
      bx_cmake_args << "-DBAYEUX_CXX_STANDARD=11"
      bx_cmake_args << "-DBAYEUX_COMPILER_ERROR_ON_WARNING=OFF"
      bx_cmake_args << "-DBAYEUX_WITH_QT_GUI=ON"
      bx_cmake_args << "-DBAYEUX_WITH_DEVELOPER_TOOLS=OFF" unless build.with? "devtools"
      system "cmake", "..", *bx_cmake_args
      system "make", "install"
    end
  end

  test do
    system "#{bin}/bxquery", "--help"
    system "#{bin}/bxg4_production", "--help"
  end
end
