
.. _install_steps_linux_ubuntu18:


**Linux, Ubuntu 18.04**
===================================================================

.. contents:: The essential system setup
   :local:

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
                             gsl-bin netpbm gnome-tweak-tool   \
                             libjpeg62 xvfb xterm vim curl     \
                             gedit evince eog                  \
                             libglu1-mesa-dev libglw1-mesa     \
                             libxm4 build-essential            \
                             libcurl4-openssl-dev libxml2-dev  \
                             libssl-dev libgfortran3           \
                             gnome-terminal nautilus           \
                             gnome-icon-theme-symbolic         \
                             firefox

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

#. Copy+paste::

     cd 
     curl -O https://afni.nimh.nih.gov/pub/dist/bin/linux_ubuntu_16_64/@update.afni.binaries
     tcsh @update.afni.binaries -package linux_ubuntu_16_64  -do_extras

   **Purpose:** Download and unpack the current binaries in your
   ``$HOME`` directory (and yes, that ``@update*`` program works even,
   even though the link has "ubuntu_16" in it); set the AFNI binary
   directory name to ``$HOME/abin/``; and add that location to the
   ``$PATH`` in both ``~/.cshrc`` and ``~/.bashrc``.

   .. note:: If the binary package has already been downloaded
             somewhere, you can use ``-local_package`` with the
             location+name of the binary file, e.g.::

               tcsh @update.afni.binaries -local_package linux_ubuntu_16_64.tgz -do_extras

Install R
---------
 
1. For ... 

   * ... a ``tcsh`` terminal, copy+paste::
   
       setenv R_LIBS $HOME/R
       mkdir  $R_LIBS
       echo  'export R_LIBS=$HOME/R' >> ~/.bashrc
       echo  'setenv R_LIBS ~/R'     >> ~/.cshrc
       curl -O https://afni.nimh.nih.gov/pub/dist/src/scripts_src/@add_rcran_ubuntu_18.04.tcsh
       sudo tcsh @add_rcran_ubuntu_18.04.tcsh

   * ... a ``bash`` terminal, copy+paste::
   
       export R_LIBS=$HOME/R
       mkdir  $R_LIBS
       echo  'setenv R_LIBS ~/R'     >> ~/.cshrc
       echo  'export R_LIBS=$HOME/R' >> ~/.bashrc
       curl -O https://afni.nimh.nih.gov/pub/dist/src/scripts_src/@add_rcran_ubuntu_18.04.tcsh
       sudo tcsh @add_rcran_ubuntu_18.04.tcsh

   **Purpose:** Setup modern R from scratch. This relies on the
   environment variable ``$R_LIBS``, which specifies where to install
   the packages and where to read them from later (when R programs
   run). The file obtained using curl adds a more uptodate set of R
   libraries to the source list.

#. Copy+paste::
     
     rPkgsInstall -pkgs ALL

   **Purpose:** Get specific R packages needed for AFNI programs.
   This step might take a while (of order an hour) to complete,
   because R will compile the packages.  Sigh.
   
.. ---------- HERE/BELOW: copy for all installs --------------

Make AFNI/SUMA profiles
-----------------------

.. include:: substep_profiles.rst

Prepare for Bootcamp
--------------------

.. include:: substep_bootcamp.rst


Evaluate setup/system (**important!**)
-----------------------------------

.. include:: substep_evaluate.rst


Niceify terminal (optional, but goood)
--------------------------------------

.. include:: substep_rcfiles.rst

#. Also, consider running ``gnome-tweak-tool`` and changing
   ``Windows`` -> ``Focus Mode`` from 'click' to 'mouse'.

#. Also, consider extending time for screen saver: ``System Settings``
   -> ``Brightness & Lock``, and set inactivity duration.

Keep up-to-date (remember!)
---------------------------

.. include:: substep_update.rst

