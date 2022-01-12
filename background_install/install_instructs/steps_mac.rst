
.. _install_steps_mac:

**Mac OS, 10.9-15** *(via command line)*
===============================================

.. contents:: The essential system setup
   :local:

.. highlight:: none

What to do?
-----------

These setup instructions are for **Mac OS versions 10.9-15**.

.. note:: *If you are seeking the new App version of install
          instructions, *and have a Mac OS version 10.13-15*, please
          :ref:`click HERE <install_steps_mac_app>`.

.. include:: substep_intro.rst

#. To open a text file, you can type ``open -t FILENAME``.  For
   example, to open the bash "rc" file::

     open -t ~/.bashrc 

Setup terminal
--------------

.. include:: substep_mac_setup_term.rst

Install Xcode and XQuartz
-------------------------

.. include:: substep_mac_xcode_xquartz.rst

Setup Mac env variables
-------------------------

.. include:: substep_mac_env.rst


Install AFNI binaries
---------------------

.. include:: substep_mac_abin.rst


Reboot
------

.. include:: substep_mac_reboot.rst

Install R
---------

.. include:: substep_mac_R.rst


Install Netpbm
--------------

.. include:: substep_mac_netpbm.rst

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


