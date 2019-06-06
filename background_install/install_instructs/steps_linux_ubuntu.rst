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
                               libmotif4 libmotif-dev motif-clients     \
                               gsl-bin netpbm xvfb gnome-tweak-tool     \
                               libjpeg62 xterm gedit evince firefox eog
       sudo apt-get update

   * *... version 15.10*, copy+paste::
   
       sudo apt-get install -y tcsh xfonts-base python-qt4 gedit evince \
                               libmotif4 libmotif-dev motif-clients     \
                               gsl-bin netpbm xvfb gnome-tweak-tool 
                               libjpeg62 firefox eog
       sudo apt-get update
       sudo ln -s /usr/lib/x86_64-linux-gnu/libgsl.so /usr/lib/libgsl.so.0
       sudo dpkg -i http://mirrors.kernel.org/ubuntu/pool/main/libx/libxp/libxp6_1.0.2-2_amd64.deb
       sudo apt-get install -f

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
       sudo tcsh @add_rcran_ubuntu.tcsh

   * ... a ``bash`` terminal, copy+paste::
   
       export R_LIBS=$HOME/R
       mkdir  $R_LIBS
       echo  'setenv R_LIBS ~/R'     >> ~/.cshrc
       echo  'export R_LIBS=$HOME/R' >> ~/.bashrc
       curl -O https://afni.nimh.nih.gov/pub/dist/src/scripts_src/@add_rcran_ubuntu.tcsh
       sudo tcsh @add_rcran_ubuntu.tcsh

   **Purpose:** Setup modern R from scratch. This relies on the
   environment variable ``$R_LIBS``, which specifies where to install
   the packages and where to read them from later (when R programs
   run).  The file obtained using ``curl`` contains instructions to
   add a more uptodate set of R libraries to the source list.

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

Keep up-to-date (remember!)
---------------------------

.. include:: substep_update.rst


