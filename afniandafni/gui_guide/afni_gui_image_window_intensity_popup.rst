.. _edu_afni03_image_window_intensity_popup:


**********************************************
**AFNI GUI: Image Window Intensity Bar Popup**
**********************************************

.. contents:: :local:

.. list-table:: 
   :header-rows: 1
   :width: 40%
   :align: center

   * - AFNI GUI: Image Window Intensity Bar Popup
   * - .. image:: media/image_window_IntensityBar_Popup.png
          :width: 75%
          :align: center
   * - :ref:`Right click on the image window intensity bar.
       <gui_guide_image_window_IntensityBar>`

Intensity Bar Hidden Popup
==========================

These options apply to the ``Underlay`` data set exclusively.

.. _gui_guide_image_window_IntensityBar_Popup_disp_range:

.. list-table::
   :widths: 80 20
   :header-rows: 1

   * - :ref:`Choose Display Range
       <gui_guide_image_window_IntensityBar_Popup_disp_range>`
     - 
   * - * ``Choose Display Range`` pops up a dialog box that allows you to set 
         the bottom and top intensity values to display in the image 
         window.  

       * This anatomical image has intensity values that range from 0 to 4111.
         The ``Clean`` button shows that the AFNI gui is already and by 
         default, showing a range of 2% to 98%. The histogram below shows the 
         number of voxels at each of the intensity values. Notice the large 
         number of voxels near zero. Those are excluded in the default view of 
         2% minimum. (that is a good thing)
         
         .. list-table::
            :width: 100%
            :align: center
            :header-rows: 0
 
            * - .. image:: media/image_window_IntensityBar_Popup_disp_range_clean.png
                   :width: 100%
            
              - .. image:: media/image_window_IntensityBar_Popup_disp_range_clean_hist.png
                   :width: 100%

       * This is the same anatomical image but with the bottom 200 values 
         excluded. Notice the intensity range was changed to ``[User]``
         
         .. list-table::
            :width: 100%
            :align: center
            :header-rows: 0
 
            * - .. image:: media/image_window_IntensityBar_Popup_disp_range_200_4111.png
                   :width: 100%
            
              - .. image:: media/image_window_IntensityBar_Popup_disp_range_200_4111_hist.png
                   :width: 100%

     - .. image:: media/image_window_IntensityBar_Popup_disp_range.png
          :width: 100%
          :align: right


.. _gui_guide_image_window_IntensityBar_Popup_zero_color:

.. list-table::
   :widths: 80 20
   :header-rows: 1

   * - :ref:`Choose Zero Color
       <gui_guide_image_window_IntensityBar_Popup_zero_color>`
     - 
   * - * ``Choose Zero Color`` Allows you to choose a color to represent the 
         value of zero (0).  In the example on the left, the zero color is 
         changed to white.  The default option is ``none``.
       
         .. list-table::
            :width: 100%
            :align: center
            :header-rows: 0
 
            * - .. image:: media/image_window_IntensityBar_Popup_zero_color_cont.png
                   :width: 100%
            
              - .. image:: media/image_window_IntensityBar_Popup_zero_color_white.png
                   :width: 100%

         .. list-table::
            :width: 100%
            :align: center
            :header-rows: 0

            * - This is more useful for masked data so you can change the 
                background color and save out the image for a more stylistic 
                version for a paper.

              - .. image:: media/image_window_IntensityBar_Popup_zero_color_white_mni.png
                   :width: 100%

     - .. image:: media/image_window_IntensityBar_Popup_zero_color.png
          :width: 100%
          :align: right


.. _gui_guide_image_window_IntensityBar_Popup_automask:

.. list-table::
   :widths: 80 20
   :header-rows: 1

   * - :ref:`Automask?<gui_guide_image_window_IntensityBar_Popup_automask>`
     - 
   * - * ``Automask?`` is a toggle option to instantly mask the image similar 
         to `3dAutomask <https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/programs/alpha/3dAutomask_sphx.html#ahelp-3dautomask#>`_.
         The image on the right is the "masked" version of the left image.
         You can quickly toggle this on or off from that popup option and this
         does not change the image data on disk.  
       * Use this on EPI or previously skull stripped anatomical data sets.  
         This does not do "skull-stripping"! 
       * It is also useful in combination with the ``Choose Zero Color`` 
         option for images in papers.
       
         .. list-table::
            :width: 100%
            :align: center
            :header-rows: 0
 
            * - .. image:: media/image_window_IntensityBar_Popup_Automask_epi.png
                   :width: 100%
            
              - .. image:: media/image_window_IntensityBar_Popup_Automask_epi_masked.png
                   :width: 100%

     - .. image:: media/image_window_IntensityBar_Popup_Automask.png
          :width: 100%
          :align: right

.. _gui_guide_image_window_IntensityBar_Popup_invert:

.. list-table::
   :widths: 80 20
   :header-rows: 1

   * - :ref:`Invert?
       <gui_guide_image_window_IntensityBar_Popup_invert>`
     - 
   * - * ``invert``
       * 

     - .. image:: media/image_window_IntensityBar_Popup_Invert.png
          :width: 100%
          :align: right

.. _gui_guide_image_window_IntensityBar_Popup_flatten:

.. list-table::
   :widths: 65 35
   :header-rows: 1

   * - :ref:`Choose Flatten Range
       <gui_guide_image_window_IntensityBar_Popup_flatten>`
     - 
   * - * ``flatten``
       * 

     - .. image:: media/image_window_IntensityBar_Popup_flatten.png
          :width: 100%
          :align: right


.. _gui_guide_image_window_IntensityBar_Popup_sharpen:

.. list-table::
   :widths: 65 35
   :header-rows: 1

   * - :ref:`Choose Sharpen factor
       <gui_guide_image_window_IntensityBar_Popup_sharpen>`
     - 
   * - * ``sharpen``
       * 

     - .. image:: media/image_window_IntensityBar_Popup_sharpen.png
          :width: 100%
          :align: right


.. _gui_guide_image_window_IntensityBar_Popup_VG_factor:

.. list-table::
   :widths: 65 35
   :header-rows: 1

   * - :ref:`Choose VG factor
       <gui_guide_image_window_IntensityBar_Popup_VG_factor>`
     - 
   * - * ``VG_factor``
       * 

     - .. image:: media/image_window_IntensityBar_Popup_VG_factor.png
          :width: 100%
          :align: right


.. _gui_guide_image_window_IntensityBar_Popup_crop_autocenter:

.. list-table::
   :widths: 65 35
   :header-rows: 1

   * - :ref:`Crop Autocenter?
       <gui_guide_image_window_IntensityBar_Popup_crop_autocenter>`
     - 
   * - * ``crop_autocenter``
       * 

     - .. image:: media/image_window_IntensityBar_Popup_crop_autocenter.png
          :width: 100%
          :align: right
          
.. _gui_guide_image_window_IntensityBar_Popup_global_range:

.. list-table::
   :widths: 65 35
   :header-rows: 1

   * - :ref:`Image Global Range
       <gui_guide_image_window_IntensityBar_Popup_global_range>`
     - 
   * - * ``global_range``
       * 

     - .. image:: media/image_window_IntensityBar_Popup_global_range.png
          :width: 100%
          :align: right


.. _gui_guide_image_window_IntensityBar_Popup_plot_overlay:

.. list-table::
   :widths: 65 35
   :header-rows: 1

   * - :ref:`Plot Overlay Plots
       <gui_guide_image_window_IntensityBar_Popup_plot_overlay>`
     - 
   * - * ``plot_overlay``
       * 

     - .. image:: media/image_window_IntensityBar_Popup_plot_overlay.png
          :width: 100%
          :align: right


.. _gui_guide_image_window_IntensityBar_Popup_display_graymap:

.. list-table::
   :widths: 65 35
   :header-rows: 1

   * - :ref:`Display Graymap Plot
       <gui_guide_image_window_IntensityBar_Popup_display_graymap>`
     - 
   * - * ``display_graymap``
       * 

     - .. image:: media/image_window_IntensityBar_Popup_display_graymap.png
          :width: 100%
          :align: right


.. _gui_guide_image_window_IntensityBar_Popup_label:

.. list-table::
   :widths: 65 35
   :header-rows: 1

   * - :ref:`Label, Size, Label Append String
       <gui_guide_image_window_IntensityBar_Popup_label>`
     - 
   * - * ``Label``
       * ``Size``
       * ``Label Append String``

     - .. image:: media/image_window_IntensityBar_Popup_label.png
          :width: 100%
          :align: right


.. _gui_guide_image_window_IntensityBar_Popup_tick:

.. list-table::
   :widths: 65 35
   :header-rows: 1

   * - :ref:`Tick Div., Tick Size
       <gui_guide_image_window_IntensityBar_Popup_tick>`
     - 
   * - * ``Tick Div.``
       * ``Tick Size``

     - .. image:: media/image_window_IntensityBar_Popup_tick.png
          :width: 100%
          :align: right

.. _gui_guide_image_window_IntensityBar_Popup_CheckBrd:

.. list-table::
   :widths: 65 35
   :header-rows: 1

   * - :ref:`CheckBrd#<gui_guide_image_window_IntensityBar_Popup_CheckBrd>`
     - 
   * - * ``CheckBrd``
       * 

     - .. image:: media/image_window_IntensityBar_Popup_CheckBrd.png
          :width: 100%
          :align: right


.. _gui_guide_image_window_IntensityBar_Popup_Anim_Dup:

.. list-table::
   :widths: 65 35
   :header-rows: 1

   * - :ref:`Anim_Dup<gui_guide_image_window_IntensityBar_Popup_Anim_Dup>`
     - 
   * - * ``Anim_Dup``
       * 

     - .. image:: media/image_window_IntensityBar_Popup_Anim_Dup.png
          :width: 100%
          :align: right


Jump within GUI Guide
========================

.. include:: substep_gui_jump.rst
