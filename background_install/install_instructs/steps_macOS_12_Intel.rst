
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

Quick setup
----------------------------------

*Special case, for macOS computers administered by NIMH (NIH, USA):* 

A. Use the *NIMH Self Service* application to install the dependencies
   needed by AFNI (PIV-card **required**).  \*\*\*\ *Coming soon.*\ \*\*\*

#. Copy+paste the following to get a download script::

     cd
     curl -O https://raw.githubusercontent.com/afni/afni/master/src/other_builds/OS_notes.macos_12_intel_b_user.tcsh

#. Copy+paste the following to run the install script (**do not** use ``sudo`` here)::

     tcsh OS_notes.macos_12_intel_b_user.tcsh

*General case:* 

A. Copy+paste the following to get download scripts::

     cd
     curl -O https://raw.githubusercontent.com/afni/afni/master/src/other_builds/OS_notes.macos_12_intel_a_admin.zsh
     curl -O https://raw.githubusercontent.com/afni/afni/master/src/other_builds/OS_notes.macos_12_intel_b_user.tcsh

#. Copy+paste the following to run the first install script
   (**requires** ``sudo`` with password)::

     sudo zsh OS_notes.macos_12_intel_a_admin.zsh

#. Reboot the computer (for the changes to take effect).

#. Copy+paste the following to run the second install script (**do
   not** use ``sudo`` here)::

     tcsh OS_notes.macos_12_intel_b_user.tcsh



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


