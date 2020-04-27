.. from: https://afni.nimh.nih.gov/pub/dist/HOWTO/howto/ht00_inst/html/linux_inst_current.html

.. _install_steps_linux_ubuntu:


**Linux, Ubuntu 15.10 and earlier**
==================================================================

.. contents:: The essential system setup
   :local:

What to do?
-----------

These setup instructions are for Ubuntu Linux versions 15.10
(Wily Werewolf) and earlier.

.. include:: substep_intro.rst

#. To open a text file, you can type ``gedit FILENAME``.  For
   example, to open the bash "rc" file::

     gedit ~/.bashrc &

Install prerequisite packages
-----------------------------

1. To be able to install latest packages, copy+paste::

     sudo apt-get update

#. For ...

   * *... versions 15.04 and earlier*, copy+paste::
   
       sudo apt-get install -y tcsh libxp6 xfonts-base python-qt4       \
                               python-matplotlib                        \
                               libmotif4 libmotif-dev motif-clients     \
                               gsl-bin netpbm xvfb gnome-tweak-tool     \
                               libjpeg62 xterm gedit evince firefox eog \
                               xfonts-100dpi
       sudo apt-get update

   * *... version 15.10*, copy+paste::
   
       sudo apt-get install -y tcsh xfonts-base python-qt4 gedit evince \
                               python-matplotlib                        \
                               libmotif4 libmotif-dev motif-clients     \
                               gsl-bin netpbm xvfb gnome-tweak-tool     \
                               libjpeg62 firefox eog xfonts-100dpi
       sudo apt-get update
       sudo ln -s /usr/lib/x86_64-linux-gnu/libgsl.so /usr/lib/libgsl.so.0
       sudo dpkg -i http://mirrors.kernel.org/ubuntu/pool/main/libx/libxp/libxp6_1.0.2-2_amd64.deb
       sudo apt-get install -f

     (To check your version number, copy+paste: ``lsb_release -a``)

     **Purpose:** Installs a lot of packages that AFNI depends on (so
     we don't have to reinvent the wheel!).

Install AFNI binaries
---------------------

1. Copy+paste::

     cd
     curl -O https://afni.nimh.nih.gov/pub/dist/bin/linux_ubuntu_16_64/@update.afni.binaries
     tcsh @update.afni.binaries -package linux_openmp_64 -do_extras

   **Purpose:** Download and unpack the current binaries in your
   ``$HOME`` directory (and yes, that ``@update*`` program works even,
   even though the link has "ubuntu_16" in it); set the AFNI binary
   directory name to ``$HOME/abin/``; and add that location to the
   ``$PATH`` in both ``~/.cshrc`` and ``~/.bashrc``.

   .. note:: If the binary package has already been downloaded
             somewhere, instead of the above you can use
             ``-local_package`` with the location+name of the binary
             file, e.g.::

               tcsh @update.afni.binaries -local_package linux_openmp_64.tgz -do_extras

Install R
---------

1. For ... 

   * ... a ``tcsh`` terminal, copy+paste::
   
       setenv R_LIBS $HOME/R
       mkdir  $R_LIBS
       echo  'export R_LIBS=$HOME/R' >> ~/.bashrc
       echo  'setenv R_LIBS ~/R'     >> ~/.cshrc
       curl -O https://afni.nimh.nih.gov/pub/dist/src/scripts_src/@add_rcran_ubuntu.tcsh

   * ... a ``bash`` terminal, copy+paste::
   
       export R_LIBS=$HOME/R
       mkdir  $R_LIBS
       echo  'setenv R_LIBS ~/R'     >> ~/.cshrc
       echo  'export R_LIBS=$HOME/R' >> ~/.bashrc
       curl -O https://afni.nimh.nih.gov/pub/dist/src/scripts_src/@add_rcran_ubuntu.tcsh

   (To check your shell type, copy+paste: ``echo $0``)

   **Purpose:** Step 1 of setting up modern R from scratch. Set the
   environment variable ``$R_LIBS`` to specify where to install+find
   the packages.  The file obtained using ``curl`` contains
   instructions to add a more uptodate set of R libraries to the
   source list.

#. Copy+paste::

       sudo tcsh @add_rcran_ubuntu.tcsh

   **Purpose:** This script updates your package manager to be able to
   get a modern version of R.  If you *don't* already have R on your
   system, it will install it. If you *do* have R, it will stop and
   ask if you want to remove it and update it, or not.

#. Copy+paste::
     
     rPkgsInstall -pkgs ALL

   **Purpose:** Get specific R packages needed for AFNI programs. This
   step might take a while to complete.
   
.. ---------- HERE/BELOW: copy for all installs --------------

Make AFNI/SUMA profiles
-----------------------

.. include:: substep_profiles.rst

Prepare for Bootcamp
------------------------------------

.. include:: substep_bootcamp.rst

Evaluate setup/system (**important!**)
----------------------------------

.. include:: substep_evaluate.rst

Niceify terminal (optional, but goood)
--------------------------------------

.. include:: substep_rcfiles.rst

Install extras (optional, but recommended for Bootcamp prep)
---------------------------

.. include:: substep_extra_packs.rst

Keep up-to-date (remember!)
---------------------------

.. include:: substep_update.rst


