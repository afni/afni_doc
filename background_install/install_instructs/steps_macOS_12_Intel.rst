
.. _install_steps_mac12_intel:

**macOS 12+ (Intel processor/chip)**
================================================================

.. contents:: The essential system setup
   :local:

.. highlight:: none

What to do?
-----------

These setup instructions are for **macOS 12 or greater with Intel
CPUs** (not :ref:`Apple Silicon <install_steps_mac12_Silicon>`).


.. include:: substep_macos12_intro.rst

Quick setup (General users)
----------------------------------

This section describes primary installation instructions *for general
users, and it is assumed that you have administrative/sudo privileges
on your macOS computer:*

A. Copy+paste the following to get download scripts::

     cd
     curl -O https://raw.githubusercontent.com/afni/afni/master/src/other_builds/OS_notes.macos_12_intel_a_admin_pt1.zsh
     curl -O https://raw.githubusercontent.com/afni/afni/master/src/other_builds/OS_notes.macos_12_intel_a_admin_pt2.zsh
     curl -O https://raw.githubusercontent.com/afni/afni/master/src/other_builds/OS_notes.macos_12_intel_b_user.tcsh

#. Copy+paste the following to run the first admin-level install
   script (which will ask you to enter your administrator password)::

     zsh OS_notes.macos_12_intel_a_admin_pt1.zsh

#. Copy+paste the following to run the second admin-level install
   script (which will ask you to enter your administrator password)::

     zsh OS_notes.macos_12_intel_a_admin_pt2.zsh

#. Reboot the computer (for the changes to take effect).

   |

#. Copy+paste the following to run the user-level install script (no
   password required)::

     tcsh OS_notes.macos_12_intel_b_user.tcsh

Quick setup (special case: NIMH-administered computers)
---------------------------------------------------------

This section describes primary installation instructions *for the
special case of having a macOS computer administered by NIMH (NIH,
USA), where the user does not have admin privileges:*

A. Use the *NIMH Self Service* application to install the dependencies
   needed by AFNI (PIV-card **required**):
   
   .. list-table:: 
      :header-rows: 0
      :widths: 33 33 33
      :stub-columns: 0

      *  - 1. Open the NIMH Self Service App on the Mac
         - 2. Type AFNI in the search bar:
         - 3. Click "Install" for "AFNI Dependencies":
      *  - 
         - .. image:: media/img_nimh_selfservice_app.png
              :width: 100%
         - .. image:: media/img_nimh_selfservice_app_afni_icon.png
              :width: 100%  

   |
   
#. Copy+paste the following to get a download script::

     cd
     curl -O https://raw.githubusercontent.com/afni/afni/master/src/other_builds/OS_notes.macos_12_intel_b_user.tcsh

#. Copy+paste the following to run the user-level install script (no
   password required)::

     tcsh OS_notes.macos_12_intel_b_user.tcsh

*Thanks to the NIMH Mac Engineering team for helping to set this set
of instructions up.*


Evaluate setup/system (**important!**)
-----------------------------------------

.. include:: substep_evaluate.rst


Optional Extras
---------------

Setup Python (*a* method)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. include:: substep_miniconda.rst


Prepare for Bootcamp  (install demo data)
-----------------------------------------

.. include:: substep_bootcamp.rst


Setup terminal (opt)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. include:: substep_mac_setup_term.rst


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


