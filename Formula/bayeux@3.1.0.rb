class BayeuxAT310 < Formula
  desc "Bayeux 3.1.0 Library"
  homepage "https://github.com/BxCppDev/Bayeux"

  stable do
    version "3.1.0"
    url "https://github.com/BxCppDev/Bayeux/archive/Bayeux-3.1.0-alpha.tar.gz"
    sha256 "37df4ffbaf330fd2be7e152177a367f350b1c45acf484704b55fe1c2f8e12f0d"
  end

  option "with-devtools", "Build debug tools for Bayeux developers"
  option "with-test",     "Build test programs"
  option "with-geant4",   "Build Geant4 module"

  depends_on "bxcppdev/bxtap/cmake" => :build
  depends_on "bxcppdev/bxtap/doxygen" => :build
  depends_on "gsl"
  depends_on "readline"

  needs :cxx11
  depends_on "icu4c" => "c++11"
  depends_on "bxcppdev/bxtap/boost" => ["c++11", "with-icu4c"]
  depends_on "bxcppdev/bxtap/camp" => "c++11"
  depends_on "bxcppdev/bxtap/clhep" => "c++11"
  depends_on "bxcppdev/bxtap/qt5-base"
  if build.with? "geant4"
    depends_on "bxcppdev/bxtap/geant4" => "c++11"
  end
  depends_on "bxcppdev/bxtap/root6"

  def install
    ENV.cxx11
    mkdir "bayeux.build" do
      bx_cmake_args = std_cmake_args
      bx_cmake_args << "-DCMAKE_INSTALL_LIBDIR=lib"
      bx_cmake_args << "-DBAYEUX_CXX_STANDARD=11"
      bx_cmake_args << "-DBAYEUX_COMPILER_ERROR_ON_WARNING=OFF"
      bx_cmake_args << "-DBAYEUX_WITH_QT_GUI=ON"
      bx_cmake_args << "-DBAYEUX_WITH_DEVELOPER_TOOLS=OFF" unless build.with? "devtools"
      bx_cmake_args << "-DBAYEUX_ENABLE_TESTING=ON" if build.with? "test"
      bx_cmake_args << "-DBAYEUX_WITH_GEANT4_MODULE=OFF" if build.without? "geant4"
      system "cmake", "..", *bx_cmake_args
      system "make"
      if build.with? "test"
        system "make", "test"
      end
      system "make", "install"
    end
  end

  test do
    system "#{bin}/bxquery", "--help"
    system "#{bin}/bxg4_production", "--help"
  end
end
