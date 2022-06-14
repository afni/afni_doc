
.. _install_steps_mac12_Silicon:

**Apple Silicon (M1, M2, etc.) - macOS 12.3.1+**
=================================================

.. contents:: The essential system setup
   :local:

.. highlight:: none

What to do?
-----------

These setup instructions are for **macOS 12.3.1 or greater with Apple
Silicon CPUs (M1 chip, not Intel)**.

0. **Each step** involves either copy+pasting a command, or clicking
   on a download link.

#. **The user must have admin privileges** (able to run ``sudo ls``,
   for example).  Some steps require an internet connection.

#. **Do not add sudo to a command** unless it is already written.  You
   may still be prompted for your sudo/admin password in several
   steps.  These steps have "(admin)" in their title.
   
#. **This has been tested on macOS 12.3.1 and 12.4** It may work on macOS 11,
   but the python installation may not be necessary.
   
#. This installs the Intel-compiled binaries (NOT the native Apple
   Silicon binaries), and therefore requires Rosetta 2.  Compilation
   of M1-native binaries is in progress.


Install Rosetta 2 (admin)
-------------------------------------
   
#. Copy+paste::
    
     softwareupdate --install-rosetta
    
**Purpose:** This installs the Rosetta 2 system that allows the Apple
Silicon machines to run Intel-compiled binaries.  At present, AFNI is
not compiled for Apple Silicon (on our to-do list).
     
   
Install Homebrew and packages (admin)
-------------------------------------

Do *not* use ``sudo`` explicitly with any of these commands.  However,
some *will* prompt you for your admin password).
    
#. To install homebrew, copy+paste::

     cd
     /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

#. (opt) To turn of default analytic collection (*ick*), copy+paste::

     brew analytics off

#. To install needed packages, copy+paste::
    
     brew install python netpbm cmake

#. To install needed XQuartz, copy+paste::
    
    brew install --cask xquartz

#. **Reboot/restart** your computer (for changes to take effect).

|

.. note:: **XQuartz Suggestion**

    After you restart, open XQuartz and change a preference.  Go to
    the XQuartz menu near the upper left corner of the desktop.  Then
    go to Preferences... -> Windows -> "Click-through Inactive
    Windows".  Also "Focus On New Windows" may be useful.

**Purpose:** Homebrew will install the Xcode command line tools first.
macOS 12.3.1 removed ``python``, so we are installing it here.
``netpbm`` is needed for some image outputs.  ``cmake`` is needed for
compiling some R libraries.  Xquartz is the main desktop manager for
X11 programs like ``afni``.


Install R (admin)
-----------------

#. To download R (*specifically* v3.6.3 is required) and gfortran
   packages, copy+paste::
    
     cd
     curl -s -L -o R-3.6.3.nn.pkg "https://cran.r-project.org/bin/macosx/el-capitan/base/R-3.6.3.nn.pkg"
     curl -s -L -o gfortran-6.1.pkg "https://cloud.r-project.org/bin/macosx/tools/gfortran-6.1.pkg"

#. To install R, copy+paste::

     sudo installer -pkg R-3.6.3.nn.pkg -target /

#. To install gfortran, copy+paste::

     sudo installer -pkg gfortran-6.1.pkg -target /

#. To cleanup package downloads, copy+paste::

     \rm gfortran-6.1.pkg
     \rm R-3.6.3.nn.pkg

**Purpose:** This downloads the installer packages and runs the
install from the command line (then removes the downloaded
installers).  This slightly older R version is specified to match the
AFNI build (at present\.\.\.).  ``gfortran is`` needed for compiling
some R libraries.
    

Update Path
-----------

#. Copy+paste::

     touch ~/.zshrc
     echo 'export PATH=$PATH:/opt/homebrew/opt/python/libexec/bin' >> ~/.zshrc
     echo 'export PATH=$PATH:/Library/Frameworks/R.framework/Resources' >> ~/.zshrc
     echo 'export PATH=$PATH:/usr/local/gfortran/bin' >> ~/.zshrc
     source ~/.zshrc

**Purpose:** This adds ``python``, ``R`` and ``gfortran`` to your path
so the command line can use them.  Assumes ``zsh`` is your login shell
(the Mac default).

Install R Libraries
---------------------

#. Copy+paste::
    
     Rscript -e "install.packages(c('afex','phia','snow','nlme','lmerTest'), repos='https://cloud.r-project.org')"


**Purpose:** Installs the R libraries needed for primary AFNI stats
(R-based) programs.  Note that some newer Bayesian stats programs
require other libraries.  Some libraries other libraries are not
available on macOS for R 3.6.3.  (We are working on updating this)
``afni_system_check.py -check_all`` will show some missing libraries.

Install AFNI
------------

#. Copy+paste::
    
     curl -O https://afni.nimh.nih.gov/pub/dist/bin/misc/@update.afni.binaries
     tcsh @update.afni.binaries -package macos_10.12_local -do_extras

#. Open a new terminal (or source current shell's "rc" file, as
   suggested in finishing text).

**Purpose:** Install AFNI binaries (in default ``~/abin`` location).

.. note:: Upon first ``afni`` or ``suma`` launch, the terminal will
          pop up messages to ask for permissions to access various
          data on your system, such as: Photos, Desktop, Contacts,
          Calendar, Reminders, Documents, Downloads.  I would
          recommend **not** allowing Photos, Contacts, Calendars, and
          Reminders.  But the others will be useful.

.. note:: And if you launch ``afni`` from your home folder, you will
          get a lot of "Operation not permitted" errors/warnings from
          ``afni`` trying to find datasets in restricted folders under
          your home directory, like ``~/Library`` etc. You can safely
          ignore those errors.

Reboot
------

.. include:: substep_mac_reboot.rst

Evaluate setup/system (**important!**)
-----------------------------------------

.. include:: substep_evaluate.rst

Prepare for Bootcamp (opt)
-----------------------------------------

.. include:: substep_bootcamp.rst

Optional further steps
--------------------------

Setup terminal (opt)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. include:: substep_mac_setup_term.rst


.. ---------- HERE/BELOW: copy for all installs --------------

Setup Python (one method)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. include:: substep_miniconda.rst

.. nts:
 
   moved the evaluation step above for this OS, because users will
   have basic python from install

Niceify terminal (add convenience!)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. include:: substep_rcfiles_mac.rst


Install extras (recommended for Bootcamp prep)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. include:: substep_extra_packs.rst

Keep up-to-date (remember!)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. include:: substep_update.rst

Enable more SUMA keypresses (recommended)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


.. include:: substep_mac_keyshortcuts.rst




