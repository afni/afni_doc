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

.. _gui_guide_image_window_basics:

.. list-table::
   :widths: 60 40
   :header-rows: 1

   * - :ref:`Basics<gui_guide_image_window_basics>`
     - 
   * - * Click and release mouse button 1 (left button) to move the crosshairs 
         to the location of the cursor.
       * Click down Button 1 (left button) in the image window and hold it 
         down, then drag around while holding. This changes contrast and 
         brightness.
         
         * You must move cursor a small distance while doing click-and-hold 
           before the contrast/brightness change starts.
           
       * Scroll-wheel in the image window moves through slices.
       * Keyboard ALT (``⌘`` on macOS) while using the scroll-wheel in the 
         image window will change the functional overlay threshold slider in 
         the main AFNI GUI window.

         * This action affects all image viewers in the current AFNI controller.
         
     - .. image:: media/afni_image_window.png
          :width: 100%
          :align: right


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

.. _gui_guide_image_window_IntensityBar:

.. list-table::
   :widths: 60 40
   :header-rows: 1

   * - :ref:`Vertical Intensity Bar<gui_guide_image_window_IntensityBar>`
     - 
   * - * Vertical intensity bar to right of image shows mapping from numbers 
         stored in image to colors shown on screen.
       * Scroll-wheel in the intensity bar changes contrast.
       * ALT (``⌘`` on macOS) plus scroll-wheel in intensity bar changes 
         brightness.

     - .. image:: media/afni_image_window_IntensityBar.png
          :width: 100%
          :align: right
          
.. _gui_guide_image_window_RightButtons:

.. list-table::
   :widths: 60 40
   :header-rows: 1

   * - :ref:`Colr, Swap, Norm , .etc<gui_guide_image_window_RightButtons>`
     - 
   * - * ``Buttons``
       * 

     - .. image:: media/afni_image_window_RightButtons.png
          :width: 100%
          :align: right

.. _gui_guide_image_window_Disp:

.. list-table::
   :widths: 60 40
   :header-rows: 1

   * - :ref:`Disp<gui_guide_image_window_Disp>`
     - 
   * - * ``Disp``
       * 

     - .. image:: media/afni_image_window_Disp.png
          :width: 100%
          :align: right
          
.. _gui_guide_image_window_Save1:

.. list-table::
   :widths: 60 40
   :header-rows: 1

   * - :ref:`Save1.jpg<gui_guide_image_window_Save1>`
     - 
   * - * ``Save1.jpg``
       * 

     - .. image:: media/afni_image_window_Save1.png
          :width: 100%
          :align: right

.. _gui_guide_image_window_montage:

.. list-table::
   :widths: 55 45
   :header-rows: 1
   
   * - :ref:`Montage<gui_guide_image_window_montage>`
     - 
   * - * ``Mont``
       
     - .. image:: media/image_window_mont_xhairs.png
          :width: 100%
          :align: right

.. _gui_guide_image_window_Rec:

.. list-table::
   :widths: 60 40
   :header-rows: 1

   * - :ref:`Rec<gui_guide_image_window_Rec>`
     - 
   * - * ``Rec``
       * 

     - .. image:: media/afni_image_window_Rec.png
          :width: 100%
          :align: right

.. _gui_guide_image_window_HiddenImage:

.. list-table::
   :widths: 60 40
   :header-rows: 1

   * - :ref:`Hidden Image Popup Menu<gui_guide_image_window_HiddenImage>`
     - 
   * - * Hidden image popup menu (using Button 3 or right-click)
       * 

     - .. image:: media/afni_image_window_HiddenImage.png
          :width: 100%
          :align: right

.. _gui_guide_image_window_HiddenIntensity:

.. list-table::
   :widths: 60 40
   :header-rows: 1

   * - :ref:`Hidden Intensity Bar Popup Menu<gui_guide_image_window_HiddenIntensity>`
     - 
   * - * Hidden Intensity Bar Popup Menu
       * 

     - .. image:: media/afni_image_window_HiddenIntesity.png
          :width: 100%
          :align: right



Jump within GUI Guide
========================

.. include:: substep_gui_jump.rst
