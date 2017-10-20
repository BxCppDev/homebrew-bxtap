class BayeuxAT310 < Formula
  desc     "Bayeux 3.1.0 Library"
  homepage "https://github.com/BxCppDev/Bayeux"

  stable do
    version "3.1.0"
    url     "https://github.com/BxCppDev/Bayeux/archive/Bayeux-3.1.0.tar.gz"
    sha256  "c335aaa813bf305f1bcb1aa5e3d4f279f4f1d55cddf6116e39ced8e35329a061"
  end

  devel do
    version "3.2.0"
    url     "https://github.com/BxCppDev/Bayeux.git",
            :branch => "release-3.1.0"
  end

  option "without-devtools", "Do not build additional tools for Bayeux developers"
  option "without-test",     "Do not build test programs"
  option "without-geant4",   "Do not build Geant4 module"
  option "with-lahague",     "Build lahague module"
  option "with-qt-gui",      "Build with Qt GUI components"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "gsl"
  depends_on "readline"

  needs :cxx11
  depends_on "icu4c" => "c++11"
  depends_on "bxcppdev/bxtap/boost" => ["c++11", "with-icu4c"]
  depends_on "bxcppdev/bxtap/camp" => "c++11"
  depends_on "bxcppdev/bxtap/clhep" => "c++11"
  if build.with? "qt-gui"
    depends_on "bxcppdev/bxtap/qt5-base"
  end
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
      bx_cmake_args << "-DBAYEUX_WITH_QT_GUI=ON" if build.with? "qt-gui"
      bx_cmake_args << "-DBAYEUX_WITH_DEVELOPER_TOOLS=OFF" unless build.with? "devtools"
      bx_cmake_args << "-DBAYEUX_ENABLE_TESTING=ON" if build.with? "test"
      bx_cmake_args << "-DBAYEUX_WITH_GEANT4_MODULE=OFF" if build.without? "geant4"
      bx_cmake_args << "-DBAYEUX_WITH_LAHAGUE=ON" if build.with? "lahague"
      system "cmake", "..", *bx_cmake_args
      system "make", "-j"
      if build.with? "test"
        system "make", "test"
      end
      system "make", "install"
    end
  end

  test do
    system "#{bin}/bxquery", "--help"
    if build.with? "geant4"
      system "#{bin}/bxg4_production", "--help"
    end
  end
end
