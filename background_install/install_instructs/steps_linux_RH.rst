.. from: https://afni.nimh.nih.gov/pub/dist/HOWTO/howto/ht00_inst/html/linux_inst_current.html

.. _install_steps_linux_RH:


**Linux, Red Hat**
==========================================================

.. contents:: The essential system setup
   :local:

.. highlight:: none

What to do?
-----------

These setup instructions are for modern **Linux versions** of **Red
Hat (RHEL) 7**, along with the corresponding **CentOS 7**.

.. include:: substep_intro.rst

#. To open a text file, you can type ``gedit FILENAME``.  For
   example, to open the bash "rc" file::

     gedit ~/.bashrc &

Install prerequisite packages
-----------------------------

1. To be able to install latest packages, copy+paste::

     sudo yum update

#. Copy+paste::

       sudo yum install -y epel-release
       sudo yum install -y tcsh libXp openmotif gsl xorg-x11-fonts-misc       \
                           PyQt4 R-devel netpbm-progs gnome-tweak-tool ed     \
                           libpng12 xorg-x11-server-Xvfb firefox              \
                           python3-matplotlib
       sudo yum update -y

  **Purpose:** Installs a lot of packages that AFNI depends on (so we
  don't have to reinvent the wheel!).
         
Install AFNI binaries
---------------------

1. Choose one of the following approaches:

   * *(default) To install the binaries from online*, copy+paste::

       cd
       curl -O https://afni.nimh.nih.gov/pub/dist/bin/misc/@update.afni.binaries
       tcsh @update.afni.binaries -package linux_centos_7_64 -do_extras

   * *(alternative) To install already-downloaded binaries,* use
     ``-local_package ..`` (replacing ``PATH_TO_FILE`` with the actual
     path; also, if ``@update.afni.binaries`` has also been
     downloaded, you can skip the ``curl ..`` command), copy+paste::
       
       cd
       curl -O https://afni.nimh.nih.gov/pub/dist/bin/misc/@update.afni.binaries
       tcsh @update.afni.binaries -local_package PATH_TO_FILE/linux_centos_7_64.tgz -do_extras


   **Purpose:** Download and unpack the current binaries in your
   ``$HOME`` directory; set the AFNI binary directory name to
   ``$HOME/abin/``; and add that location to the ``$PATH`` in both
   ``~/.cshrc`` and ``~/.bashrc``.


Install R
---------
 
1. For ... 

   * ... a ``tcsh`` terminal, copy+paste::
   
       setenv R_LIBS $HOME/R
       mkdir  $R_LIBS
       echo  'export R_LIBS=$HOME/R' >> ~/.bashrc
       echo  'setenv R_LIBS ~/R'     >> ~/.cshrc
       . ~/.cshrc

   * ... a ``bash`` terminal, copy+paste::
   
       export R_LIBS=$HOME/R
       mkdir  $R_LIBS
       echo  'setenv R_LIBS ~/R'     >> ~/.cshrc
       echo  'export R_LIBS=$HOME/R' >> ~/.bashrc
       . ~/.bashrc

   (To check your shell type, copy+paste: ``echo $0``)

   | **Purpose:** Set the environment variable ``$R_LIBS`` to specify
     where to install+find the **R** packages.
   | 

#. Copy+paste::
     
     rPkgsInstall -pkgs ALL

   **Purpose:** Get specific R packages needed for AFNI programs. This
   step might take a while (of order an hour) to complete as R
   compiles packages. Sigh.

.. ---------- HERE/BELOW: copy for all installs --------------

Setup Python (opt)
---------------------------------

.. include:: substep_miniconda.rst


Prepare for Bootcamp
--------------------

.. include:: substep_bootcamp.rst


Evaluate setup/system (**important!**)
--------------------------------------------

.. include:: substep_evaluate.rst


Niceify terminal (optional, but goood)
--------------------------------------

.. include:: substep_rcfiles.rst

Install extras (optional, but recommended for Bootcamp prep)
------------------------------------------------------------------

.. include:: substep_extra_packs.rst

Keep up-to-date (remember!)
---------------------------

.. include:: substep_update.rst


.. older, set term shell:

   Make "tcsh" default shell (optional/recommended)

   Copy+paste::

       chsh -s /usr/bin/tcsh

   **Purpose:** Makes ``tcsh`` your default shell in the terminal.

   Reboot


   Copy+paste (to reboot)::

     reboot

     **Purpose:** This deals with system updates, any change in login
     shell, and path updates.



.. 
    comment: the OLD install R stuff for this version

    Install R
    ---------

    a. Copy+paste the following:

       * *for* ``tcsh``::

           setenv R_LIBS $HOME/R
           mkdir $R_LIBS
           echo 'setenv R_LIBS ~/R' >> ~/.cshrc
           curl -O https://afni.nimh.nih.gov/pub/dist/src/scripts_src/@add_rcran_ubuntu.tcsh
           sudo tcsh @add_rcran_ubuntu.tcsh

       * *for* ``bash``::

           export R_LIBS=$HOME/R
           mkdir $R_LIBS
           echo 'export R_LIBS=$HOME/R' >> ~/.bashrc
           curl -O https://afni.nimh.nih.gov/pub/dist/src/scripts_src/@add_rcran_ubuntu.tcsh
           sudo tcsh @add_rcran_ubuntu.tcsh

       **Purpose:** Setup modern R from scratch. This relies on the
       environment variable ``$R_LIBS``, which specifies where to install
       the packages and where to read them from later (when R programs
       run).  The file obtained using ``curl`` contains instructions to
       add a more uptodate set of R libraries to the source list.
