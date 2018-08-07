class Geant4AT1042 < Formula
  desc     "C++ toolkit for simulating the passage of particles through matter"
  homepage "http://geant4.cern.ch"
  revision 1

  stable do
    url     "http://geant4.cern.ch/support/source/geant4.10.04.p02.tar.gz"
    version "10.4.2"
    sha256  "997220a5386a43ac8f533fc7d5a8360aa1fd6338244d17deeaa583fb3a0f39fd"
  end

  needs :cxx11

  # option "with-opengl-x11", "Build OpenGL X11 driver" if OS.linux?
  option "with-notimeout", "Set notimeout in installing data"

  depends_on "cmake" => :build
  # depends_on "expat" if OS.linux?
  depends_on "bxcppdev/bxtap/clhep" 
  depends_on "bxcppdev/bxtap/xerces-c" 

  def install
    ENV.cxx11 
    mkdir "brew-geant4-build" do
      args = std_cmake_args
      args << "-DCMAKE_INSTALL_LIBDIR=lib"
      args << "-DCMAKE_BUILD_WITH_INSTALL_RPATH=ON"
      args << "-DGEANT4_BUILD_CXXSTD=c++11"
      args << "-DGEANT4_INSTALL_DATA=ON"
      args << "-DGEANT4_INSTALL_DATA_TIMEOUT=86400" if build.with? "notimeout"
      args << "-DGEANT4_USE_SYSTEM_CLHEP=ON"
      args << "-DCLHEP_ROOT_DIR=#{HOMEBREW_PREFIX}/lib"
      args << "-DGEANT4_USE_SYSTEM_EXPAT=ON"
      args << "-DGEANT4_USE_SYSTEM_ZLIB=ON"
      args << "-DGEANT4_USE_GDML=ON"
      args << "-DXERCESC_ROOT_DIR=#{HOMEBREW_PREFIX}/lib" 
      args << "-DGEANT4_USE_OPENGL_X11=ON" 

      system "cmake", "../", *args
      system "make", "-j#{ENV.make_jobs}", "install"
    end
  end

  test do
    system "false"
  end
end
