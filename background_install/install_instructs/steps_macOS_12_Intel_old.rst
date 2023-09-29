
.. _install_steps_mac12_intel_old:

**\*Old* notes, macOS 12 (Intel chip, precompiled binaries)**
================================================================

.. contents:: The essential system setup
   :local:

.. highlight:: none

What to do?
-----------

These setup instructions are for **macOS 12 with Intel CPUs** (not
:ref:`Apple Silicon <install_steps_mac12_Silicon>`).


.. include:: substep_macos12_intro_old.rst


Install Homebrew and packages (admin)
-------------------------------------

.. include:: substep_macos12_homebrew.rst


Install R (admin)
-----------------

.. include:: substep_macos12_R_gfortran.rst


Update Path
-----------

.. nts:
   different than Silicon, for python

#. **Add to path** (zsh)::

    touch ~/.zshrc
    echo 'export PATH=$PATH:/usr/local/opt/python/libexec/bin'         >> ~/.zshrc
    echo 'export PATH=$PATH:/Library/Frameworks/R.framework/Resources' >> ~/.zshrc
    echo 'export PATH=$PATH:/usr/local/gfortran/bin'                   >> ~/.zshrc
    source ~/.zshrc

**Purpose:** This adds ``python``, ``R`` and ``gfortran`` to your path
so the command line can use them.  Assumes ``zsh`` is your login shell
(the Mac default).


R Libraries
-----------

.. include:: substep_macos12_Rpkgs.rst


Install AFNI
------------

.. include:: substep_macos12_afni.rst


.. should not be necessary:
   Reboot
   ------

   .. include:: substep_mac_reboot.rst


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


