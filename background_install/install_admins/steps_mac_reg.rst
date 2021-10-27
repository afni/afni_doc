
.. _install_steps_mac_adminR:


Mac OS (admin'ed): *the regular user part*
============================================

.. contents:: :local:

What to do?
-----------

Here we describe the regular users's part of the AFNI installation and
system setup for *administered* Mac OS versions **10.9+**.  Root
privilege **is not** required.

These are accompanied by :ref:`instructions for administrators
<install_steps_mac_adminA>`, **which need to be performed before the
commands listed here.**

**Do** the system check in the "Evaluate" stage. Try any
recommendations in its "Please Fix" section.

If you run into any problems, please just ask a clear question on the
`Message Board <https://afni.nimh.nih.gov/afni/community/board/>`_.



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

.. include:: ../install_instructs/substep_mac_setup_term.rst


Install AFNI binaries
---------------------

.. include:: ../install_instructs/substep_mac_abin.rst

Set default AFNI+SUMA environment variables
--------------------------------------------

.. include:: ../install_instructs/substep_profiles.rst

Setup Mac environment variables
-----------------------------------

.. include:: ../install_instructs/substep_mac_env.rst


Reboot
------

.. include:: ../install_instructs/substep_mac_reboot.rst


.. ---------- HERE/BELOW: copy for all installs --------------

Make AFNI/SUMA profiles
-----------------------

.. include:: ../install_instructs/substep_profiles.rst

Prepare for Bootcamp
------------------------------------

.. include:: ../install_instructs/substep_bootcamp.rst

Evaluate setup/system (**important!**)
-----------------------------------------

.. include:: ../install_instructs/substep_evaluate.rst

Niceify terminal (optional, but goood)
--------------------------------------

.. include:: ../install_instructs/substep_rcfiles_mac.rst

Keep up-to-date (remember!)
---------------------------

.. include:: ../install_instructs/substep_update.rst

|


Enable more SUMA keypresses (recommended)
----------------------------------------------------------

.. include:: ../install_instructs/substep_mac_keyshortcuts.rst










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


