# homebrew-bxtap : Linuxbrew tap for the BxCppDev software suite

## Introduction

This tap provides a set of Linuxbrew formulae to ease the installation
of the software packages released by the BxCppDev group.

We assume you have installed  Linuxbrew on your system. Our philosophy
is not to *activate* Linuxbrew per  default but only when it is needed
on your system. Recommended Linuxbrew installation and setup procedure
is given below.

## Useful links:

* [Linuxbrew](http://linuxbrew.sh/)
  * Brew tap [documentation](https://github.com/Homebrew/brew/blob/master/docs/brew-tap.md)
  * Brew formulae [documentation](https://github.com/Homebrew/brew/raw/master/docs/Formula-Cookbook.md)
* [SuperNEMO-DBD](https://github.com/SuperNEMO-DBD) : original work on Linuxbrew support for [Bayeux](https://github.com/BxCppDev/Bayeux)

## Installing Linuxbrew on your system

### Installation steps for Ubuntu Linux 16.04:

Here we assume you use a bash shell:

1. Install dependencies:

```sh
$ sudo apt-get install build-essential curl git python-setuptools ruby
```

2. Clone the Linuxbrew GitHub repository:

```sh
$ git clone https://github.com/Linuxbrew/brew.git ${HOME}/linuxbrew
```

   *Note:* Here the ``HOME`` directory can be changed to any location of your filesystem
   for which you have write access and also enough available storage capacity, depending on which software you
   will need to manage through Linuxbrew (several Gb sounds reasonnable).

3. Edit your ``~/.bashrc`` file and create a bash setup function
   for Linuxbrew:

```sh
function do_linuxbrew_setup()
{
  echo >&2 "[info] do_linuxbrew_setup: Setup Linuxbrew..."
  if [ -n "${LINUXBREW_INSTALL_DIR}" ]; then
     echo >&2 "[warning] do_linuxbrew_setup: Linuxbrew is already setup!"
     return 1
  fi
  export LINUXBREW_INSTALL_DIR="${HOME}/Linuxbrew" # Change this to suit your Linuxbrew installation path
  export PATH="${LINUXBREW_INSTALL_DIR}/bin:${PATH}"
  export MANPATH="${LINUXBREW_INSTALL_DIR}/share/man:${MANPATH}"
  export INFOPATH="${LINUXBREW_INSTALL_DIR}/share/info:${INFOPATH}"
  echo >&2 "[info] do_linuxbrew_setup: Linuxbrew is setup."
  return 0
}
alias linuxbrew_setup='do_linuxbrew_setup'
```

### Test Linuxbrew after installation

From a bare shell, *activate* your Linuxbrew system:

```sh
$ export PATH="${HOME}/linuxbrew/bin:${PATH}
```

Then try install a package:

```sh
$ brew install hello
```

### Optional setup of temporary and cache directories

Linuxbrew uses  default locations to store  downloaded files (default:
``~/.cache/Homebrew/`̀  on  Linux)   and  temporary  build  directories
(default:  ``/tmp``).  It  may  occurs these  default  paths  are  not
suitable on your system or have  not enough storage capacity.  You can
explicitely define dedicated  directories to be used  during the build
process. For that, define the two following environment variables:

```sh
$ export HOMEBREW_TEMP=/some/temporary/base/directory/for/brew/driven/software/installation
$ export HOMEBREW_CACHE=/some/cache/directory/for/brew/downloads
```
Such lines can be added in the setup script shown above (in function ``do_linuxbrew_setup``).

### Setup Linuxbrew

Each time you need to use Linuxbrew and software packages managed by Linuxbrew, you
should use:

```sh
$ linuxbrew_setup
```

Your ``PATH`` should then be updated to something like:

```sh
$ echo $PATH
/path/to/Linuxbrew/installation/directory/bin:/other/directories/in/your/path...
```

The ``brew`` executable will be available from:

```sh
$ which brew
/path/to/Linuxbrew/installation/directory/bin/brew.
```
and you will be able to  immediately enter a brew shell when needed:
```sh
$ brew sh
```

This is it! You are ready to enjoy Linuxbrew.

## Installation of ``homebrew-bxtap``

Once installed and setup Linuxbrew on your system, you can install the ``homebrew-bxtap`` tap.

### Installation steps

1. Clone the ``homebrew-bxtap`` GitHub repository into some local repository of your choice. Here we use
   ``${HOME}/BxCppDev/`` as the base directory for hosting Git repos from the ``BxCppDev`` organization:

```sh
$ mkdir -p ${HOME}/BxCppDev/
$ git clone https://github.com/BxCppDev/homebrew-bxtap.git ${HOME}/BxCppDev/homebrew-bxtap/
```

2. Setup Linuxbrew:

```sh
$ linuxbrew_setup
```

3. Register the ``homebrew-bxtap`` tap in your Linuxbrew package manager:

```sh
$ brew tap bxcppdev/homebrew-bxtap
```

The tap is downloaded from ``https://github.com/BxCppDev/homebrew-bxtap.git`` and
installed in the ``${HOME}/linuxbrew/Library/Taps/bxcppdev/homebrew-bxtap`` directory.

If you want to install a local copy of tap (for example before to push
it, as a BxCppDev developper, on the origin GitHub repository), please
run:

```sh
$ brew tap bxcppdev/homebrew-bxtap file:///path/to/your/homebrew-bxtap/local/git/repo
```

you'll be able to locally debug and test a new formula from your local repository.

4. You can deregister the ``homebrew-bxtap`` tap from your Linuxbrew package manager:

```sh
$ brew untap bxcppdev/homebrew-bxtap
```

## List of available formulae


You can print a list of supported formulae published by ``bxcppdev/bxtap`` :

```sh
$ brew search bxcppdev/bxtap/
```

Details on supported formulae:

* ``BxJsontools``: The [BxJsontools](https://github.com/BxCppDev/bxjsontools/)
  C++ library for JSON serialization.
  Installation of the 0.1.0 version (C++11):
```sh
$ brew install bxcppdev/bxtap/bxjsontools
```

* ``BxRabbitMQ``: The [BxRabbitMQ](https://github.com/BxCppDev/bxrabbitmq/)
  C++ library for RabbitQ client and server management.
  Installation of the 0.3.0 version:
```sh
$ brew install bxcppdev/bxtap/bxrabbitmq [--with-manager]
```

* ``Protobuf``: The [Protocol Buffers](https://developers.google.com/protocol-buffers/)
  C++ library.
  Installation of the 3.3.0 version:

```sh
$ brew install bxcppdev/bxtap/protobuf@3.3.0
```

* ``BxProtobuftools``: The [BxProtobuftools](https://github.com/BxCppDev/bxprotobuftools/) C++ library for Protocol Buffer based serialization.
  Installation of the 0.2.0 version:

```sh
$ brew install bxcppdev/bxtap/bxprotobuftools
```

* ``Boost``: The [Boost](https://www.boost.org/) C++ library.
  Installation of the 1.63 version:

```sh
$ brew install bxcppdev/bxtap/boost --cxx11
```

* ``bxcppdev/bxtap/camp``: The [Camp](https://github.com/tegesoft/camp) C++ library.
  Installation of the 0.8.0 version:

```sh
$ brew install bxcppdev/bxtap/camp --cxx11
```

* ``CLHEP``: The [CLHEP](http://proj-clhep.web.cern.ch/proj-clhep/) C++ library.
  Installation of the 2.1.3.1 version:

```sh
$ brew install bxcppdev/bxtap/clhep --cxx11
```

* ``Xerces-C``: The [Xerces-C](https://xerces.apache.org/xerces-c/) C++ library.
  Installation of the 3.1.4 version:

```sh
$ brew install bxcppdev/bxtap/xerces-c --cxx11
```

* ``Geant4``: The [Geant4](http://geant4.cern.ch/) C++ library.
  Installation of the 9.6.4 version:

```sh
$ brew install bxcppdev/bxtap/geant4 --cxx11
```

* ``Root`` (version 6): The [Root](http://root.cern.ch/) C++ library.
  Installation of the 6.08.06 version:

```sh
$ brew install bxcppdev/bxtap/root6 --cxx11
```

* ``Qt5`` : The [Qt5](http://qt-project.org/) C++ core libraries.
  Installation of 5.8.0 version:

```sh
$ brew install bxcppdev/bxtap/qt5-base --cxx11
```
