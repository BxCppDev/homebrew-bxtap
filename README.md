# homebrew-bxtap : Linuxbrew tap for the BxCppDev software suite

## Linuxbrew tap for the Bayeux software suite

This tap provides a set of Linuxbrew formulae to ease the installation
of the software packages released by the BxCppDev group.

We assume you have installed Linuxbrew on your system. Our philosophy is
not to *activate* Linuxbrew per default but only when it is needed on your
system. Recommended Linuxbrew installation and setup procedure is given below.

## Useful links:

* [Linuxbrew](http://linuxbrew.sh/)
* Brew tap [documentation](https://github.com/Homebrew/brew/blob/master/docs/brew-tap.md)
* Brew formulae [documentation](https://github.com/Homebrew/brew/raw/master/docs/Formula-Cookbook.md)
* [SuperNEMO-DBD](https://github.com/SuperNEMO-DBD)

## Installing Linuxbrew on your system

### Installation steps

Example for Ubuntu Linux 16.04:

1. Install dependencies:

```sh
$ sudo apt-get install build-essential curl git python-setuptools ruby
```

2. Clone the Linuxbrew GitHub repository:

```sh
$ git clone https://github.com/Linuxbrew/brew.git ${HOME}/linuxbrew
```

   *Note:* Here the ``HOME`` directory can be changed to any location of your filesystem
   for which you have write access.

3. Edit your ``~/.bashrc`` file and create a Bash setup function
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

From a bare shell, activate your Linuxbrew system:

```sh
$ export PATH="${HOME}/linuxbrew/bin:${PATH}
```

Then try install a package:

```sh
$ brew install hello
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
/path/to/Linuxbrew/installation/directory/bin:..
```

The ``brew`` executable will be immediately available from:

```sh
$ which brew
/path/to/Linuxbrew/installation/directory/bin/brew.
```

## Installation of ``homebrew-bxtap``

Once installed Linuxbrew on your system, you can install the ``homebrew-bxtap`` tap.

### Installation steps

1. Clone the ``homebrew-bxtap`` GitHub repository:

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

If you want to install a local copy of tap, before to push it on GitHub, run:

```sh
$ brew tap bxcppdev/homebrew-bxtap file:///path/to/your/homebrew-bxtap/local/git/repo
```

you'll be able to locally test a new formula before to push it on the origin GitHub repository.


4. Unregister the ``homebrew-bxtap`` tap from your Linuxbrew package manager:

```sh
$ brew untap bxcppdev/homebrew-bxtap
```

## List of available formulae

* ``bxjsontools``: The [BxJsontools](https://github.com/BxCppDev/bxjsontools/) C++ library for JSON serialization.
  Installation of the stable version:

```sh
$ brew install bxcppdev/bxtap/bxjsontools
```

* ``bxrabbitmq``: The [BxRabbitMQ](https://github.com/BxCppDev/bxrabbitmq/) C++ library for RabbitQ client and server management.
  Installation of the stable version:

```sh
$ brew install bxcppdev/bxtap/bxrabbitmq
```

* ``protobuf@3.3.0.rb``: The [Protocol Buffers](https://developers.google.com/protocol-buffers/)
  C++ library.
  Installation of the stable version:

```sh
$ brew install bxcppdev/bxtap/protobuf@3.3.0
```

* ``bxprotobuftools``: The [BxProtobuftools](https://github.com/BxCppDev/bxprotobuftools/) C++ library for Protocol Buffer based serialization.
  Installation of the stable version:

```sh
$ brew install bxcppdev/bxtap/bxprotobuftools
```
