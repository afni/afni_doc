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

.. list-table::
   :widths: 50 50
   :header-rows: 0
   
   * - * Read datasets from multiple directories:

         .. code-block:: 
          
            afni dir1 dir2 ...
            
     - * Read specific datasets:
       
         .. code-block:: 
          
            afni file1 file2 dir1/file3 ...
     
   * - *  Read datasets recursively, from the current directory and
          recursively from all directories below it:
   
          .. code-block:: 
    
           afni -R

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
         <https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/programs/afni_sphx.html#ahelp-afni>`_
 
     - 

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
