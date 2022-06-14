
.. _install_steps_mac12_intel:

**macOS, 12+ (Intel chip)**
===============================================

.. contents:: The essential system setup
   :local:

.. highlight:: none

What to do?
-----------

These setup instructions are for **macOS 12.3.1 or greater with Intel
CPUs** (not :ref:`Apple Silicon <install_steps_mac12_Silicon>`).


.. include:: substep_macos12_intro.rst


Install Homebrew and packages (admin)
-------------------------------------

.. include:: substep_macos12_R_gfortran.rst


Install R (admin)
-----------------

.. include:: substep_macos12_homebrew.rst


Update Path
-----------

.. nts:
   different than Silicon, for python

#. **Path** (zsh)::

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


Reboot
------

.. include:: substep_mac_reboot.rst

Evaluate setup/system (**important!**)
-----------------------------------------

.. include:: substep_evaluate.rst


Optional Extras
---------------


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


