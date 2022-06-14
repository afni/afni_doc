
.. _install_steps_mac12_4_Apple_Silicon:

**Apple Silicon - macOS 12.3.1+**
===============================================

.. contents:: The essential system setup
   :local:

.. highlight:: none

What to do?
-----------

These setup instructions are for **macOS 12.3.1 or greater with Apple silicon CPUs (not Intel)**.

0. **Each step** involves either copy+pasting a command, or clicking
   on a download link.

#. **The user must have admin privileges** (can run ``sudo ...``).
   Some steps require an internet connection.
   
#. **This has been tested on macOS 12.3.1 and 12.4** It may work on macOS 11,
   but the python installation may not be necessary.
   
#. This installs the Intel compiled binaries (NOT the native Apple Silicon 
   binaries)  Therefor, it needs Rosetta 2. Native binaries are in progress.

Install Rosetta 2 (admin)
-------------------------------------
   
* **Rosetta 2**::
    
    softwareupdate --install-rosetta
    
* .. collapse:: Details
    
    This installs the Rosetta 2 system that allows the Apple Silicon machines
    to run Intel compiled binaries.  We will compile AFNI for Apple Silicon,
    but it is not yet completed.  AFNI will run faster once we do that, but 
    AFNI is pretty fast anyway.  However, it is not noticeably slower 
    (at least to me).
     
   
Install Homebrew and packages (admin)
-------------------------------------
    
* **Homebrew**::

    cd
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

* **Privacy Setting**::

    brew analytics off

* **Packages**::
    
    brew install python netpbm cmake

* **XQuartz**::
    
    brew install --cask xquartz

* .. note:: You should restart your computer after this XQuartz step.

* .. collapse:: XQuartz Suggestion

    After you restart, open XQuartz and change a preference.  
    Go to the XQuartz menu near the upper left corner of the desktop.  
    Then go to Preferences... -> Windows -> "Click-through Inactive Windows".
    Also "Focus On New Windows" may be useful.

* .. collapse:: Details

    Homebrew will install the Xcode command line tools first.  This also turns
    off the analytics which will stop Homebrew from collecting data. If you want
    to send them your usage data, you can leave that step out.
    macOS 12.3.1 removed python, so we are installing it here.  
    netpbm is needed for some image outputs.  
    cmake is needed for compiling some R libraries.  
    Xquartz is the main desktop manager for X11 programs like ``afni``.


Install R (admin)
-----------------

* **R 3.6.3**::
    
    cd
    curl -s -L -o R-3.6.3.nn.pkg "https://cran.r-project.org/bin/macosx/el-capitan/base/R-3.6.3.nn.pkg"
    sudo installer -pkg R-3.6.3.nn.pkg -target /
    rm R-3.6.3.nn.pkg

* **gfortran 6.1**::

    cd
    curl -s -L -o gfortran-6.1.pkg "https://cloud.r-project.org/bin/macosx/tools/gfortran-6.1.pkg"
    sudo installer -pkg gfortran-6.1.pkg -target /
    rm gfortran-6.1.pkg

* .. collapse:: Details

    This downloads the installer packages and runs the install from the command 
    line.  (then removes the downloaded installers).  
    The R version is slightly older to match the afni build.  
    gfortran is needed for compiling some R libraries.  
    

Update PATH
-----------

* Copy+paste the following::

    touch ~/.zshrc
    echo 'export PATH=$PATH:/opt/homebrew/opt/python/libexec/bin' >> ~/.zshrc
    echo 'export PATH=$PATH:/Library/Frameworks/R.framework/Resources' >> ~/.zshrc
    echo 'export PATH=$PATH:/usr/local/gfortran/bin' >> ~/.zshrc
    source ~/.zshrc

* .. collapse:: Details

    This adds python, R and gfortran to your path so the command line can use them.

R Libraries
-----------

* Copy+paste the following::
    
    Rscript -e "install.packages(c('afex','phia','snow','nlme','lmerTest'),repos='https://cloud.r-project.org')"

* .. collapse:: Details

    Installs the R libraries needed for some afni programs.
    This does not install ALL needed packages.
    Bayesian programs need other libraries.
    Some libraries other libraries are not available on macOS for R 3.6.3.
    (We are working on updating this)  ``afni_system_check.py -check_all`` 
    will show some missing libraries.

Install AFNI
------------

* Download installer and run it::
    
    curl -O https://afni.nimh.nih.gov/pub/dist/bin/misc/@update.afni.binaries
    tcsh @update.afni.binaries -package macos_10.12_local -do_extras

.. note::
    Upon first afni or suma launch, the terminal will pop up messages to ask for
    permissions to access various data on your system.
    Possibly including:
    Photos, Desktop, Contacts, Calendar, Reminders, Documents, Downloads.
    I would recommend NOT allowing Photos, Contacts, Calendars, and Reminders.
    But the others will be useful.

.. note::
    And if you launch afni from your home folder,
    you will get a lot of "Operation not permitted" errors/warnings from afni trying to
    find datasets in restricted folders under your home directory, 
    like "~/Library" etc. You can safely ignore those errors.

Reboot
------

.. include:: substep_mac_reboot.rst

Evaluate setup/system (**important!**)
-----------------------------------------

.. include:: substep_evaluate.rst


Optional Extras
---------------

.. collapse:: XQuartz settings (Justin does not like these)

    #. Copy+paste the following::

         defaults write org.macosforge.xquartz.X11 wm_ffm -bool true
         defaults write org.x.X11 wm_ffm -bool true
         defaults write com.apple.Terminal FocusFollowsMouse -string YES

|

.. collapse:: Setup Python

    .. include:: substep_miniconda.rst

|

.. collapse:: Prepare for Bootcamp

    .. include:: substep_bootcamp.rst

|

.. collapse:: Niceify terminal

    .. include:: substep_rcfiles_mac.rst
    
|

.. collapse:: Keep up-to-date (remember!)

    .. include:: substep_update.rst

|

.. collapse:: Enable more SUMA keypresses (recommended)

    .. include:: substep_mac_keyshortcuts.rst





