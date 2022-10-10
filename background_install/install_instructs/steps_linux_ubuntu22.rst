
.. _install_steps_linux_ubuntu22:


**Linux, Ubuntu 22.04**
===================================================================

.. contents:: The essential system setup
   :local:

.. highlight:: none

These setup instructions are for **Ubuntu Linux version 22.04** (Jammy
Jellyfish).

Things to note before starting
--------------------------------

.. include:: substep_intro.rst

#. **To copy and paste** in a Linux terminal, one can use
   ``Ctrl+Shift+c`` and ``Ctrl+Shift+v``, respectively.  (In WSL
   terminals, one might first enable this functionality: rightclick on
   the panel's taskbar, select "Properties" and put a checkmark by
   this option.)

#. **To open a text file,** use any text editor you like, and/or you
   can type ``gedit FILENAME``, such as either::

     gedit ~/.bashrc 

     gedit ~/.bashrc &


Quick setup
----------------------------------

.. include:: substep_quickbuild_linux_ubuntu_22_64.rst


(slow setup) Install prerequisite packages
---------------------------------------------
 
.. note: for here and below, need to keep uptodate with this
   (changing) page for Rstan/brms installation issues

   though, from Ubuntu 22.04, these don't seem necessary

   https://github.com/stan-dev/rstan/wiki/Configuring-C-Toolchain-for-Linux


1. Copy+paste::

     sudo add-apt-repository universe

#. Copy+paste::

     sudo apt-get update

   Copy+paste::

     sudo apt-get install -y tcsh xfonts-base libssl-dev       \
                             python-is-python3                 \
                             python3-matplotlib python3-numpy  \
                             gsl-bin netpbm gnome-tweaks       \
                             libjpeg62 xvfb xterm vim curl     \
                             gedit evince eog                  \
                             libglu1-mesa-dev libglw1-mesa     \
                             libxm4 build-essential            \
                             libcurl4-openssl-dev libxml2-dev  \
                             libgfortran-10-dev libgomp1       \
                             gnome-terminal nautilus           \
                             firefox xfonts-100dpi             \
                             r-base-dev cmake                  \
                             libgdal-dev libopenblas-dev       \
                             libnode-dev libudunits2-dev


   **Purpose:** Installs a lot of packages that AFNI depends on (so we
   don't have to reinvent the wheel!).  This may take a little while
   to complete running.

   | Some of these packages also improve terminal behavior, especially
     if you are running Ubuntu on a Windows machine.
   | 

#. Copy+paste::
     
     sudo ln -s /usr/lib/x86_64-linux-gnu/libgsl.so.27 /usr/lib/x86_64-linux-gnu/libgsl.so.19

   **Purpose:** Make a symbolic link for the specific version of GSL
   included in this version of Ubuntu. 

(slow setup) Install AFNI binaries
---------------------------------------

1. Choose one of the following approaches:

   * *(default) To install the binaries from online*, copy+paste::

       cd
       curl -O https://afni.nimh.nih.gov/pub/dist/bin/misc/@update.afni.binaries
       tcsh @update.afni.binaries -package linux_ubuntu_16_64 -do_extras 

   * *(alternative) To install already-downloaded binaries,* use
     ``-local_package ..`` (replacing ``PATH_TO_FILE`` with the actual
     path; also, if ``@update.afni.binaries`` has also been
     downloaded, you can skip the ``curl ..`` command), copy+paste::

       cd
       curl -O https://afni.nimh.nih.gov/pub/dist/bin/misc/@update.afni.binaries
       tcsh @update.afni.binaries -local_package PATH_TO_FILE/linux_ubuntu_16_64.tgz -do_extras 

   **Purpose:** Download and unpack the current binaries in your
   ``$HOME`` directory; set the AFNI binary directory name to
   ``$HOME/abin/``; and add that location to the ``$PATH`` in both
   ``~/.cshrc`` and ``~/.bashrc``.


(slow setup) Install R
--------------------------
 
1. Check your shell type (``echo $0``). For ... 

   |

   * \.\.\. a ``tcsh`` terminal, copy+paste::
   
       setenv R_LIBS $HOME/R
       mkdir  $R_LIBS
       echo  'export R_LIBS=$HOME/R' >> ~/.bashrc
       echo  'setenv R_LIBS ~/R'     >> ~/.cshrc

   * \.\.\. a ``bash`` terminal, copy+paste::
   
       export R_LIBS=$HOME/R
       mkdir  $R_LIBS
       echo  'export R_LIBS=$HOME/R' >> ~/.bashrc
       echo  'setenv R_LIBS ~/R'     >> ~/.cshrc

   | **Purpose:** Set the environment variable ``$R_LIBS`` to specify
     where to install+find the **R** packages.
   | 

#. Copy+paste::
     
     rPkgsInstall -pkgs ALL

   | **Purpose:** Get specific R packages needed for AFNI programs.
     This step might take a while (of order an hour) to complete,
     because R will compile the packages.  Sigh.
   |




.. ---------- HERE/BELOW: copy for all installs --------------


(slow setup) Prepare for Bootcamp
-----------------------------------

.. include:: substep_bootcamp.rst


(slow setup) Evaluate setup/system (**important!**)
-----------------------------------------------------

.. include:: substep_evaluate.rst


(slow setup) Niceify terminal (optional, but goood)
---------------------------------------------------

.. include:: substep_rcfiles.rst

#. Also, consider running ``gnome-tweak-tool`` and changing
   ``Windows`` -> ``Focus Mode`` from 'click' to 'mouse'.

#. Also, consider extending time for screen saver: ``System Settings``
   -> ``Brightness & Lock``, and set inactivity duration.


(slow setup) Install extras (optional, but recommended for Bootcamp prep)
----------------------------------------------------------------------------

.. include:: substep_extra_packs.rst

(slow setup) Keep up-to-date (remember!)
------------------------------------------------

.. include:: substep_update.rst


A note on setting up Python/using Conda (opt)
-----------------------------------------------

*For this OS, you should* not *need to do anything further to set up
your Python*.

.. include:: substep_miniconda.rst
