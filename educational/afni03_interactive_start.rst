.. _edu_afni03_start:


***********************************
**GUI guide: Startup and overview**
***********************************

.. contents:: :local:
  
.. include:: substep_afni03_jump.rst


**Download the pdf version of the original AFNI interactive guide here:**
`afni03_interactive.pdf
<https://afni.nimh.nih.gov/pub/dist/edu/data/CD.expanded/afni_handouts/afni03_interactive.pdf>`_


Start the AFNI GUI
==================

#. Start the GUI by typing ``afni`` at the command line::

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


AFNI GUI Overview
===================================

text 

.. list-table:: 
   :header-rows: 1
   :width: 100%
   :align: center

   * - Main controller and windows
   * - .. image:: media/afni03_interactive/afni_interactive_overv_main.png
          :width: 100%
          :align: center

|

text

|

.. list-table:: 
   :header-rows: 1
   :width: 100%
   :align: center

   * - Image window panel and menus
   * - .. image:: media/afni03_interactive/afni_interactive_overv_image.png
          :width: 100%
          :align: center

|

text

|

.. list-table:: 
   :header-rows: 1
   :width: 100%
   :align: center

   * - Datamode panel and menus
   * - .. image:: media/afni03_interactive/afni_interactive_overv_datamode.png
          :width: 100%
          :align: center

.. include:: substep_afni03_jump.rst
