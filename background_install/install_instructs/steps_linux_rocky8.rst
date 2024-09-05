
.. _install_steps_linux_rocky8:


**Linux, Rocky**
===================================================================

.. contents:: The essential system setup
   :local:

.. highlight:: none

These setup instructions are for **Rocky Linux version 8**.

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

.. include:: substep_quickbuild_linux_rocky_8.rst


(slow setup) Install prerequisite packages
---------------------------------------------

1. Copy+paste::

     sudo dnf install -y tcsh gcc motif-devel gsl-devel        \
                         libXpm-devel mesa-libGLw-devel        \
                         mesa-libGLU-devel libXi-devel         \
                         glib2-devel                           \
                         python39 python3-matplotlib           \
                         python3-flask python3-flask-cors      \
                         python3-numpy 

#. Copy+paste::

     sudo alternatives --set python /usr/bin/python3

#. Copy+paste::

     sudo dnf config-manager --set-enabled powertools

#. Copy+paste::

     sudo dnf install -y epel-release R-devel

   **Purpose:** Installs a lot of packages that AFNI depends on (so we
   don't have to reinvent the wheel!).  This may take a little while
   to complete running.  Note: python3 does not come with 'python', we
   have to ask for that



(slow setup) Install AFNI binaries
---------------------------------------

1. Choose one of the following approaches:

   * *(default) To install the binaries from online*, copy+paste::

       cd
       curl -O https://afni.nimh.nih.gov/pub/dist/bin/misc/@update.afni.binaries
       tcsh @update.afni.binaries -package linux_rocky_8 -do_extras 

   * *(alternative) To install already-downloaded binaries,* use
     ``-local_package ..`` (replacing ``PATH_TO_FILE`` with the actual
     path; also, if ``@update.afni.binaries`` has also been
     downloaded, you can skip the ``curl ..`` command), copy+paste::

       cd
       curl -O https://afni.nimh.nih.gov/pub/dist/bin/misc/@update.afni.binaries
       tcsh @update.afni.binaries -local_package PATH_TO_FILE/linux_rocky_8.tgz -do_extras 

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
