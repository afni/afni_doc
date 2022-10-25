.. _edu_afni03_image:


******************************************
**AFNI GUI: Image window**
******************************************

.. contents:: :local:

.. list-table:: 
   :header-rows: 1
   :width: 40%
   :align: center

   * - AFNI GUI: Image Window
   * - .. image:: media/image_window.png
          :width: 100%
          :align: center
   * - :ref:`Load a dataset and open an image viewer.<gui_guide_main_load_dsets>`

Image Window
============

.. _gui_guide_image_window_xhairs:

.. list-table::
   :widths: 55 45
   :header-rows: 1
   
   * - :ref:`Crosshairs<gui_guide_image_window_xhairs>`
     - 
   * - * Crosshairs in image window show current focus location (xyz in AFNI 
         controller) 
       * Also show the cut planes for the other image viewers (in this case 
         the sagittal and coronal viewers)
       * Can control crosshair color and gap size from main AFNI controller.
         :ref:`(see here).<gui_guide_controller_window_xhairs>`
       * When using image montage, other viewers show multiple crosshairs.
         :ref:`(see here).<gui_guide_image_window_montage>`
       
     - .. image:: media/image_window_xhairs.png
          :width: 100%
          :align: right
          
          
.. _gui_guide_image_window_slider:

.. list-table::
   :widths: 55 45
   :header-rows: 1
   
   * - :ref:`Slider<gui_guide_image_window_slider>`
     - 
   * - * The slider below image lets you move between slices.
       * The number above the slider indicates the current displayed slice. 
         (in this case 144)
       * Left-click and drag to move past many slices.
       * Left-click ahead or behind to move 1 image at a time.
       * Hold button click down to scroll continuously through slices. 
       * Middle-click in 'trough' to jump quickly to a given location.
       * Mouse scroll-wheel action when cursor is over image also changes 
         slices
       
     - .. image:: media/image_window_slider.png
          :width: 100%
          :align: right
          
.. _gui_guide_image_window_montage:

.. list-table::
   :widths: 55 45
   :header-rows: 1
   
   * - :ref:`Montage<gui_guide_image_window_montage>`
     - 
   * - * something
       
     - .. image:: media/image_window_mont_xhairs.png
          :width: 100%
          :align: right

Jump within GUI Guide
========================

.. include:: substep_gui_jump.rst
