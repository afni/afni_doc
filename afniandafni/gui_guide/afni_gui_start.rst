.. _edu_afni03_start:


***********************************
**AFNI GUI: Startup**
***********************************

.. contents:: :local:

Start the AFNI GUI
==================

.. list-table::
   :widths: 60 40
   :header-rows: 0
   
   * - * The basic way to start the AFNI GUI at the command line is by typing:
                                                                            
          .. code-block:: 
             
             afni                                                         
                                                                            
        | *How does the AFNI GUI load datasets into memory when started?* 
        |  
        | The ``afni`` GUI reads datasets from the current directory.  If   
          there are no datasets in current directory, it tries to read      
          sub-directories 1 level deeper.                                   
     
     - .. image:: media/afni_controller_window.png
          :width: 100%
          :align: right                                

Start the AFNI GUI *Advanced*
=============================

This describes how to read datasets from multiple directory locations
or specific subsets of files in a directory.  See also the :ref:`next
section below <edu_afni03_start_permaload>` about specifying a special
directory to *always* load, such as one with reference volumes.

.. list-table::
   :widths: 50 50
   :header-rows: 0
   
   * - * Read datasets from multiple directories (the ``-all_dsets``
         means that all dsets in the directories will be loaded, with
         directory path shown in the selection menu):

         .. code-block:: 
          
            afni -all_dsets dir1 dir2 ...

     - * Read specific datasets (e.g., if the directory has very many
         datasets and browsing a subset is easier; or opening specific
         datasets across multiple directories):
       
         .. code-block:: 
          
            afni file1 file2 dir1/file3 ...
                 
   * - * Read datasets recursively, starting from the current
         directory and then into all directories below it (loading
         all at the same time; otherwise, exclude ``-all_dsets``):
   
         .. code-block:: 
    
            afni -R -all_dsets

     - * Create 'sessions' of files from multiple sub-directories, gathering
         datasets with a single subject identified, like in the BIDS file
         hierarchy (more details in help):
       
         .. code-block:: 
          
            afni -bysub sub-xyz ...
            
         or 
         
         .. code-block:: 
          
            afni -BIDS sub-xyz ...

   * - * See ``afni -help`` or ``afni -hview`` for more details about these
         options or click `here
         <https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/programs/afni_sphx.html#ahelp-afni>`__.
 
     - 

.. _edu_afni03_start_permaload:

Set special directories: datasets always loaded
=================================================

There are also special directories that can be specified to always
also be loaded when you run the AFNI GUI. These often contain
reference templates and atlases, and this "always load" functionality
means that copies of these datasets don't have to be in every working directory.

These are specified with AFNI environment variables, such as:

* ``AFNI_GLOBAL_SESSION`` 

* ``AFNI_ATLAS_PATH``

\.\.\. and more

For example, having ``AFNI_GLOBAL_SESSION =
/home/nbohr/REF_TEMPLATES`` in your AFNI settings file (``~/.afnirc``) 
would load datasets in the "REF_TEMPLATES/" directory so they are always
available for viewing in the AFNI GUI.

.. note:: AFNI reads the settings file named ``~/.afnirc`` from your
          home directory, if it is present.  This file is used to
          change many of the defaults (cf the `list of all AFNI environment variables
          <https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/educational/readme_env_vars.html>`_ 
          to set there).


Jump within GUI Guide
========================

.. include:: substep_gui_jump.rst
