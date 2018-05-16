=============================
homebrew-bxtap Release Notes
=============================

.. contents:

Ubuntu 18.04 notes
==================

* Add ``fontconfig`` formula:

  * Used by the ``qt5-base`` formula:
  * Remove dependee ``libuuid`` formula and thus force to use the system library:

    .. code:: shell
	      
       $ sudo apt-get install libuuid1
..
