
.. _install_steps_linux_ubuntu18:


**Linux, Ubuntu 18.04**
===================================================================

.. contents:: The essential system setup
   :local:

.. highlight:: None

What to do?
-----------

These setup instructions are for **Ubuntu Linux version 18.04** (Bionic
Beaver). *And a note of thanks to Kiyotaka and other AFNI users who
contributed advice to these instructions on the MB!*

.. include:: substep_intro.rst

#. To open a text file, you can type ``gedit FILENAME``.  For
   example, to open the bash "rc" file::

     gedit ~/.bashrc &

Install prerequisite packages
-----------------------------

1. Copy+paste::

     sudo add-apt-repository universe

#. Copy+paste::

     sudo apt-get update

     sudo apt-get install -y tcsh xfonts-base python-qt4       \
                             python-matplotlib                 \
                             gsl-bin netpbm gnome-tweak-tool   \
                             libjpeg62 xvfb xterm vim curl     \
                             gedit evince eog                  \
                             libglu1-mesa-dev libglw1-mesa     \
                             libxm4 build-essential            \
                             libcurl4-openssl-dev libxml2-dev  \
                             libssl-dev libgfortran3           \
                             gnome-terminal nautilus           \
                             gnome-icon-theme-symbolic         \
                             firefox xfonts-100dpi

   **Purpose:** Installs a lot of packages that AFNI depends on (so we
   don't have to reinvent the wheel!).  This may take a little while
   to complete running.

   Some of these packages also improve terminal behavior, especially
   if you are running Ubuntu on a Windows machine.

#. Copy+paste::
     
     sudo ln -s /usr/lib/x86_64-linux-gnu/libgsl.so.23 /usr/lib/x86_64-linux-gnu/libgsl.so.19 

   **Purpose:** Make a symbolic link for the specific version of GSL
   included in this version of Ubuntu. 

Install AFNI binaries
---------------------

1. For ...:

   * *... (default) installing the binaries from online*, copy+paste::

       cd
       curl -O https://afni.nimh.nih.gov/pub/dist/bin/misc/@update.afni.binaries
       tcsh @update.afni.binaries -package linux_ubuntu_16_64 -do_extras 

   * *... (alternative) installing already-downloaded binaries,* you
     can use ``-local_package ..`` (replace "PATH_TO_FILE" with the
     actual path; also, if ``@update.afni.binaries`` has also been
     downloaded, you can skip the ``curl ..`` command), copy+paste::

       cd
       curl -O https://afni.nimh.nih.gov/pub/dist/bin/misc/@update.afni.binaries
       tcsh @update.afni.binaries -local_package PATH_TO_FILE/linux_ubuntu_16_64.tgz -do_extras 

   **Purpose:** Download and unpack the current binaries in your
   ``$HOME`` directory; set the AFNI binary directory name to
   ``$HOME/abin/``; and add that location to the ``$PATH`` in both
   ``~/.cshrc`` and ``~/.bashrc``.

.. include:: substep_profiles.rst

Install R
---------
 
1. For ... 


   * ... a ``tcsh`` terminal, copy+paste::
   
       setenv R_LIBS $HOME/R
       mkdir  $R_LIBS
       echo  'export R_LIBS=$HOME/R' >> ~/.bashrc
       echo  'setenv R_LIBS ~/R'     >> ~/.cshrc
       curl -O https://afni.nimh.nih.gov/pub/dist/src/scripts_src/@add_rcran_ubuntu_18.04.tcsh

   * ... a ``bash`` terminal, copy+paste::
   
       export R_LIBS=$HOME/R
       mkdir  $R_LIBS
       echo  'setenv R_LIBS ~/R'     >> ~/.cshrc
       echo  'export R_LIBS=$HOME/R' >> ~/.bashrc
       curl -O https://afni.nimh.nih.gov/pub/dist/src/scripts_src/@add_rcran_ubuntu_18.04.tcsh

   (To check your shell type, copy+paste: ``echo $0``)

   **Purpose:** Step 1 of setting up modern R from scratch. Set the
   environment variable ``$R_LIBS`` to specify where to install+find
   the packages.  The file obtained using ``curl`` contains
   instructions to add a more uptodate set of R libraries to the
   source list.

#. Copy+paste::

       sudo tcsh @add_rcran_ubuntu_18.04.tcsh

   **Purpose:** This script updates your package manager to be able to
   get a modern version of R.  If you *don't* already have R on your
   system, it will install it. If you *do* have R, it will stop and
   ask if you want to remove it and update it, or not.


#. Copy+paste::
     
     rPkgsInstall -pkgs ALL

   **Purpose:** Get specific R packages needed for AFNI programs.
   This step might take a while (of order an hour) to complete,
   because R will compile the packages.  Sigh.
   
#. If you are using Windows Subsystem Linux (WSL), and/or if your
   'brms' package fails to install (as checked in the "Evaluation"
   step below), then consider to copy+paste::

     sudo add-apt-repository -y "ppa:marutter/rrutter3.5"
     sudo add-apt-repository -y "ppa:marutter/c2d4u3.5"

     sudo apt update

     sudo apt install -y r-cran-rstan r-cran-shinystan r-cran-brms

   **Purpose:** Add a couple new repos from which to pull packages,
   and then get the desired R packages; these steps come mainly from
   `this helpful website
   <https://github.com/stan-dev/rstan/wiki/Installing-RStan-on-Linux>`_.


.. ---------- HERE/BELOW: copy for all installs --------------

Setup Python (opt)
---------------------------------

.. include:: substep_miniconda.rst

Prepare for Bootcamp
--------------------

.. include:: substep_bootcamp.rst


Evaluate setup/system (**important!**)
----------------------------------------

.. include:: substep_evaluate.rst


Niceify terminal (optional, but goood)
--------------------------------------

.. include:: substep_rcfiles.rst

#. Also, consider running ``gnome-tweak-tool`` and changing
   ``Windows`` -> ``Focus Mode`` from 'click' to 'mouse'.

#. Also, consider extending time for screen saver: ``System Settings``
   -> ``Brightness & Lock``, and set inactivity duration.

Install extras (optional, but recommended for Bootcamp prep)
-----------------------------------------------------------------

.. include:: substep_extra_packs.rst

Keep up-to-date (remember!)
---------------------------

.. include:: substep_update.rst

