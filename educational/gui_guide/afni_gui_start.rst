.. _edu_afni03_start:


***********************************
**AFNI GUI: Startup**
***********************************

.. contents:: :local:

Start the AFNI GUI
==================

#. The basic way to start the AFNI GUI at the command line by typing::

     afni

   | *How does the AFNI GUI load datasets into memory when started?*
   | The ``afni`` GUI reads datasets from the current directory.  If
     there are no datasets in current directory, it tries to read
     sub-directories 1 level deeper.

   |

#. Read datasets from multiple directories::

     afni dir1 dir2 ...

   or specific datasets::

     afni file1 file2 dir1/file3 ...

#. Read datasets recursively, such as from the current directory and
   recursively from all directories below it::

     afni -R

#. Create 'sessions' of files from multiple sub-directories, gathering
   datasets with a single subject identified, like in the BIDS file
   hierarchy::

     afni -bysub ...

   or::

     afni -BIDS ...

   See ``afni -help`` or ``afni -hview`` for more details about these
   options.


Set special directories: datasets always loaded
=================================================

There are also special directories that can be specified to always
also be opened when you run the AFNI GUI. These often contain
reference templates and atlases, and this "always load" functionality
means that so these datasets don't have to be copied around.

These are specified with AFNI environment variables, such as

* ``AFNI_GLOBAL_SESSION`` 

* ``AFNI_ATLAS_PATH``

\.\.\. and more

For example, having ``AFNI_GLOBAL_SESSION =
/home/nbohr/REF_TEMPLATES`` in your AFNI settings file would lead to
datasets in the specified "REF_TEMPLATES/" directory always being
available for viewing in the AFNI GUI.


.. note:: AFNI reads a settings file named ``~/.afnirc`` from your
          home directory, if it is present.  This file is used to
          change many of the defaults (cf the :ref:`list of all AFNI
          environment variables <edu_env_vars>` to set there).


Jump within GUI Guide
========================

.. include:: substep_gui_jump.rst
