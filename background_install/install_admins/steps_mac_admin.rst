
.. _install_steps_mac_admin:

************************************************
*(old)* Mac OS, 10.9-10.15: administered system
************************************************

.. contents:: :local:

What to do?
============

Here we describe the two halves of installation AFNI on an
*administered* computer specifically running Mac OS versions
**10.9-10.15**. 

**Note:** This version of Mac computer (OS 10.9-10.15) is now **quite
old**, so please make sure this actually corresponds to your system
setup before starting.*

The instructions are split into 2 parts: 

* :ref:`administrator's part <install_steps_mac_adminA>`, for which
  **root privilege is required**.

* :ref:`regular user's part <install_steps_mac_adminR>`, for which
  root privilege is **not** required.

|

.. _install_steps_mac_adminA:

Part 1: *for the administrator*
============================================

Here we describe the administrator's part of the AFNI installation,
which must be performed prior to the user's part. 

Root privilege is **required** for the steps in this section.


Install Xcode and XQuartz
-------------------------

.. include:: ../install_instructs/substep_mac_xcode_xquartz.rst

Install R
---------

.. include:: ../install_instructs/substep_mac_R.rst

.. comment out older ver

   a. | Click here to download a recent (but not the *most*
        recent) version of R:
      | https://cran.r-project.org/bin/macosx/el-capitan/base/R-3.4.1.pkg

   #. Install specific R packages for AFNI (specified in the given script)::

         curl -LO https://afni.nimh.nih.gov/pub/dist/bin/macos_10.12_local/@afni_R_package_install
         tcsh @afni_R_package_install -afni


Install Netpbm
--------------

.. include:: ../install_instructs/substep_mac_netpbm.rst

.. comment out old
   .. include:: ../install_instructs/substep_netpbm.rst

.. comment out old-ish

   Using ``bash`` shell syntax::

      ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null 2> /dev/null
      brew install netpbm


.. no longer require/suggest

   Check shell
   -----------

   Most AFNI scripts are written in ``tcsh``, and most command line
   examples presented also use ``tcsh`` syntax.  While not necessary, it
   might make sense to have this the be the default shell for a user.  If
   you would like to do so, this can be done by clicking through the
   following: "System Preferences" -> "Users & Groups" -> click on lock
   and enter password -> right click on the username and go to "Advanced
   options" -> go down to where shell is and enter desired one.

---------------------------------------

.. _install_steps_mac_adminR:

Part 2: *for the regular user*
============================================

Here we describe the regular (= administrator) user's part of the AFNI
installation, which must be performed after the administrator's
part. 

Root privilege is **not** required for the steps in this section.

**Do** the system check in the "Evaluate" stage. Try any
recommendations in its "Please Fix" section.

If you run into any problems, please just ask a clear question on the
`Message Board <https://discuss.afni.nimh.nih.gov/>`__.

Check shell
-----------

To find out what shell you are using (e.g., ``bash`` or ``tcsh``),
type::

  echo $0

Most AFNI scripts are written in ``tcsh``, and most command line
examples presented also use ``tcsh`` syntax.  If you would like to
change your default shell, please ask your administrator to do so (as
it typically requires admin privileges on a Mac to do so).

Setup terminal
--------------

.. include:: /background_install/install_instructs/substep_mac_setup_term.rst


Install AFNI binaries
---------------------

.. include:: /background_install/install_instructs/substep_mac_abin.rst


Setup Mac environment variables
-----------------------------------

.. include:: /background_install/install_instructs/substep_mac_env.rst


Reboot
------

.. include:: /background_install/install_instructs/substep_mac_reboot.rst


.. ---------- HERE/BELOW: copy for all installs --------------


Prepare for Bootcamp
------------------------------------

.. include:: /background_install/install_instructs/substep_bootcamp.rst

Evaluate setup/system (**important!**)
-----------------------------------------

.. include:: /background_install/install_instructs/substep_evaluate.rst

Niceify terminal (optional, but goood)
--------------------------------------

.. include:: /background_install/install_instructs/substep_rcfiles_mac.rst

Keep up-to-date (remember!)
---------------------------

.. include:: /background_install/install_instructs/substep_update.rst

|


Enable more SUMA keypresses (recommended)
----------------------------------------------------------

.. include:: /background_install/install_instructs/substep_mac_keyshortcuts.rst










.. comment out

    Install PyQt4, via JDK and fink (optional)
    ------------------------------------------

    a. | Click on this link: http://www.oracle.com/technetwork/java/javase/downloads
       | and then click on the ``Java`` icon.

       **Purpose:** Install Java SE (standard edition) JDK.

    #. Copy+paste the following::

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
           sudo ln -s /sw/bin/python2.7 /sw/bin/python
           echo 'setenv PYTHONPATH /sw/lib/qt4-mac/lib/python2.7/site-packages' >> ~/.cshrc


    #. Test your PyQt4.

       Copy+paste the following::

         uber_subject.py

       Does a GUI open?  Or is there a crash??

       |


