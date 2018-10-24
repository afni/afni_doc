
.. _Download_AFNI:


**Download other/specific AFNI/SUMA software**
=================================================

.. contents:: :local:

Overview
--------

.. note:: If you are setting up your system for running AFNI, the main
          set of installation instructions for most operating systems
          is provided :ref:`on THIS page <install_page>`.

Here, we provide direct links for downloading precompiled AFNI
binaries, as well as the compilable source code. 

As of Jan. 1, 2016, AFNI utilizes a version numbering system, which is
useful for tracking changes, getting help on the `Message Board
<https://afni.nimh.nih.gov/afni/community/board/>`_, reporting in
published work, etc.  The version is reported using a trio of numbers,
corresponding to **"major.minor.micro"** (or roughly,
*"yearly.quarterly.oftenly"*) updates. You can discover the mystery
number on your own system by simply typing::

  afni -ver

This version number should *always* be provided when posting questions
on the `Message Board
<https://afni.nimh.nih.gov/afni/community/board/>`_.

.. note:: The record of changes (new options, new programs, bug fixes,
          et al.) is maintained for all the see in the online `AFNI
          History
          <https://afni.nimh.nih.gov/pub/dist/doc/misc/history/index.html>`_.


Update existing AFNI binaries
---------------------------------

If you already have AFNI binaries working on your computer, all you
need to do is run::

  @update.afni.binaries -d

This automatically detects which package to download and where to
install it. The new binaries are placed in the same location so you
can just keep rollin' along.  (The existing/old binaries are placed in
a subdirectory called ``auto_backup.BINARY_VERSION/``, just in case
you want them.)


Download current precompiled AFNI binaries
----------------------------------------------

To download particular a set of binaries, then you can click on a link
below for your desired system.  

Again, to go through full AFNI install for Linux, Mac or even now
*Windows 10* users, look at :ref:`install_page` instructions.

Unless otherwise stated, the binaries are for 64 bit systems.

.. _afni_bin_unix:

.. list-table::
   :header-rows: 1
   :widths: 40 60
   :align: left
   :stub-columns: 0
      
   * - **For Linux/Unix (and Windows users with Linux installed)**
     -
   * - `linux_ubuntu_16_64.tgz <https://afni.nimh.nih.gov/pub/dist/tgz/linux_ubuntu_16_64.tgz>`_ 
     - Ubuntu 16.04-17.10
   * - `linux_fedora_21_64.tgz <https://afni.nimh.nih.gov/pub/dist/tgz/linux_fedora_21_64.tgz>`_ 
     - Fedora 21+                            
   * - `linux_openmp_64.tgz <https://afni.nimh.nih.gov/pub/dist/tgz/linux_openmp_64.tgz>`_ 
     - Ubuntu (<16), Fedora (<21), Red Hat, etc. 
   * - `linux_centos_7_64.tgz <https://afni.nimh.nih.gov/pub/dist/tgz/linux_openmp_64.tgz>`_ 
     - CentOS, Red Hat (RHEL 7)

|

.. _afni_bin_mac:

.. list-table::
   :header-rows: 0
   :widths: 40 60
   :align: left
   :stub-columns: 0
      
   * - **For Mac OS**
     -   
   * - `macos_10.12_local.tgz <https://afni.nimh.nih.gov/pub/dist/tgz/macos_10.12_local.tgz>`_
     - Mac 10.12 and higher
   * - `macosx_10.7_local.tgz <https://afni.nimh.nih.gov/pub/dist/tgz/macosx_10.7_local.tgz>`_
     - Mac 10.7 - 10.11, **but NO LONGER UPDATED**

  .. _afni_bin_other:

-  **Binaries for other systems: the rest.**
   
   * - **For other systems**
     -   
   * - `linux_xorg7.tgz <https://afni.nimh.nih.gov/pub/dist/tgz/linux_xorg7.tgz>`_
     - 32 bit linux systems
   * - `linux_xorg7_64.tgz <https://afni.nimh.nih.gov/pub/dist/tgz/linux_xorg7_64.tgz>`_
     - possibly other Linux-- **but probably use use one of the above options**


.. _download_SRC:

To: download the AFNI source code
---------------------------------

Another way to get AFNI working on your computer (requiring a bit more
work) is to compile from the source itself:

  .. list-table::
     :header-rows: 0
     :widths: 40 60
     :align: left
     :stub-columns: 0
        
     * - `AFNI Source Code <https://afni.nimh.nih.gov/pub/dist/tgz/afni_src.tgz>`_
       - Compilable source (can be built on most Linux/Unix/Mac)

There are several usable, example ``Makefile``\s included in the main
``afni_src/`` directory, as well as a couple (mainly for Linux
systems) in ``afni_src/other_builds/``.

In all likelihood this option is pretty much only useful if you are
writing or contributing code yourself, or if your system is
particularly finicky.  Otherwise, it is likely far easier to grab a
set of recommended precompiled binaries of the :ref:`Linux/Unix
<afni_bin_unix>` or :ref:`Mac <afni_bin_mac>` variety.

To: browse all AFNI packages (and atlases)
------------------------------------------

The following is a browsable page that contains a tarball for each of
the precompiled platform versions:

`AFNI Software Packages <https://afni.nimh.nih.gov/pub/dist/tgz/>`_

It also contains several standard reference brains and demo data
sets. All files are downloadable by clicking on the links on the above
page, and also by using command line functions such as ``curl`` or
``wget``, such as::
  
  curl -O https://afni.nimh.nih.gov/pub/dist/tgz/TTatlas+tlrc.*
  wget https://afni.nimh.nih.gov/pub/dist/tgz/TTatlas+tlrc.*

NB: for most demo sets, there is an ``@Install_*`` command to procure
and open the directory.

|


.. old/unused binaries:

   * for `Mac OS X Mountain Lion (10.8 Intel), 64 bit
     <https://afni.nimh.nih.gov/pub/dist/tgz/macosx_10.7_Intel_64.tgz>`_.
 
   * for `Mac OS X Snow Leopard (10.6 Intel), 64 bit
     <https://afni.nimh.nih.gov/pub/dist/tgz/macosx_10.6_Intel_64.tgz>`_.

   * for `Mac OS X Snow Leopard (10.6 Intel), 64bit, no fink
     <https://afni.nimh.nih.gov/pub/dist/tgz/macosx_10.6_Intel_64.no.fink.tgz>`_.

   
   * for `Linux gcc32, 32 bit
     <https://afni.nimh.nih.gov/pub/dist/tgz/linux_gcc32.tgz>`_.

   * for `FreeBSD with ports (github)
     <https://github.com/outpaddling/freebsd-ports-wip>`_.

   * for `Solaris 2.9 suncc
     <https://afni.nimh.nih.gov/pub/dist/tgz/solaris29_suncc.tgz>`_.
