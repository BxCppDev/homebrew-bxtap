= homebrew-bxtap : Linuxbrew tap for the BxCppDev software suite

== Linuxbrew tap

This tap provides a set of Linuxbrew formulae to ease the installation
of the software packages released by the BxCppDev group.

We assume you have installed Linuxbrew on your system. Our philosophy is
not to *activate* Linuxbrew per default but only when it is needed on your
system. Recommended Linuxbrew installation and setup procedure is given below.


== Installing Linuxbrew on your system

Please have a look on  the [Linuxbrew](http://linuxbrew.sh/) site.

=== Installation steps

Example for Ubuntu Linux 16.04:

1. Install dependencies:
```sh
$ sudo apt-get install build-essential curl git python-setuptools ruby
```
2. Clone the Linuxbrew GitHub repository:
```sh
$ git clone https://github.com/Linuxbrew/brew.git ${HOME}/Linuxbrew
```
  *Note:* Here the ``HOME`` directory can be changed to any location of your filesystem for which you have write access.
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
  export LINUXBREW_INSTALL_DIR="${HOME}/Linuxbrew"
  export PATH="${LINUXBREW_INSTALL_DIR}/bin:${PATH}"
  export MANPATH="${LINUXBREW_INSTALL_DIR}/share/man:${MANPATH}"
  export INFOPATH="${LINUXBREW_INSTALL_DIR}/share/info:${INFOPATH}"
  echo >&2 "[info] do_linuxbrew_setup: Linuxbrew is setup."
  return 0
}
alias linuxbrew_setup='do_linuxbrew_setup'
```

=== Test Linuxbrew after installation

From a bare shell, activate your Linuxbrew system:
```sh
$ export PATH="${HOME}/Linuxbrew/bin:${PATH}
```

Then try install a package:
```sh
$ brew install hello
```

=== Setup Linuxbrew

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

== Installation of ``homebrew-bxtap``

Once installed Linuxbrew on your system, you can install the ``homebrew-bxtap`` tap.

=== Installation steps

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

== List of available formulae

* ``bxjsontools``: The [BxJsontools](https://github.com/BxCppDev/bxjsontools/) C++ library for JSON serialization.
```sh
$ brew install bxcppdev/bxtap/bxjsontools
```
