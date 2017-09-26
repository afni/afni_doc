
.. _Download_AFNI:


**Downloading other/specific AFNI/SUMA software**
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

Some additional introductory reading is available `here
<https://afni.nimh.nih.gov/afni/doc/first>`_.  


To: update existing AFNI binaries
---------------------------------

If you already have AFNI binaries working on your computer, all you
need to do is run::

  @update.afni.binaries -d

This will automatically detect which binary version to download and
where to install it (based on location of the present binaries), and
then it will unpackage the new binaries so you can just keep rollin'
along.  (It will also make an automatic backup of your existing
binaries in a subdirectory called ``auto_backup.BINARY_VERSION/``,
just in case you want it.)

|

To: download current precompiled AFNI binaries
----------------------------------------------

If you *don't* have AFNI on your computer already, or if you just want
to download particular a set of binaries, then you can click on a link
below to get the code for your desired system.  Note that most Mac,
Linux and even now *Windows 10* users should look at
:ref:`install_page` instructions for simplest setups.

If you *do* decide to download binaries from links directly, you will
likely still need to install supplmentary packages to run AFNI
successfully. For help with that (and for seeing handy command line
tools to check if things are OK), please see :ref:`install_page`.

.. _afni_bin_unix:

- **Recommended binaries for (most) Linux/Unix:**

  .. list-table::
     :header-rows: 0
     :widths: 40 60
     :align: left
     :stub-columns: 0
        
     * - `Ubuntu 16, 64 bit <https://afni.nimh.nih.gov/pub/dist/tgz/linux_ubuntu_16_64.tgz>`_ 
       - Ubuntu 16+
     * - `OpenMP, 64 bit <https://afni.nimh.nih.gov/pub/dist/tgz/linux_openmp_64.tgz>`_ 
       - Ubuntu (<16), Fedora (< 21), Red Hat, etc. 
     * - `Fedora21, 64 bit <https://afni.nimh.nih.gov/pub/dist/tgz/linux_fedora_21_64.tgz>`_ 
       - Fedora 21+                            

|

  .. _afni_bin_mac:

- **Recommended binaries for (most) Mac OS: 10.7+.**

  .. list-table::
     :header-rows: 0
     :widths: 40 60
     :align: left
     :stub-columns: 0
        
     * - `Mac OS X (10.7 Intel), 64 bit <https://afni.nimh.nih.gov/pub/dist/tgz/macosx_10.7_Intel_64.tgz>`_
       - Mac 10.7 (Lion) and higher

  For Mac OS 10.11 (El Capitan) users, some additional modifications
  to your computer settings are required for smooth sailing.  These
  are currently documented `here
  <https://afni.nimh.nih.gov/afni/community/board/read.php?1,149775,149775#msg-149775>`_.

  .. _afni_bin_other:

-  **Binaries for other systems: the rest.**

   * for `Mac OS X Mountain Lion (10.8 Intel), 64 bit
     <https://afni.nimh.nih.gov/pub/dist/tgz/macosx_10.7_Intel_64.tgz>`_.
 
   * for `Mac OS X Snow Leopard (10.6 Intel), 64 bit
     <https://afni.nimh.nih.gov/pub/dist/tgz/macosx_10.6_Intel_64.tgz>`_.

   * for `Mac OS X Snow Leopard (10.6 Intel), 64bit, no fink
     <https://afni.nimh.nih.gov/pub/dist/tgz/macosx_10.6_Intel_64.no.fink.tgz>`_.
   
   * for `Linux xorg7, 64 bit
     <https://afni.nimh.nih.gov/pub/dist/tgz/linux_xorg7_64.tgz>`_.

   * for `Linux xorg7, 32 bit
     <https://afni.nimh.nih.gov/pub/dist/tgz/linux_xorg7.tgz>`_.

   * for `Linux gcc32, 32 bit
     <https://afni.nimh.nih.gov/pub/dist/tgz/linux_gcc32.tgzK>`_.

   * for `FreeBSD with ports (github)
     <https://github.com/outpaddling/freebsd-ports-wip>`_.

   * for `Solaris 2.9 suncc
     <https://afni.nimh.nih.gov/pub/dist/tgz/solaris29_suncc.tgz>`_.


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
