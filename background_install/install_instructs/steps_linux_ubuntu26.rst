
.. _install_steps_linux_ubuntu26:


**Linux, Ubuntu 26.04**
===================================================================

.. contents:: The essential system setup
   :local:

.. highlight:: none

These setup instructions are for **Ubuntu Linux version 26.04**
(Resolute Raccoon).

Things to note before starting
--------------------------------

.. include:: substep_intro.rst

#. **To copy and paste** in a Linux terminal, one can use
   ``Ctrl+Shift+c`` and ``Ctrl+Shift+v``, respectively.  (In WSL
   terminals, one might first enable this functionality: rightclick on
   the panel's taskbar, select "Properties" and put a checkmark by
   this option.)

#. **To open a text file,** use any text editor you like, and/or you
   can type ``gedit FILENAME``, such as either::

     gedit ~/.bashrc 

     gedit ~/.bashrc &


Quick setup
----------------------------------

.. include:: substep_linux_ubuntu_26_64.rst


.. ---------- HERE/BELOW: copy+paste after (new) quick setup --------------


(optional) Prepare for Bootcamp
-----------------------------------

.. include:: substep_bootcamp.rst


Evaluate setup/system (**important!**)
--------------------------------------------

.. include:: substep_evaluate.rst


(optional) Install extra R packages
-----------------------------------------------

.. include:: substep_extra_packs.rst

Keep up-to-date (remember!)
------------------------------------------------

.. include:: substep_update.rst


A note on setting up Python/using Conda (opt)
-----------------------------------------------

*For this OS, you should* not *need to do anything further to set up
your Python*.

.. include:: substep_miniconda.rst
