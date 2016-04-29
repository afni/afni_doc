
.. _install_steps_mac:

*The essential system setup for:* **Mac OS**
============================================


Here we describe a complete AFNI installation and system setup for Mac
versions that are reasonably modern, such as **Mac OS 10.7+**.  The
full set of steps applies to a "clean" (i.e., empty) 10.7+ system.
There is a special step at the end for 10.11 (El Capitan) users,
because life is hard sometimes.

Note that 10.8 does not come with X11 (or XQuartz) installed.  When
afni is started for the first time, you should be directed (by the
operating system) to a link to install XQuartz.

0. **Account setup**

   Assuming a user account exists, these steps are all optional:

   a. Create a user account with ``su`` (Administrator) privileges
      (via "System Preferences", under "Accounts").

      .. note:: Admin privileges are needed for package management.

   #. (optional) Set the shell to ``/bin/tcsh``.  NB: this no longer
      works using the ``chsh ...`` command.

      Under System Preferences : System : Accounts menu, right-click
      on the user to get the Advanced Options menu and change the
      Login shell to ``/bin/tcsh``.

   #. (optional) Under System Preferences : Sharing : Services, enable
      "Remote Login" to allow ``ssh`` access.

   #. Set the policy where "focus follows mouse", so that it is not
      necessary to first click on a new window (to select it) before
      subsequent clicks are applied to that window.  There are 3
      applications that this might apply to, so we make sure...

      From a terminal window, enter::

        defaults write org.macosforge.xquartz.X11 wm_ffm -bool true
        defaults write org.x.X11 wm_ffm -bool true
        defaults write com.apple.Terminal FocusFollowsMouse -string YES
      |

#. **Xcode and XQuartz installation**

   Xcode is needed for the gcc compiler and related tools.  XQuartz is
   the desktop manager needed to run X11 programs (such as afni).

   *  *For OS X 10.9 and later*, simply run the 2 commands::

         xcode-select --install
         /Applications/Utilities/X11.app

   *  *Otherwise (for OS X versions up through 10.8)*, it is best to start
      with the most recent version from the Apple website:

      a. Go to http://developer.apple.com

         * Sign up for a login account (necessary for downloading) 

         * Sign up via "Register as an Apple Developer" (it is free)

      #. Get the current "Command Line Tools" package (part of Developer
         Tools) and install it

         * the current version is 4.6.2

         * installation defaults are good, to complete installation

      #. Install XQuartz using the "Quick Download" of the DMG file
         located at http://www.xquartz.org

   |

#. **Homebrew installation**

   At this point, we will install the :ref:`package manager
   <tech_notes_PacMan>` Homebrew:

   a. Install HomeBrew and Python
 
      Run this command to run the Homebrew installation script,
      choosing one of these :ref:`shell <tech_notes_PacMan>` syntaxes:

      - *for tcsh*::

         curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install | ruby

      - *for bash*::

         ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
                    

   #. Make sure the Homebrew installation succeeded with no errors by
      typing this command::

        brew doctor

   #. Install PyQt4, enabling use of the AFNI uber_*.py programs::

        brew install pyqt

   #. (only for OS X 10.11, El Capitan) Install gcc with OpenMP support,
      along with glib::

        brew install gcc --with-all-languages --without-multilib
        ln -s /usr/local/Cellar/gcc/5.3.0/lib/gcc/5/libgomp.1.dylib /usr/local/lib/libgomp.1.dylib
        brew install glib


#. **Install AFNI**

   a. Download and unpack the current binaries into your ``$HOME``
      directory, changing the directory name to ``$HOME/abin/``::

        cd
        curl -O https://afni.nimh.nih.gov/pub/dist/bin/macosx_10.7_Intel_64/@update.afni.binaries
        tcsh @update.afni.binaries -defaults

     .. note:: if the binary package has already been downloaded, one can use ``-local_package``, e.g.

      tcsh @update.afni.binaries -local_package macosx_10.7_Intel_64.tgz

   #. Update the path and library path.

      .. note:: ``DYLD_FALLBACK_LIBRARY_PATH`` does not apply to OS X 10.11, El Capitan

      * *for tcsh* (``$PATH`` in ``~/.cshrc`` was set by ``@update.afni.binaries``)::

          echo 'setenv DYLD_FALLBACK_LIBRARY_PATH $HOME/abin' >> ~/.cshrc
          echo 'setenv PYTHONPATH /usr/local/lib/python2.7/site-packages' >> ~/.cshrc
          source ~/.cshrc
          rehash

      * *for bash*::

          echo 'export PATH=/usr/local/bin:$PATH:$HOME/abin' >> ~/.bashrc
          echo 'export DYLD_FALLBACK_LIBRARY_PATH=$HOME/abin' >> ~/.bashrc
          echo 'export PYTHONPATH=/usr/local/lib/python2.7/site-packages' >> ~/.bashrc
          . ~/.bashrc


#. **R installation**

    a. Download and install from the main R website:

       * Go to `the R page for Mac OS X
         <https://cran.r-project.org/bin/macosx>`_

       * Click on the latest package (probably R-3.2.3.pkg), and
         download/install it.

    #. Install extra packages needed by AFNI.

       Run the following AFNI command::

           sudo rPkgsInstall -pkgs ALL


   .. ---------- HERE/BELOW: copy for all installs --------------

#. **Automatically set up AFNI/SUMA profiles.**

   .. include:: substep_profiles.rst


#. **(optional) Prepare for an AFNI Bootcamp.**

   .. include:: substep_bootcamp.rst


#. **EVALUATE THE SETUP: an important and useful step in this
   process!**

   .. include:: substep_evaluate.rst


#. **Keeping up-to-date (remember).**

   .. include:: substep_update.rst




.. comment

   #. **Setting up autoprompts for command line options.**

   The following is quite useful to be set up help files for
   tab-autocompletion of options as you type AFNI commands.  Run this
   command::

     apsearch -update_all_afni_help
      
   and then follow the brief instructions.
