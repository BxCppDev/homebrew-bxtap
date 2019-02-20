# coding: utf-8
class Bxdecay0 < Formula
  desc     "Monte Carlo nuclear decay generation C++ library"
  homepage "https://github.com/BxCppDev/bxdecay0"
  url      "https://github.com/BxCppDev/bxdecay0/archive/1.0.0-alpha.tar.gz"
  sha256   "dfd856f911e16bee35272001fcc2fa790a2b882054b943ad792d1112a48dafda"
  version  "1.0.0"

  head do
    url     "https://github.com/BxCppDev/bxdecay0.git", :branch => "master"
    version "1.0.0"
  end

  devel do
    url     "https://github.com/BxCppDev/bxdecay0.git", :branch => "develop"
    version "1.1.0"
  end

  # depends_on "cmake" => :build
  # depends_on "gsl"

  option "without-test", "Inhibit test programs"

  def install
    ENV.cxx11
    mkdir "bxdecay0-build" do
      bxdecay0_cmake_args = std_cmake_args
      bxdecay0_cmake_args << "-DROOT_DIR=#{prefix}" if build.with? "root-io"
      bxdecay0_cmake_args << "-DBXDECAY0_ENABLE_TESTING=OFF" if build.without? "test"
      system "cmake", "..", *bxdecay0_cmake_args
      system "make", "-j#{ENV.make_jobs}"
      # Do not run test programs for now,
      # they need a dedicated BXDECAY0_RESOURCE_DIR env.
      # if build.with? "test"
      #   system "make", "test"
      # end
      system "make", "install"
    end
  end

  test do
    system bin/"bxdecay0-query", "--help"
  end

end
