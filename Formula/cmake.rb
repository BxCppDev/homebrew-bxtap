class Cmake < Formula
  desc "Cross-platform make"
  homepage "https://www.cmake.org/"
  url "https://cmake.org/files/v3.8/cmake-3.8.2.tar.gz"
  sha256 "da3072794eb4c09f2d782fcee043847b99bb4cf8d4573978d9b2024214d6e92d"
  head "https://cmake.org/cmake.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "2bbeaf0866446737719aca74468290101b0c502065a02ad6e286f69fc0e69c77" => :sierra
    sha256 "74ecc634b8cc6facc828cc434ec16383681736c3c2fc42dd144f78e88bd34842" => :el_capitan
    sha256 "9b53dec241998124c67645be81c8e85db097404115e466cf409caf43add783ae" => :yosemite
    sha256 "2333063099a26e1bc386248e882727c0f41ffa6c1852b63b733d98cd18eb5b07" => :x86_64_linux
  end

  devel do
    url "https://cmake.org/files/v3.9/cmake-3.9.0-rc5.tar.gz"
    sha256 "3ef250f93f1887d99c567542e987938bf1cb49af06275e0081b547765e03e6ac"
  end

  option "without-docs", "Don't build man pages"
  option "with-completion", "Install Bash completion (Has potential problems with system bash)"

  depends_on "sphinx-doc" => :build if build.with? "docs"
  unless OS.mac?
    depends_on "bzip2"
    #depends_on "curl"
    depends_on "libidn" => :optional
    depends_on "ncurses"
  end

  # The `with-qt` GUI option was removed due to circular dependencies if
  # CMake is built with Qt support and Qt is built with MySQL support as MySQL uses CMake.
  # For the GUI application please instead use `brew cask install cmake`.

  def install
    # Reduce memory usage below 4 GB for Circle CI.
    ENV.deparallelize if ENV["CIRCLECI"]

    args = %W[
      --prefix=#{prefix}
      --no-system-libs
      --parallel=#{ENV.make_jobs}
      --datadir=/share/cmake
      --docdir=/share/doc/cmake
      --mandir=/share/man
      --system-zlib
      --system-bzip2
      --system-curl
    ]

    if build.with? "docs"
      # There is an existing issue around macOS & Python locale setting
      # See https://bugs.python.org/issue18378#msg215215 for explanation
      ENV["LC_ALL"] = "en_US.UTF-8"
      args << "--sphinx-man" << "--sphinx-build=#{Formula["sphinx-doc"].opt_bin}/sphinx-build"
    end

    system "./bootstrap", *args
    system "make"
    system "make", "install"

    if build.with? "completion"
      cd "Auxiliary/bash-completion/" do
        bash_completion.install "ctest", "cmake", "cpack"
      end
    end

    elisp.install "Auxiliary/cmake-mode.el"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(Ruby)")
    system bin/"cmake", "."
  end
end
