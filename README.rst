==============================================================
homebrew-bxtap : Linuxbrew tap for the BxCppDev software suite
==============================================================

.. image:: resources/logo/bxtap-256x256.png

.. contents::

Introduction
------------

This tap provides a set of Linuxbrew formulas to ease the installation
of the  software packages released  by the  BxCppDev group and  try to
solve  software  dependency  issues.  Linuxbrew is  not  the  ultimate
solution to solve package installation and dependency problems. It can
be  very useful  and  practical  but it  may  also  add some  software
management complexity and concern on some particular environment.

We assume you have installed  Linuxbrew on your system. Our philosophy
is not to *activate* Linuxbrew per  default but only when it is needed
on  your system,  mainly to  use the  tools provided  by the  BxCppDev
group.  Recommended Linuxbrew  installation and  setup procedures  are
given below.

Ubuntu  Linux being  our main  development system,  we give  here some
installation  and   configuration  hints  for  this   environment.  In
principle,  the  procedures  explained  below  should  work  on  other
distros, maybe with some minor changes. However, it is very difficult
for us to  guarantee it will work  for your own system;  we don't have
the resources to check all existing working envs.

Installing Linuxbrew on your system
-----------------------------------

We strongly  recommend that you  work from a  *bare* environment/shell
which means that your ``PATH`` environment variable should be as short
as possible  and confined for a  minimal system usage. Example  from a
bash shell on Ubuntu 16.04:

.. code:: sh

    $ echo $PATH
    /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/snap/bin

Ideally  the ``LD_LIBRARY_PATH``  environment variable  should not  be
used at  all, i.e. it  should **not** be  set in your  default working
environment      from      your     ``.bashrc``      profile      (see
https://blogs.oracle.com/ali/avoiding-ldlibrarypath%3a-the-options).
Our experience is that the use  of ``LD_LIBRARY_PATH`` by end users in
some arbitrary customer environment often ends with problems.

Installation steps for Ubuntu Linux 16.04:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Here we assume you use a bash shell:

#. Install  system  dependencies  required to  initiate  properly  the
   Linuxbrew installation:

   .. code:: sh

       $ sudo apt-get install build-essential curl git python-setuptools ruby

#. Clone the Linuxbrew GitHub repository:

   .. code:: sh

       $ git clone https://github.com/Linuxbrew/brew.git ${HOME}/linuxbrew

Note: Here  the ``HOME`` directory can  be changed to any  location of
your  filesystem for  which  you  have write  access  and also  enough
available storage capacity, depending on  which software you will need
to manage through Linuxbrew (several Gb sounds reasonnable).

#. Edit your ``~/.bashrc``  file and create a bash  setup function for
   Linuxbrew as well as a companion alias:

   .. code:: sh

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
         # Additional commands may be added from here:
         # export HOMEBREW_CACHE=/some/directory/for/caching/brew/downloads
         # export HOMEBREW_TEMP=/some/directory/for/building/brew/driven/software/packages
         # export HOMEBREW_BUILD_FROM_SOURCE=1
         # source $(brew --prefix root6)/libexec/thisroot.sh
         echo >&2 "[info] do_linuxbrew_setup: Linuxbrew is setup."
         return 0
       }
       alias linuxbrew_setup='do_linuxbrew_setup'

This approach allows to setup Linuxbrew only on explicit demand from a
given shell. IMHO, it is a bad practice to systematically load tons of
paths to all  the software binaries installed on your  system. You end
up with a very heavy environment,  polluted by plenty of software that
you won't  use during a specific  working session. Our credo  is thus:
*Activate only what you will use!*.

So, when you  want to use the Linuxbrew software,  open a terminal and
use the following alias (defined above):

.. code:: sh

    $ linuxbrew_setup

Then your shell is ready to go further with Linuxbrew and the software
it provides to you. When you  are done with Linuxbrew and its embedded
companions, simply terminate the shell. Of course, it is not a perfect
approach  and  it   may  not  cover  all  users'  needs   or  ways  of
working. Feel free to adapt according to your needs.

Test Linuxbrew after installation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

From a bare shell, *activate* your Linuxbrew system:

.. code:: sh

    $ export PATH="${HOME}/linuxbrew/bin:${PATH}"

Then install a dummy package:

.. code:: sh

    $ brew install hello  # Brew basic installation of the package 'hello'
    ...
    $ which hello
    /home/your-login/Linuxbrew/linuxbrew/bin/hello
    $ hello
    Bonjour, le monde !

Optional setup of temporary and cache directories
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Linuxbrew uses  default locations to store  downloaded files (default:
``~/.cache/Homebrew/``  on  Linux)  and  temporary  build  directories
(default: ``/tmp``). It may occur these default paths are not suitable
on  your  system  or  have   not  enough  storage  capacity.  You  can
explicitely define dedicated  directories to be used  during the build
process.  For  that, you  can  define  the two  following  environment
variables:

.. code:: sh

    $ export HOMEBREW_TEMP=/some/directory/for/building/brew/driven/software/packages
    $ export HOMEBREW_CACHE=/some/directory/for/caching/brew/downloads

Such lines can  be added in the setup script  shown above (in function
``do_linuxbrew_setup``).

You may  also want  to force  the installation  of brew  formulas from
source only, including  dependencies. In that case, it  is possible to
set the following environment variable:

.. code:: sh

    $ export HOMEBREW_BUILD_FROM_SOURCE=1

This will  prevent to  install any  brewed software  from pre-compiled
binary packages (*bottles*).

Setup Linuxbrew
~~~~~~~~~~~~~~~

Each time you  need to use Linuxbrew and software  packages managed by
Linuxbrew, you should use:

.. code:: sh

    $ linuxbrew_setup
..

Your ``PATH`` should then be updated to something like:

.. code:: sh

    $ echo $PATH
    /path/to/Linuxbrew/installation/directory/bin:/other/directories/in/your/path...
..

Thus  the Linuxbrew  binary path  has the  priority over  other paths,
including the system path.

The ``brew`` executable will be available from:

.. code:: sh

    $ which brew
    /path/to/Linuxbrew/installation/directory/bin/brew
..

and you will be able to immediately enter a brew shell when needed:

.. code:: sh

    $ brew sh
..

or use the ``brew`` command:

.. code:: sh

    $ brew help
..

This is it! You are ready to enjoy Linuxbrew.

Installation of the tap
-----------------------

Once  installed   and  setup  Linuxbrew   on  your  system,   you  can
install/register the ``bxcppdev/homebrew-bxtap`` tap in your Linuxbrew
repository.

Installation steps
~~~~~~~~~~~~~~~~~~

#. Setup Linuxbrew:

   .. code:: sh

       $ linuxbrew_setup

#. Register  the  ``bxcppdev/homebrew-bxtap``  tap in  your  Linuxbrew
   package manager:

   .. code:: sh

       $ brew tap bxcppdev/homebrew-bxtap

   The           tap            is           downloaded           from
   ``https://github.com/BxCppDev/homebrew-bxtap.git`` and installed locally in
   your    ``$(brew --prefix)/Library/Taps/bxcppdev/homebrew-bxtap``
   directory.

Additional useful commands
~~~~~~~~~~~~~~~~~~~~~~~~~~

A few more commands may be useful:

#. Prioritize  the ``bxcppdev/homebrew-bxtap``  tap in  your Linuxbrew
   package manager (see: http://docs.brew.sh/brew-tap.html):

   .. code:: sh

       $ brew tap-pin bxcppdev/homebrew-bxtap

#. If you want to install a local copy of the tap, for example because
   you want, as a BxCppDev developper  or contributor, to test a brand
   new formula, please run:

   .. code:: sh

      $ brew tap bxcppdev/homebrew-bxtap \
          file:///path/to/your/homebrew-bxtap/local/git/repo


   You'll be  able to locally debug  and test a new  formula from your
   local repository.

#. You can  deregister the ``homebrew-bxtap`` tap  from your Linuxbrew
   package manager:

   .. code:: sh

       $ brew tap-unpin bxcppdev/homebrew-bxtap
       $ brew untap bxcppdev/homebrew-bxtap

   However, I expect the packages previously installed through the tap
   should meet issues in a short term.

List of available formulas
--------------------------

You can print the list of supported formulas published by
``bxcppdev/bxtap`` :

.. code:: sh

    $ brew search bxcppdev/bxtap/
    ...

Details on supported formulas:

- **Boost**:
  The  `Boost   <https://www.boost.org/>`__  C++  library.
  Installation of the 1.63 version:

   .. code:: sh

       $ brew install bxcppdev/bxtap/boost --c++11

  Note: Linuxbrew/core provides its own Boost formulas.

- **Camp**:
  The   `Camp  <https://github.com/tegesoft/camp>`__   C++
  reflection library.  Installation of the 0.8.0 version:

   .. code:: sh

       $ brew install bxcppdev/bxtap/camp --c++11

- **CLHEP**:
  The `CLHEP <http://proj-clhep.web.cern.ch/proj-clhep/>`__
  C++ library for High Energy Physics.  Installation of the 2.1.3.1
  version:

   .. code:: sh

       $ brew install bxcppdev/bxtap/clhep --c++11

  Note: Linuxbrew provides its own CLHEP formula.

- **Qt5**   base:
  The   `Qt5  <http://qt-project.org/>`__   C++  core
  libraries.  Installation of the 5.8.0 version:

     .. code:: sh

	$ brew install bxcppdev/bxtap/qt5-base --c++11

  Note: Linuxbrew provides  its own QT5 formula  which conflicts with
  this qt5-base.

- **Xerces-C**:
  The `Xerces-C <https://xerces.apache.org/xerces-c/>`__
  XML parser.  Installation of the 3.1.4 version:

     .. code:: sh

	$ brew install bxcppdev/bxtap/xerces-c --c++11

  Note: Linuxbrew provides its own Xerces-C formula.

- **Geant4**:
  The `Geant4  <http://geant4.cern.ch/>`__ C++ toolkit for
  the   simulation   of   the    passage   of   particles   through
  matter. Installation of the 9.6.4 version:

     .. code:: sh

	$ brew install bxcppdev/bxtap/geant4 --c++11 \
	    --with-opengl-x11 \
	    --with-xerces-c

   Note: Linuxbrew provides its own Geant4 formula.

- **Root**  (version  6):
  The  `Root  <http://root.cern.ch/>`__  Data
  Analysis Framework.  Installation of the 6.08.06 version:

   .. code:: sh

       $ brew install bxcppdev/bxtap/root6 --c++11

  Note: Here is a command to be used in order to properly setup ROOT 6.X.
  It can be added in the ``do_linuxbrew_setup`` function:

   .. code:: sh

       $ . $(brew --prefix root6)/libexec/thisroot.sh

- **Protobuf**:
  The `Protocol Buffers <https://developers.google.com/protocol-buffers/>`__
  C++ and Java libraries. Installation of the 3.3.0 version:

   .. code:: sh

       $ brew install bxcppdev/bxtap/protobuf [--with-java] [--with-brew-java]

  Note: Linuxbrew provides its own  Protobuf formulas but they do not
  support Java.

- **BxJsontools**:
  The `BxJsontools <https://github.com/BxCppDev/bxjsontools/>`__
  C++   library  for
  JSON serialization. Installation of the 0.2.1 version (C++11):

  .. code:: sh

     $ brew install bxcppdev/bxtap/bxjsontools [--without-test]

- **BxRabbitMQ**:
  The `BxRabbitMQ <https://github.com/BxCppDev/bxrabbitmq/>`__
  C++  library   for
  RabbitMQ client and server management.  Installation of the 0.3.1
  version:

   .. code:: sh

       $ brew install bxcppdev/bxtap/bxrabbitmq [--with-manager]

- **BxProtobuftools**:
  The `BxProtobuftools <https://github.com/BxCppDev/bxprotobuftools/>`__
  C++ library for
  Protocol Buffer  based serialization.  Installation of  the 0.2.1
  version:

   .. code:: sh

       $ brew install bxcppdev/bxtap/bxprotobuftools

- **Bayeux** (last release):
  The `Bayeux <http://github.com/BxCppDev/Bayeux>`__ C++ library:

   .. code:: sh

       $ brew install bxcppdev/bxtap/bayeux --with-devtools --with-test

  -  Installation of Bayeux-3.0.0 :

      .. code:: sh

          $ brew install bxcppdev/bxtap/bayeux@3.0.0 --with-devtools --with-test

  -  Installation of Bayeux-3.1.0 :

      .. code:: sh

	 $ brew install bxcppdev/bxtap/bayeux@3.1.0 --with-devtools --with-test \
	     [--without-geant4]

-  **Vire** :
   The `Vire <http://github.com/BxCppDev/Vire>`__ C++ library (not available yet).

Examples
--------

Install the Bayeux last release step by step
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

* Brew some Linuxbrew modules from source:

   .. code:: sh

      $ export HOMEBREW_BUILD_FROM_SOURCE=1
      $ brew install cmake
      $ brew install readline
      $ brew install icu4c                   --c++11
      $ brew install gsl
      $ brew install bxcppdev/bxtap/doxygen
      $ brew install bxcppdev/bxtap/boost    --c++11 \
          --with-icu4c
      $ brew install bxcppdev/bxtap/camp     --c++11
      $ brew install bxcppdev/bxtap/clhep    --c++11
      $ brew install bxcppdev/bxtap/xerces-c --c++11
      $ brew install bxcppdev/bxtap/qt5-base
      $ brew install bxcppdev/bxtap/root6
      $ brew install bxcppdev/bxtap/geant4   --c++11  \
          --with-opengl-x11
      $ brew install bxcppdev/bxtap/bayeux

* Installation with all dependencies  automatically resolved and built
  from source:

   .. code:: sh

       $ export HOMEBREW_BUILD_FROM_SOURCE=1
       $ brew install bxcppdev/bxtap/bayeux

* Installation of the last unstable version:

   .. code:: sh

       $ brew install --devel bxcppdev/bxtap/bayeux

Install Vire
~~~~~~~~~~~~

WIP

#. Install system dependencies (Ubuntu 16.04):

   .. code:: sh

      $ sudo apt-get install openjdk-8-jdk
      $ sudo apt-get install maven

#. Install dependencies:

   .. code:: sh

      $ brew install bxcppdev/bxtap/protobuf
      $ brew install bxcppdev/bxtap/bxprotobuftools
      $ brew install bxcppdev/bxtap/bxjsontools
      $ brew install bxcppdev/bxtap/bxrabbitmq --with-manager

#. Install Bayeux (Geant4 module is not required):

   .. code:: sh

      $ brew install --devel bxcppdev/bxtap/bayeux --without-geant4

#. Install Vire: NOT AVAILABLE YET.

Useful links
------------

-  `Linuxbrew <http://linuxbrew.sh/>`__

   -  Brew tap
      `documentation <https://github.com/Homebrew/brew/blob/master/docs/brew-tap.md>`__
   -  Brew formulas
      `documentation <https://github.com/Homebrew/brew/raw/master/docs/Formula-Cookbook.md>`__

-  `SuperNEMO-DBD <https://github.com/SuperNEMO-DBD>`__ : original work
   on Linuxbrew support for
   `Bayeux <https://github.com/BxCppDev/Bayeux>`__
