
.. _install_steps_mac12_Silicon:

**macOS, 12+ (Apple Silicon: M1, M2, ...)**
==============================================

.. contents:: The essential system setup
   :local:

.. highlight:: none

What to do?
-----------

These setup instructions are for **macOS 12.3.1 or greater with Apple
Silicon CPUs** (not :ref:`Intel chips <install_steps_mac12_Intel>`).


.. include:: substep_macos12_intro.rst


Install Rosetta 2 (admin)
-------------------------------------
   
#. **Rosetta**::
    
     softwareupdate --install-rosetta
    
**Purpose:** This installs the Rosetta 2 system that allows the Apple
Silicon machines to run Intel-compiled binaries.  At present, AFNI is
not compiled for Apple Silicon (on our to-do list).
     
   
Install Homebrew and packages (admin)
-------------------------------------

.. include:: substep_macos12_R_gfortran.rst


Install R (admin)
-----------------

.. include:: substep_macos12_homebrew.rst


Update Path
-----------

.. nts:
   different than Intel, for python

#. **Add to path** (zsh)::

     touch ~/.zshrc
     echo 'export PATH=$PATH:/opt/homebrew/opt/python/libexec/bin'      >> ~/.zshrc
     echo 'export PATH=$PATH:/Library/Frameworks/R.framework/Resources' >> ~/.zshrc
     echo 'export PATH=$PATH:/usr/local/gfortran/bin'                   >> ~/.zshrc
     source ~/.zshrc

**Purpose:** This adds ``python``, ``R`` and ``gfortran`` to your path
so the command line can use them.  Assumes ``zsh`` is your login shell
(the Mac default).

Install R Libraries
---------------------

.. include:: substep_macos12_Rpkgs.rst


Install AFNI
------------

.. include:: substep_macos12_afni.rst


Reboot
------

.. include:: substep_mac_reboot.rst

Evaluate setup/system (**important!**)
-----------------------------------------

.. include:: substep_evaluate.rst

Prepare for Bootcamp (opt)
-----------------------------------------

.. include:: substep_bootcamp.rst

Optional Extras
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




