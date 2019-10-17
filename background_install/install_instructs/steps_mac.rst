
.. _install_steps_mac:


**Mac OS**
========================================

.. contents:: The essential system setup
   :local:

What to do?
-----------

These setup instructions are for **Mac OS versions 10.9+**.

.. note:: *If you are seeking the new App version of install
          instructions, please :ref:`click HERE
          <install_steps_mac_app>`.

.. include:: substep_intro.rst

#. To open a text file, you can type ``open -t FILENAME``.  For
   example, to open the bash "rc" file::

     open -t ~/.bashrc 

Setup terminal
--------------

a. Copy+paste::

     defaults write org.macosforge.xquartz.X11 wm_ffm -bool true
     defaults write org.x.X11 wm_ffm -bool true
     defaults write com.apple.Terminal FocusFollowsMouse -string YES

   **Purpose:** This sets the policy where "focus follows mouse" for
   relevant applications. After this, clicks on a new window are
   directly applied, without needing to "pre-click" it.  You're
   welcome.

Install Xcode and XQuartz
-------------------------

#. Copy+paste::

     xcode-select --install

#. For ...

   * | *... OS X >= 10.11*, click on this link: http://www.xquartz.org 
     | and then click on the "Quick Download" DMG, and 
       follow instructions to install.

   * *... OS X 10.9 and 10.10*, copy+paste::

       /Applications/Utilities/X11.app

   **Purpose:** These install Xcode command line tools (needed for the
   gcc compiler et al.) and XQuartz (the desktop manager needed to run
   X11 programs, such as ``afni``!).

#. Copy+paste this mess::

     touch ~/.cshrc
     echo 'if ( $?DYLD_LIBRARY_PATH ) then' >> ~/.cshrc
     echo '  setenv DYLD_LIBRARY_PATH ${DYLD_LIBRARY_PATH}:/opt/X11/lib/flat_namespace' >> ~/.cshrc
     echo 'else' >> ~/.cshrc
     echo '  setenv DYLD_LIBRARY_PATH /opt/X11/lib/flat_namespace' >> ~/.cshrc
     echo 'endif' >> ~/.cshrc

     touch ~/.bashrc
     echo 'export DYLD_LIBRARY_PATH=${DYLD_LIBRARY_PATH}:/opt/X11/lib/flat_namespace' >> ~/.bashrc

   **Purpose:** This adjusts the library format variable for XQuartz
   in both ``tcsh`` and ``bash``.  Sigh.


Install AFNI binaries
---------------------

1. Copy+paste::

     cd
     curl -O https://afni.nimh.nih.gov/pub/dist/bin/macosx_10.7_local/@update.afni.binaries

#. Copy+paste (this applies even if your OS version is <10.12)::

       tcsh @update.afni.binaries -defaults -package macos_10.12_local

   **Purpose:** download and unpack the current binaries into your
   ``$HOME`` directory; set the AFNI binary directory name to
   ``$HOME/abin/``; and add that location to the ``$PATH`` in both
   ``~/.cshrc`` and ``~/.bashrc``.

   .. note:: If the binary package has already been downloaded
             somewhere, instead of the above you can use
             ``-local_package`` with the location+name of the binary
             file, e.g.::

               tcsh @update.afni.binaries -local_package macos_10.12_local.tgz -do_extras

Reboot
------

Please reboot your system.

**Purpose:** This deals with system updates, any change in login
shell, and path updates.

Install R
---------

.. comment out old
  a. | Click on this link: https://cran.r-project.org/bin/macosx
     | and then click on the top/latest package to install.

1. Click on this link:
   https://cran.r-project.org/bin/macosx/el-capitan/base/R-3.5.3.pkg

   **Purpose:** Get a recent (but not the *most* recent) version of R.

#. Copy+paste::

     sudo rPkgsInstall -pkgs ALL

   **Purpose:** Get specific R packages needed for AFNI programs.

Install Netpbm
--------------

.. include:: substep_netpbm.rst

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

.. include:: substep_rcfiles_mac.rst

Install extras (optional, but recommended for Bootcamp prep)
---------------------------

.. include:: substep_extra_packs.rst

Keep up-to-date (remember!)
---------------------------

.. include:: substep_update.rst

Enable more SUMA keypresses (recommended)
----------------------------------------------------------

.. include:: substep_mac_keyshortcuts.rst

Install PyQt4, via JDK and fink (optional)
------------------------------------------

**Note:** at present, this step is only necessary if you want to have
some of the Python-based GUI programs in AFNI.  However, we don't
really use these much, and certainly if you are here for
``uber_subject.py``, we would **strongly** recommend that you just
build an ``afni_proc.py`` command from existing examples in the
:ref:`afni_proc.py help <ahelp_afni_proc.py>`, instead!

1. | Click on this link: http://www.oracle.com/technetwork/java/javase/downloads
   | and then click on the ``Java`` icon.

   **Purpose:** Install Java SE (standard edition) JDK.

#. Copy+paste::
   
     curl -O https://afni.nimh.nih.gov/pub/dist/bin/misc/save/install.fink.bash
     bash install.fink.bash

   **Purpose:** This runs an install script to download+install the
   package manager ``fink``.  

   This takes perhaps 30 minutes to finish **and** the user gets asked
   many questions (sorry, no way around it).  One can simply keep
   hitting the ``ENTER`` key to accept the useful defaults (**note:**
   you can respond with 'n' for the Xcode installation prompt if
   prompted otherwise, as you should have it from an earlier step).

#. Do each of the following (installs PyQt4):

   i. Open a new terminal window.

   #. Copy+paste::

        fink --version

   #. If no errors, copy+paste::

        sudo fink install pyqt4-mac-py27

   #. Copy+paste::

        sudo ln -s /sw/bin/python2.7 /sw/bin/python
        echo 'setenv PYTHONPATH /sw/lib/qt4-mac/lib/python2.7/site-packages' >> ~/.cshrc

#. To test your PyQt4, copy+paste::

     uber_subject.py

   Does a GUI open?  Or is there a crash??
  
   |


