.. _edu_afni03_datamode:


**************************************
**AFNI GUI: Datamode panel**
**************************************

.. contents:: :local:


.. _Define Datamode:

Define Datamode
===============

.. _gui_guide_datamode_open:

.. list-table::
   :widths: 40 60
   :header-rows: 1

   * - :ref:`Open Define Datamode Panel<gui_guide_datamode_open>`
     - 
   * - * Click the ``Define Datamode ->`` button to open the datamode
         panel.
       * This controls the mode in which the underlay and overlay are viewed.
       * Also allows you to save 3D datasets to disk.
       
     - .. image:: media/datamode_open.png
          :width: 100%
          :align: right

.. _gui_guide_datamode_ulay:

.. list-table::
   :widths: 60 40
   :header-rows: 1

   * - :ref:`Underlay Settings<gui_guide_datamode_ulay>`
     - 
   * - * ``View ULay Data Brick`` Data from the underlay file is displayed.
         (will be grayed out if data is not available)
       * ``Warp ULay on Demand`` Data is resampled as needed for display.
       * ``ULay Resam mode`` This controls the resampling mode for the 
         underlay data (for display and writing).
         
         * NN = nearest neighbor (fastest)
         * Li = linear interpolation (OK)
         * Cu = cubic interpolationg (nice but slow)
         * Bk = blocky interpolation (between NN and Li)
         
       * ``Resam (mm)`` Set the (cubical) voxel dimensions for the data 
         resampling.

     - .. image:: media/datamode_ULay.png
          :width: 100%
          :align: right

.. _gui_guide_datamode_olay:

.. list-table::
   :widths: 60 40
   :header-rows: 1

   * - :ref:`Overlay Settings<gui_guide_datamode_olay>`
     - 
   * - * ``View OLay Data Brick`` Data from the overlay file is displayed.
         (will be grayed out if data is not available)
       * ``Warp OLay on Demand`` Data is resampled as needed for display.
         
         * Overlay data is always on top of underlay data. 
           To be displayed directly from the overlay data brick,
           this brick must conform in dimensions to the underlay
           data being displayed.  
         * Even if the overlay brick exists,
           if its dimensions do not correspond to the underlay brick
           or the resampling dimension (below), then the overlay data
           being displayed will be 'warped-on-demand'. Such warping
           always occurs from the 'most original' source. 
         * For example,
           if a Talairach view brick is altered (via a plugin, or another
           external editing program), then viewing the brick may be quite
           different from viewing the warped data, which will be recomputed
           from the Original view brick (if available), without reference
           to whatever alterations may have been made in the Talairach view.
         
       * ``OLay Resam mode`` This controls the resampling mode for the 
         overlay data (for display and writing). This applies to dataset 
         sub-bricks **without** statistical parameters attached. 
         :ref:`(choices are the same as the underlay).<gui_guide_datamode_ulay>`
       * ``Stat Resam mode`` Same as above but for dataset sub-bricks **with**
         statistical parameters.

     - .. image:: media/datamode_OLay.png
          :width: 100%
          :align: right

.. _gui_guide_datamode_Resamp:

.. list-table::
   :widths: 60 40
   :header-rows: 1

   * - :ref:`Saving Resampled Datasets<gui_guide_datamode_Resamp>`
     - 
   * - * The purpose of the ``Resamp`` buttons  is to recompute entire dataset 
         bricks in the current coordinate system ('view') and write them to 
         disk. The various ``Resamp`` controls determine the resolution and 
         interpolation method used in creating the new bricks.
       * ``ULay`` writes the current underlay dataset brick.
       * ``OLay`` writes the current overlay dataset brick.
       * ``Many`` allows you to select one or more datasets from a list.
       * Only dataset bricks that are warped from a *parent* dataset can be 
         written out.
       * ``Resamp`` will not destroy original data (The Bob has spoken).
       * This operation might be very time-consuming, especially for big 
         3D+time datasets!
       * Resampling a big 3D+time dataset to 1 mm grid size is usually 
         pointless and will use up a **LOT** of disk space.
       * You can write a dataset to disk under a new name (but not resampled)
         using the ``SaveAs`` buttons.

     - .. image:: media/datamode_Resamp.png
          :width: 100%
          :align: right

.. _gui_guide_datamode_SaveAs:

.. list-table::
   :widths: 60 40
   :header-rows: 1

   * - :ref:`Save As<gui_guide_datamode_SaveAs>`
     - 
   * - * The ``SaveAs`` buttons let you write out one of the current datasets 
         (Underlay or Overlay) under a new name.
       * These datasets will be written at the spatial resolution they are 
         stored in -- **they won't be resampled**.
       * Datasets that are 'warp-on-demand' (don't have their on data) cannot 
         be ``SaveAs``'ed!
       * If you do not give an extension, the dataset will be saved in afni 
         format.
       * If you give a ``.nii`` extension, you will get an **uncompressed** 
         nifti dataset.
       * If you give a ``.nii.gz`` extension, you will get a **compressed** 
         nifti dataset.
       * It is possible to over-write an existing dataset with ``SaveAs``,
         but this is usually **NOT** advisable, unless you are going to quit 
         ``AFNI`` almost immediately.
       * **need screen caps here**

     - .. image:: media/datamode_SaveAs.png
          :width: 100%
          :align: right

.. _gui_guide_datamode_ReScan_Read:

.. list-table::
   :widths: 60 40
   :header-rows: 1

   * - :ref:`Rescan and Read<gui_guide_datamode_ReScan_Read>`
     - 
   * - * The purpose of the ``Rescan`` buttons is to read the contents of 
         session directories again in order to make newly created datasets 
         (e.g., from the ``3dmerge`` program or the ``SaveAs`` button) 
         available for ``AFNI`` viewing. 
         
         * ``This`` rescans just the current session. This has the same effect 
           as clicking the ``UnderLay`` or ``OverLay`` buttons in the main 
           panel after adding new datasets. 
           :ref:`(See here.)<gui_guide_main_load_dsets>`
         * **need screen caps here**
         * ``All`` rescans all session directories.
         * ``*.1D`` rescans for timeseries files instead of AFNI datasets. 
           Note that the program won't re-read a filename that has already 
           been read in. This means that if you change the contents of a 
           ``.1D`` file, ``AFNI`` will not be aware of that fact even after 
           this rescan operation.

       * The purpose of the ``Read`` buttons is to read in new data. (The 
         ``Rescan`` buttons are to re-read data from old directories.) 
         
         * ``Sess`` opens a directory chooser window to read a new session 
           directory. This has the same functionality as the ``Read`` button 
           in the main controller panel. 
         * **need screen caps here**
           :ref:`(See here.)<gui_guide_controller_window_DataDir>`
         * ``1D`` opens a file chooser window to read a new timeseries file.
         * ``Web`` opens a dialog box to enter an address to read datasets 
           from the *Web*. e.g., ``https://some.place/dir/anat+orig`` or 
           ``ftp://some.place/dir/func.nii.gz``. You can also read from a list 
           of datasets by using ``https://some.place/dir/AFNILIST`` where 
           ``AFNILIST`` is a text file with one dataset name per line (will be 
           fetched from the same Web directory; do **NOT** put ``ftp://`` or 
           ``https://`` in the ``AFNILIST`` file!).

     - .. image:: media/datamode_ReScan_Read.png
          :width: 100%
          :align: right


Jump within GUI Guide
========================

.. include:: substep_gui_jump.rst
