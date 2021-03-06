class Geant4AT964 < Formula
  desc     "C++ toolkit for simulating the passage of particles through matter"
  homepage "http://geant4.cern.ch"
  revision 5

  stable do
    url     "http://geant4.cern.ch/support/source/geant4.9.6.p04.tar.gz"
    version "9.6.4"
    sha256  "997220a5386a43ac8f533fc7d5a8360aa1fd6338244d17deeaa583fb3a0f39fd"
    patch do
      url    "https://files.warwick.ac.uk/supernemo/files/Cadfael/distfiles/geant4-9.6.4-data-export.patch"
      sha256 "6d7b50f504b53c924dfae28562726b839e191c4c78139dfa33040dfd460aebed"
    end
    patch do
      url    "https://files.warwick.ac.uk/supernemo/files/Cadfael/distfiles/geant4-9.6.4-xcode.patch"
      sha256 "0efa7f5b6c25f20493a3268dbd492ee3334f7839d2008554d57584ec9e4e7617"
    end
    patch do
      url    "https://files.warwick.ac.uk/supernemo/files/Cadfael/distfiles/geant4-9.6.4-c11.patch"
      sha256 "c99f760125f185f436a9191c5cdbad7053e7c41aaac0f6ccbacab392787f39a9"
    end
    patch do
      url    "https://files.warwick.ac.uk/supernemo/files/Cadfael/distfiles/geant4-9.6.4-xercesc-include.patch"
      sha256 "668d78b7c24efe9065a4e1aadd5441c129a454113eae96812c77a2c8861bfa64"
    end
    patch do
      url    "https://files.warwick.ac.uk/supernemo/files/Cadfael/distfiles/geant4-9.6.4-infinite-recursion.patch"
      sha256 "7ee817311d36f0b49f7af9dd5e024c406210e58cc2868e2a49387eb04c99400e"
    end
  end

  option "with-notimeout", "Set notimeout in installing data"

  # depends_on "cmake" => :build
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
      # args << "-DGEANT4_USE_SYSTEM_ZLIB=ON"
      args << "-DGEANT4_USE_GDML=ON"
      args << "-DGEANT4_USE_OPENGL_X11=ON" 

      system "cmake", "../", *args
      system "make", "-j#{ENV.make_jobs}", "install"
    end
  end

  test do
    system "false"
  end
end
