# coding: utf-8
class ClhepAT2410 < Formula
  desc     "C++ Class Library for High Energy Physics"
  homepage "http://proj-clhep.web.cern.ch/proj-clhep/"
  url      "http://proj-clhep.web.cern.ch/proj-clhep/DISTRIBUTION/tarFiles/clhep-2.4.1.0.tgz"
  sha256   "d14736eb5c3d21f86ce831dc1afcf03d423825b35c84deb6f8fd16773528c54d"

  needs :cxx11

  depends_on "cmake" => :build

  def install
    ENV.cxx11
    mkdir "clhep-build" do
      system "cmake", "../CLHEP", *std_cmake_args
      system "make", "-j#{ENV.make_jobs}", "install"
    end
  end

  test do
    (testpath/"test.cpp").write <<-EOS.undent
      #include <iostream>
      #include <Vector/ThreeVector.h>

      int main() {
        CLHEP::Hep3Vector aVec(1, 2, 3);
        std::cout << "r: " << aVec.mag();
        std::cout << " phi: " << aVec.phi();
        std::cout << " cos(theta): " << aVec.cosTheta() << std::endl;
        return 0;
      }
    EOS
    system ENV.cxx, "-L#{lib}", "-lCLHEP", "-I#{include}/CLHEP",
           testpath/"test.cpp", "-o", "test"
    assert_equal "r: 3.74166 phi: 1.10715 cos(theta): 0.801784",
                 shell_output("./test").chomp
  end
end
