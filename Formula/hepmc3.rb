# coding: utf-8
class Hepmc3 < Formula
  desc     "HepMC event record C++ Library"
  homepage "http://hepmc.web.cern.ch/hepmc/"
  url      "http://hepmc.web.cern.ch/hepmc/releases/hepmc3.0.0.tgz"
  sha256   "7ac3c939a857a5ad67bea1e77e3eb16e80d38cfdf825252ac57160634c26d9ec"

  needs  :cxx11

  option "with-root-io", "Enable ROOT I/O"
  option "with-examples", "Build examples"
  option "with-interfaces", "Installation of HepMC3 interfaces"

  # depends_on "cmake" => :build
  depends_on "bxcppdev/bxtap/root6" => ["with-root-io"]

  def install
    ENV.cxx11
    mkdir "hepmc-build" do
      hepmc_cmake_args = std_cmake_args
      hepmc_cmake_args << "-DROOT_DIR=#{prefix}" if build.with? "root-io"
      hepmc_cmake_args << "-DHEPMC_ENABLE_ROOTIO=OFF" if build.without? "root-io"
      hepmc_cmake_args << "-DHEPMC_BUILD_EXAMPLES=ON" if build.with? "examples"
      hepmc_cmake_args << "-DHEPMC_INSTALL_INTERFACES=ON" if build.with? "interfaces"
      system "cmake", "..", *hepmc_cmake_args
      system "make", "-j#{ENV.make_jobs}", "install"
    end
  end
end
