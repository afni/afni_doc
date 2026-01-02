
.. _install_steps_mac12_Silicon_admin:

******************************************************************
**macOS 12+ (Silicon/ARM chip: M1, M2, ...), administered system**
******************************************************************

.. contents:: The essential system setup
   :local:

.. highlight:: none

Overview
============

These setup instructions are for particular macOS systems:

* **version:** macOS 12 or greater

* **chip:** Silicon/ARM compiler (M1, M2, M3, M4, ...)

* an **administered computer**, meaning that the user does not have
  "root" privileges but they work with an administrator who does.

* the computer is **not an NIMH-administered one**, for which there are
  specific instructions for macOS 12 or greater with Silicon/ARM CPUs
  :ref:`here <install_steps_mac12_Silicon>`.

If you have any questions about this or other installation issues,
please ask us on the `Message Board
<https://discuss.afni.nimh.nih.gov/>`__.

Here are a few notes that might be useful user users and admins alike:

.. include:: ../install_instructs/substep_macos12_intro.rst


.. _install_steps_mac12_Silicon_adminA:

Part 1: *for the administrator*
============================================

Here we describe the administrator's part of the AFNI installation,
which must be performed prior to the user's part.  Root privilege is
**required** for the steps in this section.

Install dependencies
----------------------

A. Copy+paste the following to get download scripts::

     cd
     curl -O https://raw.githubusercontent.com/afni/afni/master/src/other_builds/OS_notes.macos_12_ARM_a_admin_pt1.zsh
     curl -O https://raw.githubusercontent.com/afni/afni/master/src/other_builds/OS_notes.macos_12_ARM_a_admin_pt2.zsh

#. Copy+paste the following to run the first admin-level install
   script (which will ask you to enter your administrator password,
   **twice (once early, once later)**)::

     zsh OS_notes.macos_12_ARM_a_admin_pt1.zsh

#. Copy+paste the following to run the second admin-level install
   script (which will ask you to enter your administrator password)::

     zsh OS_notes.macos_12_ARM_a_admin_pt2.zsh

#. Reboot the computer (for the changes to take effect).

-----------------------------------

.. _install_steps_mac12_Silicon_adminR:

Part 2: *for the regular user*
============================================

Here we describe the regular (= administrator) user's part of the AFNI
installation, which must be performed after the administrator's part.
Root privilege is **not** required for the steps in this section.

Install AFNI
----------------------

A. Copy+paste the following to get download scripts::

     cd
     curl -O https://raw.githubusercontent.com/afni/afni/master/src/other_builds/OS_notes.macos_12_ARM_b_user.tcsh

#. Copy+paste the following to run the user-level install script (no
   password required)::

     tcsh OS_notes.macos_12_ARM_b_user.tcsh

#. To get additional Python libraries used in AFNI, it currently
   appears most efficient on macOS to use `conda` (e.g., Miniconda or
   Anaconda). :ref:`Quick Miniconda Setup <install_miniconda_quick>`
   instructions are provided, with the necessary set of Python
   libraries provided for an environment (e.g., in
   "environment_ex1.yml"). These could be added to an existing
   environment, or used to create a new one. 

Evaluate setup/system (**important!**)
-----------------------------------------

.. include:: ../install_instructs/substep_evaluate.rst


Optional Extras
---------------

Setup Python (*a* method)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. include:: ../install_instructs/substep_miniconda.rst


Prepare for Bootcamp  (install demo data)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. include:: ../install_instructs/substep_bootcamp.rst


Setup terminal (opt)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. include:: ../install_instructs/substep_mac_setup_term.rst


Niceify terminal (add convenience!)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. include:: ../install_instructs/substep_rcfiles_mac.rst


Install extras (recommended for Bootcamp prep)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. include:: ../install_instructs/substep_extra_packs.rst


Keep up-to-date (remember!)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. include:: ../install_instructs/substep_update.rst


Enable more SUMA keypresses (recommended)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. include:: ../install_instructs/substep_mac_keyshortcuts.rst


