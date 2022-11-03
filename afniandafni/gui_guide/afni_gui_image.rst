.. _edu_afni03_image:


**************************
**AFNI GUI: Image window**
**************************

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
         
     - .. image:: media/image_window.png
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
          
.. _gui_guide_image_window_HiddenImage_popup:

.. list-table::
   :widths: 55 45
   :header-rows: 1

   * - :ref:`Hidden Image Popup Menu<gui_guide_image_window_HiddenImage_popup>`
     - 
   * - * Hidden image popup menu using Button 3 or right-click over the actual
         image.
       * ``InstaCorr Set``
       * ``InstaCorr SeedJump``
       * ``Jumpback``
       * ``Jump to (xyz)``
       * ``Jump to (ijk UL)``
       * ``Jump to (ijk OL)``
       * ``Jump to (Cluster)``
       * ``-Go to atlas location``
       * ``-Where Am I?``
       * ``-Atlas Colors``
       * ``Image display``
       * ``Edit Environment``
       * ``Draw ROI plugin``
       * ``bg =x`` (x is some number)

     - .. image:: media/image_window_HiddenImage_popup.png
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
       * Leftclick and drag to move past many slices.
       * Leftclick ahead or behind to move 1 image at a time.
       * Hold button click down to scroll continuously through slices. 
       * Middle click (option+left click on macOS if you set it up in XQuartz) 
         in 'trough' to jump quickly to a given location.
       * Mouse scroll-wheel action when cursor is over image also changes 
         slices.
       * ctrl+click will jump to the start of end of the slices, depending on 
         which side of slider you click.
       
     - .. image:: media/image_window_slider.png
          :width: 100%
          :align: right

.. _gui_guide_image_window_IntensityBar:

.. list-table::
   :widths: 55 45
   :header-rows: 1

   * - :ref:`Vertical Intensity Bar<gui_guide_image_window_IntensityBar>`
     - 
   * - * Vertical intensity bar to right of image shows mapping from numbers 
         stored in image to colors shown on screen.
       * Bottom of intensity bar corresponds to smallest numbers displayed.
       * Top corresponds to largest numbers displayed 
         (popup hint shows numerical range)
       * Smallest-to-largest display range is selected from the ``Disp``
         control panel. :ref:`(see here)<gui_guide_image_window_Disp>`, or 
         from the right click hidden popup menu 
         :ref:`(see here)<edu_afni03_image_window_intensity_popup>`.
       * Scroll-wheel in the intensity bar changes contrast.
       * ALT (``⌘`` on macOS) plus scroll-wheel in intensity bar changes 
         brightness.
       * All image viewers from all AFNI controllers use the same intensity bar.

         * When you change intensity scale in one viewer, all others viewers 
           change.
         * Unless AFNI is started with the ``-uniq`` command line option, 
           in which case each AFNI **controller's** viewers have independent 
           intensity bars. But all image viewers from same controller always 
           share same intensity bar.

     - .. image:: media/image_window_IntensityBar.png
          :width: 100%
          :align: right

.. _gui_guide_image_window_RightButtons:

.. list-table::
   :widths: 55 45
   :header-rows: 1

   * - :ref:`Colr, Swap, Norm, .etc<gui_guide_image_window_RightButtons>`
     - 
   * - * ``Colr`` changes grayscale to color spectrum, and back (fun & useless).
       * ``Swap`` swaps top of intensity bar with bottom.
       * ``Norm`` returns the intensity bar to normal (after you mess it up).
       * ``c`` controls contrast. ``b`` controls brightness.

         * Useful combination ``c`` ↑ 2-3 times, ``b`` ↓ 2-3 times.

       * ``r`` rotates the intensity bar (also fun & useless).
       * ``g`` changes the gamma factor (nonlinearity) for the intensity bar.
       * ``i`` changes the size of the image in the window.
       * ``9`` changes the opacity of the color overlay. 
         (This control only present for X11 TrueColor displays 
         **does this matter anymore?**)
       * ``z`` zooms out and in.
       * ``pan`` lets you pan around when zoomed in. (greyed out if not zoomed)
       * ``crop`` lets you crop the image viewing area.
       * ``Card`` or ``Obliq`` (not a button) tells you if the dataset axes 
          are parallel to LR-AP-IS or not parallel. 
       * At bottom right, the arrowpad controls the crosshairs.
       
         * Arrows move 1 pixel in that direction for the **current window**.
         * Central button closes and opens crosshair gap (for fine control 
           of the crosshairs location)
         * For more crosshairs controls 
           :ref:`see here<gui_guide_controller_window_xhairs>`.

     - .. image:: media/image_window_RightButtons.png
          :width: 100%
          :align: right

.. _gui_guide_image_window_Disp:

.. list-table::
   :widths: 30 25 45
   :header-rows: 1

   * - :ref:`Disp<gui_guide_image_window_Disp>`
     - 
     -
   * - * ``Disp``
       * 

     - .. image:: media/image_window_Disp_menu.png
          :width: 100%
          :align: right

     - .. image:: media/image_window_Disp.png
          :width: 100%
          :align: right
          
.. _gui_guide_image_window_Save1:

.. list-table::
   :widths: 55 45
   :header-rows: 1

   * - :ref:`Sav1.jpg<gui_guide_image_window_Save1>`
     - 
   * - * ``Sav1.jpg`` lets you save images from viewer to disk files.
       * Image files are saved in your current working directory.
       * The saved image is on the matrix of the dataset. It is NOT a screen 
         capture; that is, the image saved will not depend on the size of the 
         image viewer window or the resolution of the screen.
       * The crosshairs will be captured with the image unless you turn it off. 
         :ref:`(see here on how to do that)<gui_guide_controller_window_xhairs>`
       * The ``Prefix`` is the name of the image file you want to save *without
         the extension*.  afni will append the extension of your chosen format.
       * If you use the same prefix more than once, afni will overwrite the 
         image saved to disk without warning.
       * ``Blowup`` causes an explosion in your computer, destroying all work!
       * *just checking to see if anyone reads this...*
       * Actually ``Blowup`` artificially increases the size/resolution of the 
         output image by a factor of your choosing from 1 to 8. This is useful 
         for outputting pretty images for all of the papers you are going to 
         publish **(while also citing AFNI)** `See here on how to cite AFNI.
         <https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/published/citations.html#afni-software-package>`_
   
         .. list-table::
             :width: 40%
             :align: center
             :header-rows: 0
 
             * - .. image:: media/image_window_Save1_dialog.png
                    :width: 100%

       * The ``.jpg`` will change with your choice of output format. (for 
         example it might be ``Sav1.bmp`` for a bitmap image)
       * To change the format, right click the ``Sav1.jpg`` button to get 
         this popup:

         .. list-table::
             :width: 40%
             :align: center
             :header-rows: 0
 
             * - .. image:: media/image_window_Save1_format.png
                    :width: 100%

       * **Warning**: Images are saved as sent to the viewer, not as displayed.
       
         * Means that aspect ratio of saved image may be wrong. (non-square 
           pixels)
         * This can be fixed with ``Define Datamode`` ⇒ ``Warp Anat on Demand``
           :ref:`(see here)<edu_afni03_datamode>`.
         * Or by setting ``AFNI_IMAGE_SAVESQUARE`` to ``YES``
           `(see here)
           <https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/educational/readme_env_vars.html>`_.

     - .. image:: media/image_window_Save1.png
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
   :widths: 55 45
   :header-rows: 1

   * - :ref:`Rec<gui_guide_image_window_Rec>`
     - 
   * - * ``Rec``
       * 

     - .. image:: media/afni_image_window_Rec.png
          :width: 100%
          :align: right



Jump within GUI Guide
========================

.. include:: substep_gui_jump.rst
