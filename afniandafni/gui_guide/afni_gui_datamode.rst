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
         * Cu = cubic interpolationq (nice but slow)
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
         
         * Note: Overlay data is always on top of underlay data. 
           To be displayed directly from the overlay data brick,
           this brick must conform in dimensions to the underlay
           data being displayed.  Even if the overlay brick exists,
           if its dimensions do not correspond to the underlay brick
           or the resampling dimension (below), then the overlay data
           being displayed will be 'warped-on-demand'.  Such warping
           always occurs from the 'most original' source.  For example,
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

Jump within GUI Guide
========================

.. include:: substep_gui_jump.rst
