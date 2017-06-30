# homebrew-bxtap : Linuxbrew tap for the BxCppDev software suite

# Table of Contents
1. [Introduction](#introduction)
2. [Installing Linuxbrew on your system](#installing-linuxbrew-on-your-system)
3. [Installation of the tap](#installation-of-the-tap)
4. [List of available formulae](#list-of-available-formulae)
5. [Examples](#examples)
6. [Useful links](#useful-links)


## Introduction

This tap provides a set of Linuxbrew formulae to ease the installation
of the software packages released by the BxCppDev group.

We assume you have installed  Linuxbrew on your system. Our philosophy
is not to *activate* Linuxbrew per  default but only when it is needed
on your system. Recommended Linuxbrew installation and setup procedure
is given below.

## Installing Linuxbrew on your system

### Installation steps for Ubuntu Linux 16.04:

Here we assume you use a bash shell:

1.   Install dependencies:
```sh
$ sudo apt-get install build-essential curl git python-setuptools ruby
```

2.   Clone the Linuxbrew GitHub repository:
```sh
$ git clone https://github.com/Linuxbrew/brew.git ${HOME}/linuxbrew
```

	 *Note:* Here the ``HOME`` directory can be changed to any location of your filesystem
	 for which you have write access and also enough available storage capacity, depending on which software you
	 will need to manage through Linuxbrew (several Gb sounds reasonnable).

3.   Edit your ``~/.bashrc`` file and create a bash setup function for Linuxbrew:
```sh
function do_linuxbrew_setup()
{
  echo >&2 "[info] do_linuxbrew_setup: Setup Linuxbrew..."
  if [ -n "${LINUXBREW_INSTALL_DIR}" ]; then
     echo >&2 "[warning] do_linuxbrew_setup: Linuxbrew is already setup!"
     return 1
  fi
  export LINUXBREW_INSTALL_DIR="${HOME}/linuxbrew" # Change this to your
                                                   # Linuxbrew installation path
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
``~/.cache/Homebrew/``  on  Linux)   and  temporary  build  directories
(default:  ``/tmp``).  It  may  occur these  default  paths  are  not
suitable on your system or have  not enough storage capacity.  You can
explicitely define dedicated  directories to be used  during the build
process. For that, define the two following environment variables:
```sh
$ export HOMEBREW_TEMP=/some/directory/for/brew/driven/software/build
$ export HOMEBREW_CACHE=/some/directory/for/caching/brew/downloads
```
Such lines can be added in the setup script shown above (in function ``do_linuxbrew_setup``).

You may also want to force the installation of brew formulae from source only,
including dependencies. In that case, it is possible to set the following environment variable:
```sh
$ export HOMEBREW_BUILD_FROM_SOURCE=1
```


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
/path/to/Linuxbrew/installation/directory/bin/brew
```
and you will be able to  immediately enter a brew shell when needed:
```sh
$ brew sh
```

This is it! You are ready to enjoy Linuxbrew.

## Installation of the tap

Once  installed   and  setup  Linuxbrew   on  your  system,   you  can
install/register   the  ``bxcppdev/homebrew-bxtap``   tap  in   your  Linuxbrew
repository.

### Installation steps

1.   Setup Linuxbrew:
     ```sh
$ linuxbrew_setup
```

2.   Register the ``homebrew-bxtap`` tap in your Linuxbrew package manager:
	 ```sh
$ brew tap bxcppdev/homebrew-bxtap
```
	 The            tap            is            downloaded            from
	 ``https://github.com/BxCppDev/homebrew-bxtap.git``  and  installed  in
	 the         ``${HOME}/linuxbrew/Library/Taps/bxcppdev/homebrew-bxtap``
	 directory.

3.   If you want  to install a local  copy of the tap,  for example because
	 you want, as a BxCppDev developper or contributor, to test a brand new
	 formula, please run:
	 ```sh
$ brew tap bxcppdev/homebrew-bxtap file:///path/to/your/homebrew-bxtap/local/git/repo
```
	 You'll be able to locally debug and test a new formula from your local repository.

4.   You can deregister the ``homebrew-bxtap`` tap from your Linuxbrew package manager:
	 ```sh
$ brew untap bxcppdev/homebrew-bxtap
```

## List of available formulae


You can print the list of supported formulae published by ``bxcppdev/bxtap`` :

```sh
$ brew search bxcppdev/bxtap/
...
```

Details on supported formulae:

*   **Boost**: The [Boost](https://www.boost.org/) C++ library.
    Installation of the 1.63 version:
```sh
$ brew install bxcppdev/bxtap/boost --c++11
```

*   **Camp**: The [Camp](https://github.com/tegesoft/camp) C++ reflection library.
    Installation of the 0.8.0 version:
```sh
$ brew install bxcppdev/bxtap/camp --c++11
```

*   **CLHEP**: The [CLHEP](http://proj-clhep.web.cern.ch/proj-clhep/) C++ library for High Energy Physics.
    Installation of the 2.1.3.1 version:
```sh
$ brew install bxcppdev/bxtap/clhep --c++11
```

*   **Qt5** : The [Qt5](http://qt-project.org/) C++ core libraries.
    Installation of the 5.8.0 version:
```sh
$ brew install bxcppdev/bxtap/qt5-base --c++11
```

*   **Xerces-C**: The [Xerces-C](https://xerces.apache.org/xerces-c/) XML Parser.
    Installation of the 3.1.4 version:
```sh
$ brew install bxcppdev/bxtap/xerces-c --c++11
```

*   **Geant4**: The [Geant4](http://geant4.cern.ch/) C++ toolkit for the simulation of the
    passage of particles through matter.
    Installation of the 9.6.4 version:
```sh
$ brew install bxcppdev/bxtap/geant4 --c++11 --with-opengl-x11 --with-xerces-c
```

*   **Root** (version 6): The [Root](http://root.cern.ch/) Data Analysis Framework.
    Installation of the 6.08.06 version:
```sh
$ brew install bxcppdev/bxtap/root6 --c++11
```
    Specific command to be used in order to properly setup Root6 (can be added
    in the ``do_linuxbrew_setup`` function):
```sh
$ . $(brew --prefix root6)/libexec/thisroot.sh
```

*   **Protobuf**: The [Protocol Buffers](https://developers.google.com/protocol-buffers/)
    C++ and Java libraries.
    Installation of the 3.3.0 version:
```sh
$ brew install bxcppdev/bxtap/protobuf@3.3.0
```

*   **BxJsontools**: The [BxJsontools](https://github.com/BxCppDev/bxjsontools/)
    C++ library for JSON serialization.
    Installation of the 0.1.0 version (C++11):
```sh
$ brew install bxcppdev/bxtap/bxjsontools
```

*   **BxRabbitMQ**: The [BxRabbitMQ](https://github.com/BxCppDev/bxrabbitmq/)
    C++ library for RabbitQ client and server management.
    Installation of the 0.3.0 version:
```sh
$ brew install bxcppdev/bxtap/bxrabbitmq [--with-manager]
```

*   **BxProtobuftools**: The [BxProtobuftools](https://github.com/BxCppDev/bxprotobuftools/) C++ library for Protocol Buffer based serialization.
    Installation of the 0.2.0 version:
```sh
$ brew install bxcppdev/bxtap/bxprotobuftools
```

*   **Bayeux** (last release): The [Bayeux](http://github.com/BxCppDev) C++ library:
```sh
$ brew install bxcppdev/bxtap/bayeux --with-devtools --with-test
```

    Installation of Bayeux-3.0.0 :
```sh
$ brew install bxcppdev/bxtap/bayeux@3.0.0 --with-devtools --with-test
```

    Installation of Bayeux-3.1.0 :
```sh
$ brew install bxcppdev/bxtap/bayeux@3.1.0 --with-devtools --with-test
```

*   **Vire** : not available yet.


## Examples


### Install Bayeux

* Install the Bayeux last release:

   Installation step by step:
```
$ brew install cmake
$ brew install doxygen --build-from-source
$ brew install bxcppdev/bxtap/icu4c --c++11
$ brew install bxcppdev/bxtap/boost --c++11 --with-icu4c
$ brew install bxcppdev/bxtap/camp --c++11
$ brew install bxcppdev/bxtap/clhep --c++11
$ brew install bxcppdev/bxtap/qt5-base
$ brew install bxcppdev/bxtap/geant4 --c++11 \
	--with-opengl-x11 \
	--with-xerces-c
$ brew install bxcppdev/bxtap/root6
$ brew install bxcppdev/bxtap/bayeux \
    --with-devtools \
    --with-test \
    --ignore-dependencies
```

    One shot installation:
```sh
$ brew install bxcppdev/bxtap/bayeux \
	--with-devtools \
	--with-test
```

### Install Vire

WIP

## Useful links

*   [Linuxbrew](http://linuxbrew.sh/)
    -   Brew tap [documentation](https://github.com/Homebrew/brew/blob/master/docs/brew-tap.md)
	-   Brew formulae [documentation](https://github.com/Homebrew/brew/raw/master/docs/Formula-Cookbook.md)
*   [SuperNEMO-DBD](https://github.com/SuperNEMO-DBD) : original work on Linuxbrew support for [Bayeux](https://github.com/BxCppDev/Bayeux)
