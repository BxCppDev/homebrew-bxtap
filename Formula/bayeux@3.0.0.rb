# Imported from SuperNEMO-DBD/homebrew-cadfael/Formula/bayeux.rb

class BayeuxAT300 < Formula
  desc "Bayeux 3.0.0 Library"
  homepage "https://github.com/BxCppDev/Bayeux"

  stable do
    version "3.0.0"
    url "https://github.com/BxCppDev/Bayeux/archive/Bayeux-3.0.0.tar.gz"
    sha256 "fdaaac2dc738d0875b06b795a16d3017775f26de7f57ed836408b8c8a5349f3b"
  end

  keg_only "Conflicts with production version of Bayeux"

  option "with-devtools", "Build debug tools for Bayeux developers"
  option "with-test",     "Build test programs"

  # depends_on "cmake" => :build
  # depends_on "doxygen" => :build
  # depends_on "gsl"
  # depends_on "readline"

  # depends_on "icu4c" => "c++11"
  depends_on "bxcppdev/bxtap/boost" => ["c++11", "with-icu4c"]
  depends_on "bxcppdev/bxtap/camp" => "c++11"
  depends_on "bxcppdev/bxtap/clhep" => "c++11"
  depends_on "bxcppdev/bxtap/qt5-base"
  depends_on "bxcppdev/bxtap/geant4" => "c++11"
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
      system "cmake", "..", *bx_cmake_args
      system "make", "-j#{ENV.make_jobs}",
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
