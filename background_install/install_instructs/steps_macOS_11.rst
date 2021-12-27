
.. _install_steps_mac11:

**macOS 11** *(via command line)*
===============================================

.. contents:: The essential system setup
   :local:

.. highlight:: none

What to do?
-----------

These setup instructions are for **macOS 11**.

0. **Each step** involves either copy+pasting a command, or clicking
   on a download link.

#. **The user must have admin privileges** (can run ``sudo ...``).
   Some steps require an internet connection.

#. **Do** the system check in the "Evaluate" stage. Try any recommendations in its "Please Fix" section.

#. If you run into any problems, please just ask a clear question on the `Message Board <https://afni.nimh.nih.gov/afni/community/board/>`_.


Install Xcode and XQuartz (admin priviledges required)
------------------------------------------------------

* Copy+paste::

     xcode-select --install

.. note:: You may want to check "Software Update" in "System Preferences"
           for an xcode update after this finishes installing.

* For XQuartz, click on this link:
     | http://www.xquartz.org

     | Then click on the "Quick Download" DMG, and follow the
       instructions to install.
     |

.. note:: The XQuartz installer may log you out after the installation completes.

**Purpose:** These install Xcode command line tools (needed for the
gcc compiler et al.) and XQuartz (the desktop manager needed to run
X11 programs, such as ``afni``!).

All in One Block
-------------------------

* Copy+paste the following::

     touch ~/.cshrc
     echo 'if ( $?DYLD_LIBRARY_PATH ) then' >> ~/.cshrc
     echo '  setenv DYLD_LIBRARY_PATH ${DYLD_LIBRARY_PATH}:/opt/X11/lib/flat_namespace' >> ~/.cshrc
     echo 'else' >> ~/.cshrc
     echo '  setenv DYLD_LIBRARY_PATH /opt/X11/lib/flat_namespace' >> ~/.cshrc
     echo 'endif' >> ~/.cshrc

     touch ~/.bashrc
     echo 'export DYLD_LIBRARY_PATH=${DYLD_LIBRARY_PATH}:/opt/X11/lib/flat_namespace' >> ~/.bashrc
     echo 'export PATH=$PATH:/Library/Frameworks/R.framework' >> ~/.bashrc

     cd
     curl -O https://afni.nimh.nih.gov/pub/dist/bin/misc/@update.afni.binaries
     tcsh @update.afni.binaries -package macos_10.12_local -do_extras

     source ~/.bashrc
     cp $HOME/abin/AFNI.afnirc $HOME/.afnirc
     suma -update_env

.. note::
    Upon first afni or suma launch, the terminal will pop up messages to ask for
    permissions to access various data on your system.
    Possibly including:
    Photos, Desktop, Contacts, Calendar, Reminders, Documents, Downloads.
    I would recommend NOT allowing Photos, Contacts, Calendars, and Reminders.
    But the others will be useful.

.. note::
    And if you launch afni from your home folder,
    you will get a lot of "Operation not permitted" errors from afni trying to
    find datasets in restricted folders under your home directory.
    Like "~/Library" etc. You can safely ignore those errors.

Reboot
------

.. include:: substep_mac_reboot.rst

Install R (admin priviledges required)
---------------------------------------

* | Click on this link:
    https://cran.r-project.org/bin/macosx/el-capitan/base/R-3.6.3.nn.pkg

   | **Purpose:** Get R-3.6.3 (a recent, but not the *most* recent,
     version of R).
   |

.. note:: You will get an error that prevents you from launching the installer
          when you double click it.
          You will have to go to your "Downloads" folder, right click the
          R-3.6.3.nn.pkg file and select "Open".  Then you will get the same
          warning, but you can click "Open" to launch the installer.

* Copy+paste::

     sudo rPkgsInstall -pkgs ALL


 **Purpose:** Get specific R packages needed for AFNI programs.

.. note:: Note for afni staff.

            Need path update in .zshrc etc to include /Library/Frameworks/R.framework/Resources

            also may need gfortran
            https://cloud.r-project.org/bin/macosx/tools/gfortran-6.1.pkg


Install Netpbm (admin priviledges required)
-------------------------------------------

* Copy+paste::

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

* Copy+paste::

    brew install netpbm

Extras
------

#. Copy+paste the following::

     defaults write org.macosforge.xquartz.X11 wm_ffm -bool true
     defaults write org.x.X11 wm_ffm -bool true
     defaults write com.apple.Terminal FocusFollowsMouse -string YES


.. ---------- HERE/BELOW: copy for all installs --------------

Setup Python (opt)
---------------------------------

.. include:: substep_miniconda.rst

Prepare for Bootcamp
------------------------------------

.. include:: substep_bootcamp.rst

Evaluate setup/system (**important!**)
-----------------------------------------

.. include:: substep_evaluate.rst

Niceify terminal (optional, but goood)
--------------------------------------

.. include:: substep_rcfiles_mac.rst

Install extras (optional, but recommended for Bootcamp prep)
-----------------------------------------------------------------

.. include:: substep_extra_packs.rst

Keep up-to-date (remember!)
---------------------------

.. include:: substep_update.rst

Enable more SUMA keypresses (recommended)
----------------------------------------------------------

.. include:: substep_mac_keyshortcuts.rst





.. NO LONGER RECOMMEND PyQt4 STUFF

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


