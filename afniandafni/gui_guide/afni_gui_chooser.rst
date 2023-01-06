.. _edu_afni03_chooser:


*********************************************
**AFNI GUI: Chooser menu**
*********************************************

.. contents:: :local:



Dataset Chooser
===============

.. _gui_guide_chooser_start:

.. list-table::
   :widths: 60 40
   :header-rows: 1

   * - :ref:`Open chooser window<gui_guide_chooser_start>`
     - 
   * - * Click the ``UnderLay`` or ``OverLay`` button to open a
         dataset chooser window.
       
     - .. image:: media/afni_controller_window_under_over_lay.png
          :width: 100%
          :align: right

.. _gui_guide_chooser_window:

.. list-table::
   :widths: 60 40
   :header-rows: 1

   * - :ref:`Chooser window details<gui_guide_chooser_window>`
     - 
   * - * The dialog window will indicate ``Underlay`` or ``Overlay`` 
         coresponding to which button you clicked.
       * The chooser will list the datasets available in the current directory.
       * By default when you start ``afni``, it will automatically load the 
         first dataset alphabetically and that will be selected in your chooser 
         menu. (You can set the ``AFNI_START_SMALL`` environment variable to 
         ``YES`` which will default to loading the dataset with the smallest 
         file size first for speed)
       * The left column has prefix names of datasets.
         
         * Datasets without an extension are in afni's ``.BRIK`` and 
           ``.HEAD`` format.
         * NIFTI formatted dataset will show the ``.nii`` or ``.nii.gz`` 
           extension.
   
       * The right column has a little information about each dataset.
       
         * How dataset was classified when it was created. Usually from 
           ``to3d``, ``dcm2nii_afni``, ``dimon``, etc..
         * Number of sub-bricks.
         * The ``*`` indicates that the dataset can be graphed 
           :ref:`(see here).<edu_afni03_graph>`
         * The ``z`` at the end indicates that the dataset is compressed.
    
       * In this example:
       
         * ``FT_anat`` is an anatomical bucket dataset with 1 sub-brick 
           and is in uncompressed afni format.
         * The next 3 datasets are eco-planar (EPI) datasets with 152 
           sub-bricks (``TRs``) in uncompressed afni format.
         * The next 2 datasets are eco-planar (EPI) datasets with 152 
           sub-bricks (``TRs``) in NIFTI format. One uncompressed the other 
           compressed.
     
     - .. image:: media/dataset_chooser_underlay.png
          :width: 100%
          :align: right
          
          
.. _gui_guide_chooser_choice:

.. list-table::
   :widths: 60 40
   :header-rows: 1

   * - :ref:`To choose a dataset<gui_guide_chooser_choice>`
     - 
   * - * Click on label, or scroll with mouse scroll-wheel, use keyboard, 
         arrows, or click the ``Index`` up / down arrows.
       * Press ``Apply`` button to select the highlighted dataset, and 
         also keep the chooser window open.
       * Press ``Set`` button to select the highlighted dataset, and also 
         close the chooser window.
       * Set environment variable ``AFNI_DATASET_BROWSE`` to ``YES`` to have 
         AFNI switch to that dataset immediately upon selection 
         (don't need to use ``Apply`` or ``Set``).
       * Environment variables can be set in your ``.afnirc`` file, or by 
         using the ``Edit Environment`` control panel 
         (cf. ``Define Datamode`` ⇒ ``Misc``).
         
         * :ref:`See here for the datamode panel<edu_afni03_datamode>`.
         * `See here for the list of all AFNI environment variables
           <https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/educational/readme_env_vars.html>`_.



     - .. image:: media/dataset_chooser_underlay.png
          :width: 100%
          :align: right


Jump within GUI Guide
========================

.. include:: substep_gui_jump.rst
