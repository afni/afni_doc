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
         
       * Shift+button 2 will allow you to drag crop a region.
         
           * (The middle button on a 3 button mouse, or click down 
             on the scroll-wheel, or shift+option on macOS.)
         
       * Keyboard shortcuts are listed 
         `here <https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/educational/gui_readme_tips.html#keyboard-shortcuts-image-viewer-window>`_.
       * ``Clusterize`` shortcuts (these have a *cool* animation effect):
       
         * ``j`` = Jump to the nearest cluster's peak (or center of mass)
         * ``f`` = Flash current cluster if the crosshairs are inside one.
         * ``n`` or ``N`` = Jump to the next or previous cluster's peak or 
           center of mass.
           
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
       * **May need its own page to show some examples.**
       * ``InstaCorr Set``
       * ``InstaCorr SeedJump``
       * ``Jumpback`` lets you jump the focus position back to its last place.
         Useful for when you click in the wrong place and get lost.
       * ``Jump to (xyz)`` lets you enter *xyz*-coordinates (in mm), 
         and then the focus position will jump there. 
         (3 numbers ``,`` or space separated)
         
         * External programs ``3dclust`` and others can generate *xyz* 
           coordinates of interest.
         * Once you have ``+tlrc`` dataset, can jump to regions from 
           Talairach atlas.
         
         .. list-table::
             :width: 50%
             :align: center
             :header-rows: 0
 
             * - .. image:: media/image_window_HiddenImage_popup_jump_xyz.png
                   :width: 100%
         
       * ``Jump to (ijk UL)`` lets you jump to a particular voxel index 
         location in the underlay coordinate system. (Dialog box is similar to 
         ``Jump to (xyz)``)
       * ``Jump to (ijk OL)`` lets you jump to a particular voxel index 
         location in the overlay coordinate system. (Dialog box is similar to 
         ``Jump to (xyz)``)
        
       * ``Jump to (Cluster)``
       * ``-Go to atlas location``
       * ``-Where Am I?``
       * ``-Atlas Colors``
       * ``Image display`` lets you turn control widgets on and off to 
         unclutter screen a little; useful if you want to make a screenshot.
         But use the ``Sav1`` button instead of a screenshot. 
         :ref:`(see here)<gui_guide_image_window_Save1>`
       
         .. list-table::
             :width: 50%
             :align: center
             :header-rows: 0
 
             * - .. image:: media/image_window_HiddenImage_popup_Image_Display.png
                   :width: 100%
       
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
       * Left click and drag to move past many slices.
       * Left click ahead or behind to move 1 image at a time.
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
         :ref:`(see below)<gui_guide_image_window_IntensityBar_Popup>`.
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
   * - * ``Colr`` changes gray scale to color spectrum, and back (fun & useless).
       * ``Swap`` swaps top of intensity bar with bottom. (handy to see things 
         like the bounding box or abnormalities depending on the type of data). 
         This is similar to the ``Invert?`` button 
         :ref:`(see below)<gui_guide_image_window_IntensityBar_Popup_invert>`.
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
       * At bottom right, the arrow pad controls the crosshairs.
       
         * Arrows move 1 pixel in that direction for the **current window**.
         * Central button closes and opens crosshair gap (for fine control 
           of the crosshairs location)
         * For more crosshairs controls 
           :ref:`see here<gui_guide_controller_window_xhairs>`.

     - .. image:: media/image_window_RightButtons.png
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

       * Selecting ``Sav:aGif`` will save an animated .gif file scrolling 
         through the slices of the image.
       * Selecting this will change the saving dialog box adding a ``From:`` 
         and ``To:`` indicating the slices that you want.

         .. list-table::
             :width: 40%
             :align: center
             :header-rows: 0
  
             * - .. image:: media/image_window_Save1_aGif.png
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
   * - * ``Mont`` lets you display a rectangular layout of images 
         (i.e., montage).
       
         .. list-table::
             :width: 40%
             :align: center
             :header-rows: 0
  
             * - .. image:: media/image_window_mont_dialog.png
                    :width: 100%
       
       * ``Across`` and ``Down`` determine number of sub-images shown.
       * ``Spacing`` determines how far apart the selected slices are

         * Every nth slice, for n = 1, 2, ...
         * Multiple crosshairs in other image viewers will show montage slices.
       
       * ``Border`` lets you put some blank pixels between sub-images.
       * ``Color`` lets you choose the color of the border pixels.
       * At bottom row, the action buttons cause something to happen:
          
         * ``Quit`` closes the Montage control window.
         * ``1x1`` changes Across and Down back to 1.
         * ``Draw`` actually causes the montage to be drawn.
         * ``Set`` ⇔ ``Draw`` then ``Quit``
         
       * In this example, we have selected a 2 by 2 montage showing every other 
         slice with a 1 pixel yellow border.
         
         .. list-table::
            :width: 100%
            :align: center
            :header-rows: 0
 
            * - .. image:: media/image_window_mont_axl.png
                   :width: 100%
            
              - .. image:: media/image_window_mont_sag.png
                   :width: 100%
    
     - .. image:: media/image_window_mont.png
          :width: 100%
          :align: right
          
.. _gui_guide_image_window_Rec:

.. list-table::
   :widths: 55 45
   :header-rows: 1

   * - :ref:`Rec<gui_guide_image_window_Rec>`
     - 
   * - * ``Rec`` lets you record images for later saving.
       * So you can build a sequence of images using any set of AFNI controls.
         You can change color maps, functional thresholds, datasets, ...
         then save them to disk for animation, etc.
       * The ``Rec`` button button pops down a menu that sets the record mode.

         .. list-table::
             :width: 40%
             :align: center
             :header-rows: 0
  
             * - .. image:: media/image_window_Rec_dialog.png
                    :width: 100%
        
       * The top section controls **WHEN** images will be recorded into the 
         sequence.
         
         * ``Off`` ⇒ recording is off...
         * ``Next One`` ⇒ the next image displayed is recorded, then back 
           to ``Off``.
         * ``Stay On`` ⇒ record each image when displayed.
        
       * The bottom options control **WHERE** new images are to be stored into 
         the sequence.
        
         * ``After End`` = at the tail of the sequence.
         * ``Before Start`` = at head of sequence.
         * ``Insert --`` = insert before current sequence position.
         * ``Insert ++`` = insert after current sequence position.
         * ``OverWrite`` = replace current sequence position.
         * ``-- OverWrite`` = replace image before current position.
         * ``++ OverWrite`` = replace image after current position.
         
       * Recorded images go into a special new image viewer.
       
         .. list-table::
             :width: 80%
             :align: center
             :header-rows: 0
  
             * - .. image:: media/image_window_Rec_save_viewer.png
                    :width: 100%
       
       * The slider moves between recorded images.
       * ``Kill`` deletes 1 image from recorded sequence.
       * ``Save`` will save record images. (files with the same prefix will be 
         overwritten without warning.
       * Right click on ``Save`` to change the output image format. 
       
         * Your choice of formats is not saved after you close this special 
           viewer. So remember to change this each time you start.
         * ``aGif`` is a good choice.  If you leave it on ``.jpg`` you will 
           get a single jpeg file for each item in the sequence.
         * You may want to set ``Xhairs`` to ``Off`` on the AFNI control panel 
           before recording images.
           
       * ``Done`` closes the recorded image viewer. 
       
         * **Remember to click** ``Done`` **before you start doing anything 
           else as this will keep recording forever!**
       
       * Here is a simple example output:
       
         .. list-table::
             :width: 50%
             :align: center
             :header-rows: 0
  
             * - .. image:: media/image_window_Rec_example.gif
                    :width: 100%

       * If Unix programs ``whirlgif`` and/or ``gifsicle`` are installed on 
         your system, AFNI can write GIF animations directly 
         (e.g., for fun Web pages).
       * If program mpeg_encode is installed, AFNI can write MPEG-1 
         animations.
       * Source code for these free programs is included with AFNI source 
         code.

     - .. image:: media/image_window_Rec.png
          :width: 100%
          :align: right

Disp Options
============

.. _gui_guide_image_window_Disp:

``Disp`` controls the way images are displayed and saved.
It pops up its own control window and most controls change image immediately.

.. list-table:: 
   :header-rows: 0
   :width: 60%
   :align: center

   * - .. image:: media/image_window_Disp.png
          :width: 100%
          :align: center
     - .. image:: media/image_window_Disp_menu.png
          :width: 100%
          :align: center

.. _gui_guide_image_window_orient:

.. list-table::
   :widths: 80 20
   :header-rows: 1

   * - :ref:`Orientation<gui_guide_image_window_orient>`
     - 
   * - * Orientation controls at top allow you to flip image around in certain
         directions (clockwise and counter clockwise) and number of degrees.

         .. list-table::
             :width: 100%
             :align: center
             :header-rows: 1

             * - No Rotation
               - CCW 90
               - Rot 180
               - CW 90
             * - .. image:: media/image_window_Disp_menu_no_rot.png
                    :width: 100%
               - .. image:: media/image_window_Disp_menu_ccw_90.png
                    :width: 100%
               - .. image:: media/image_window_Disp_menu_rot_180.png
                    :width: 100%
               - .. image:: media/image_window_Disp_menu_cw_90.png
                    :width: 100%

       * ``+ LR Mirror`` flips the image left to right. For example, if the 
         image was displayed ``left=Anterior``, it will flip to 
         ``left=Posterior``.

         .. list-table::
             :width: 100%
             :align: center
             :header-rows: 1

             * - Not flipped (default).
               - Left Right flipped.
             * - .. image:: media/image_window_Disp_menu_LR_not_flipped.png
                    :width: 100%
               - .. image:: media/image_window_Disp_menu_LR_flipped.png
                    :width: 100%

     - .. image:: media/image_window_Disp_menu_orient.png
          :width: 100%
          :align: left

.. _gui_guide_image_window_intensity:

.. list-table::
   :widths: 80 20
   :header-rows: 1

   * - :ref:`Overlay and Intensity<gui_guide_image_window_intensity>`
     - 
   * - * ``No Overlay`` lets you turn color overlays off (crosshairs, 
         functional overlays, etc.)
       * ``Min-to-Max`` Intensity bar is data min-to-max.
       * ``2%-to-98%`` Intensity bar is smallest 2% of data to largest 98%. 
         This avoids having a few very bright voxels dominate intensity 
         scaling.  This is the default setting.
       * ``Clipped`` Intensities are mapped over an auto-clipped range of data 
         in all images (Axial, Sagittal, and Coronal).

         .. list-table::
             :width: 100%
             :align: center
             :header-rows: 1

             * - Min-to-Max
               - 2%-to-98%
               - Clipped
             * - .. image:: media/image_window_Disp_Min2Max.jpg
                    :width: 100%
               - .. image:: media/image_window_Disp_2to98.jpg
                    :width: 100%
               - .. image:: media/image_window_Disp_Clipped.jpg
                    :width: 100%

     - .. image:: media/image_window_Disp_menu_intensity.png
          :width: 100%
          :align: left

.. _gui_guide_image_window_aspect_save:

.. list-table::
   :widths: 80 20
   :header-rows: 1

   * - :ref:`Aspect and Save<gui_guide_image_window_aspect_save>`
     - 
   * - * ``Free Aspect`` lets you distort image shape freely. Otherwise, AFNI 
         tries to keep image shape *true* as you stretch/shrink window.  To 
         get the window back to normal, close and reopen it.

         .. list-table::
             :width: 100%
             :align: center
             :header-rows: 1

             * - Not sure why you would want to do this...
             * - .. image:: media/image_window_Disp_menu_aspect.png
                    :width: 100%

       * The save panel controls how images are saved to disk. For more 
         details, :ref:`(see here)<gui_guide_image_window_Save1>`

         * All buttons off: saved image file contains slice raw data.
           Saved in PNM format (portable bitmap format).  These may not open 
           in your default image viewer.
         * ``Nsize Save``: images are saved at a power of 2 in PNM format.
         * ``PNM Save``: images are saved in PNM format.
         * ``Save to .xxx(s)``: saves image(s) to specified format.
         * ``Save One``: Selected is default.  This will only save a snapshot of 
           the current display.  This is the ONLY way to save a montage.  If 
           it is not selected, the ``Save`` button asks for the first and 
           last image indexes (slices) to save.  Then it saves each 
           individual image (no montage) to an individual file.  By default, 
           it saves **ALL** slices with the file name format of PREFIX.xxxx.

           .. list-table::
               :width: 40%
               :align: center
               :header-rows: 0

               * - .. image:: media/image_window_Disp_menu_save_multi.png
                      :width: 100%

         * ``Save Anim GIF`` and ``Save Anim MPG`` will save an animated 
           "movie" file scrolling through the slices of the image.  
           
           * Files will 
             be saved in ``.gif`` or ``.mpg`` depending on the selection.
           * This takes precedence over ``Save One``.  
           * The top of the image window will display the progress of the 
             export.
           * This first exports a file per slice, then combines them into 
             the ``.gif`` or ``.mpg`` format.  If you have a lot of slices, 
             you will see the individual files in your current working 
             directory before they are combined.
           * GIF animations may require gifsicle to be installed.
           * MPEG-1 animations may require ffmpeg to be installed.
           * The ``.gif`` format takes up a lot more file space than ``.mpg`` 
             with the same number of slices.
           * The speed difference below is just from the display viewer.  Both 
             movies have the same slices.

           .. list-table::
               :width: 60%
               :align: center
               :header-rows: 1

               * - GIF format
                 - MPG format
               * - .. image:: media/image_window_Disp_menu_animated_gif.gif
                      :width: 100%
                 - .. image:: media/image_window_Disp_menu_animated_mpg.mpg
                      :width: 100%

     - .. image:: media/image_window_Disp_menu_aspect_save.png
          :width: 100%
          :align: left

.. _gui_guide_image_window_project:

.. list-table::
   :widths: 80 20
   :header-rows: 1

   * - :ref:`Project<gui_guide_image_window_project>`
     - 
   * - * ``Project`` applies a projection function to plus-or-minus 'Slab' 
         images from each pixel. 

         * ``Minimum`` = smallest value in the slab.
         * ``Maximum`` = largest value in the slab.
         * ``Mean`` = average value in the slab.
         * ``Median`` = median value in the slab.
         * ``OSfilt`` = Order Statistics filter.
         * ``Extreme`` = value farthest from the median.
         * ``MAD`` = Mean absolute deviation.
         * ``AdptMean`` = estimator of the mean.

       * ``Slab +-`` selects the number of slices around the current view to 
         use for the projection.  Useful for looking at blood vessels and 
         other different images.  For example, selecting 2 will project 5 
         slices (2 before, 2 after and the central slice).  Options range from 
         0 to 19.
       * Below are examples of the projection functions with slab size of 5.

         .. list-table::
             :width: 100%
             :align: center
             :header-rows: 1
             
             * - None
               - Minimum
               - Maximum
               - Mean
               - Median
             * - .. image:: media/image_window_Disp_menu_project_none.png
               - .. image:: media/image_window_Disp_menu_project_min.png
               - .. image:: media/image_window_Disp_menu_project_max.png
               - .. image:: media/image_window_Disp_menu_project_mean.png
               - .. image:: media/image_window_Disp_menu_project_median.png

         .. list-table::
             :width: 100%
             :align: center
             :header-rows: 1
             
             * - OSfilt
               - Extreme
               - MAD
               - AdptMean
               - 
             * - .. image:: media/image_window_Disp_menu_project_OSfilt.png
               - .. image:: media/image_window_Disp_menu_project_extreme.png
               - .. image:: media/image_window_Disp_menu_project_MAD.png
               - .. image:: media/image_window_Disp_menu_project_AdptMean.png
               - .. image:: media/image_window_Disp_menu_project_blank.png

     - .. image:: media/image_window_Disp_menu_project.png
          :width: 100%
          :align: left

.. _gui_guide_image_window_tran:

.. list-table::
   :widths: 80 20
   :header-rows: 1

   * - :ref:`Transforms<gui_guide_image_window_tran>`
     - 
   * - * ``Tran 0D`` lets you transform voxel values before display. ``Log10`` 
         and ``SSqrt`` are useful for images with extreme values.

         .. list-table::
            :width: 100%
            :align: center
            :header-rows: 1
            
            * - None
              - Log10
              - SSqrt
              - Abs
            * - .. image:: media/image_window_Disp_tran_none.png
              - .. image:: media/image_window_Disp_tran_0D_log10.png
              - .. image:: media/image_window_Disp_tran_0D_SSqrt.png
              - .. image:: media/image_window_Disp_tran_0D_ABS.png

       * ``Tran 2D`` provides some 2D image filters for the underlay only. 
         ``Median 9`` smoothing can be useful for printing images.

         .. list-table::
            :width: 100%
            :align: center
            :header-rows: 1
            
            * - Median9
              - Winsor9
              - OSfilt9
              - Median21
              - Winsor21
            * - .. image:: media/image_window_Disp_tran_2D_Median9.png
              - .. image:: media/image_window_Disp_tran_2D_Winsor9.png
              - .. image:: media/image_window_Disp_tran_2D_OSfilt9.png
              - .. image:: media/image_window_Disp_tran_2D_Median21.png
              - .. image:: media/image_window_Disp_tran_2D_Winsor21.png

         .. list-table::
            :width: 100%
            :align: center
            :header-rows: 1
            
            * - AdptMean21
              - abs[FFT2D]
              - arg[FFT2D]
              - Sharpness
              - 2dChain
            * - .. image:: media/image_window_Disp_tran_2D_AdptMean21.png
              - .. image:: media/image_window_Disp_tran_2D_absfft2d.png
              - .. image:: media/image_window_Disp_tran_2D_argfft2d.png
              - .. image:: media/image_window_Disp_tran_2D_sharpness.png
              - .. image:: media/image_window_Disp_tran_2D_2dchain.png

       * 0D and 2D transformations can be combined for further effects.

     - .. image:: media/image_window_Disp_menu_tran.png
          :width: 100%
          :align: left


.. _gui_guide_image_window_RowGraphs:

.. list-table::
   :widths: 80 20
   :header-rows: 1

   * - :ref:`Row Graphs<gui_guide_image_window_RowGraphs>`
     - 
   * - * ``RowGraphs`` are plots of the underlay (grayscale) image intensity 
         as x vs. y graphs. 
         
         .. list-table::
             :width: 90%
             :align: center
             :header-rows: 0
 
             * - .. image:: media/image_window_Disp_RowGraphs.png
                   :width: 100%
                   
       * Each graph is from one displayed horizontal row of 
         the image. 
       * The bottom row graph is from the image row under the crosshairs. 
       * Upper row graphs are from higher image rows. 
       * Image transformation functions and image rotation/flips will affect 
         the row graphs as well as the image display. 
       * The color marker indicates the crosshair focus point and can be 
         hidden with the ``No Overlay`` button.
       * If you want columns, flip the image with ``CCW 90``. 
         :ref:`(see here)<gui_guide_image_window_orient>`
       * The number of graphs ranges from 0 to 9.

     - .. image:: media/image_window_Disp_menu_RowGraphs.png
          :width: 100%
          :align: left

.. _gui_guide_image_window_surfgraph:

.. list-table::
   :widths: 80 20
   :header-rows: 1

   * - :ref:`Surf Graphs<gui_guide_image_window_surfgraph>`
     - 
   * - * ``Surfgraph`` lets you graph the voxel values in a surface graph.
       * These are a wire mesh plot of the underlay (grayscale) image 
         intensity vs x and y.  
       * Options ``No``, ``Yes``, and ``Inv``.
       * These plots can be saved from the viewer window.  However, they 
         look much better if you maximize the window and take a screen shot.
       * Use the arrows in the ``SurfGraph`` window to rotate the view point.
       * Use the middle button between the arrows to reset the viewpoint to 
         the default orientation.
       * The plotting routine may produce some erroneous vertical lines on 
         occasion.
       * The color "UK Flag" marker indicates the crosshair focus point.  It 
         is drawn on top of the surface at the end.  So it is always visible 
         even if it should be hidden behind the surface.  It shines through 
         no matter what.
       * The color marker can be turned off with the "No Overlay" button.

         .. list-table::
             :width: 100%
             :align: center
             :header-rows: 1

             * - Standard Surf Graph
             * - .. image:: media/image_window_Disp_SurfGraph.png
                    :width: 100%

         .. list-table::
             :width: 100%
             :align: center
             :header-rows: 1

             * - Inverse Surf Graph
             * - .. image:: media/image_window_Disp_SurfGraph_inv.png
                    :width: 100%

     - .. image:: media/image_window_Disp_menu_SurfGraph.png
          :width: 100%
          :align: left


.. _gui_guide_image_window_filters:

.. list-table::
   :widths: 80 20
   :header-rows: 1

   * - :ref:`Filters<gui_guide_image_window_filters>`
     - 
   * - * Extra imaging processing filters are provided at the bottom.  These 
         options have extra parameters adjustable in the intensity bar popup 
         window. :ref:`(see below)<gui_guide_image_window_IntensityBar_Popup>`
       
         * ``Flatten`` "Flattens" the histogram of the image similar effect as 
           adjusting the brightness and contrast manually.
         * ``Sharpen`` applies a sharpening filter to the background.  This is 
            sometimes useful for deblurring images.
         * ``Edge Detect`` applies a Sobel edge detection filter. 
           This is useful as the underlay for checking alignment.
         * ``VG paint`` applies a "painting" effect to the image just for fun.
         * You can use any combination of these filters and the 
           :ref:`transformations<gui_guide_image_window_tran>` 
           to create some interesting images.

         .. list-table::
            :width: 100%
            :align: center
            :header-rows: 1
            
            * - None
              - Flatten
              - Sharpen
            * - .. image:: media/image_window_Disp_filters_none.png
              - .. image:: media/image_window_Disp_filters_flatten.png
              - .. image:: media/image_window_Disp_filters_sharpen.png

         .. list-table::
            :width: 100%
            :align: center
            :header-rows: 1
            
            * - Edge Detect
              - VG Paint
              - Combo
            * - .. image:: media/image_window_Disp_filters_edge.png
              - .. image:: media/image_window_Disp_filters_paint.png
              - .. image:: media/image_window_Disp_filters_flat_sharp_paint.png

     - .. image:: media/image_window_Disp_menu_filters.png
          :width: 100%
          :align: left


Intensity Bar Hidden Popup
==========================

.. _gui_guide_image_window_IntensityBar_Popup:

.. list-table:: 
   :header-rows: 1
   :width: 40%
   :align: center

   * - :ref:`Vertical Intensity Bar Popup<gui_guide_image_window_IntensityBar_Popup>`
     - 
   * - AFNI GUI: Image Window Intensity Bar Popup
   * - .. image:: media/image_window_IntensityBar_Popup.png
          :width: 75%
          :align: center
   * - :ref:`Right click on the image window intensity bar.
       <gui_guide_image_window_IntensityBar>`

These options apply to the ``Underlay`` data set exclusively and are set 
per image window.  For example if you change an option in the sagittal image 
window, it will not apply to the axial or coronal image windows.  The changes 
only appear in the image window and do not change the data set on disk.

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
   * - * ``Invert?`` is a toggle option to compute a "negative" version of the 
         underlay data set. 
       * The image is first automasked then grey scale map is inverted.
       * The functionality is similar to what is described in the old message 
         board post 
         `here <https://afni.nimh.nih.gov/afni/community/board/read.php?1,59489,59500>`_.
       * This function is the same as the ``Swap`` button except that the 
         image is automasked and the background is not inverted. 
         :ref:`(see above)<gui_guide_image_window_RightButtons>`.
       * The program `fat_proc_imit2w_from_t1w 
         <https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/programs/alpha/fat_proc_imit2w_from_t1w_sphx.html#ahelp-fat-proc-imit2w-from-t1w>`_ 
         does something similar but saves an output data set.
       * This is sometimes useful with FLAIR data to highlight abnormalities 
         like stroke lesions or tumors.
       * The image on the right is the "inverted" version of the left image.

         .. list-table::
            :width: 100%
            :align: center
            :header-rows: 0
 
            * - .. image:: media/image_window_IntensityBar_Popup_Invert_epi.png
                   :width: 100%
            
              - .. image:: media/image_window_IntensityBar_Popup_Invert_epi_inverted.png
                   :width: 100%

     - .. image:: media/image_window_IntensityBar_Popup_Invert.png
          :width: 100%
          :align: right

.. _gui_guide_image_window_IntensityBar_Popup_flatten:

.. list-table::
   :widths: 80 20
   :header-rows: 1

   * - :ref:`Choose Flatten Range
       <gui_guide_image_window_IntensityBar_Popup_flatten>`
     - 
   * - * ``Choose Flatten Range``
       * 

     - .. image:: media/image_window_IntensityBar_Popup_flatten.png
          :width: 100%
          :align: right

.. _gui_guide_image_window_IntensityBar_Popup_sharpen:

.. list-table::
   :widths: 80 20
   :header-rows: 1

   * - :ref:`Choose Sharpen factor
       <gui_guide_image_window_IntensityBar_Popup_sharpen>`
     - 
   * - * ``Choose Sharpen factor``
       * 

     - .. image:: media/image_window_IntensityBar_Popup_sharpen.png
          :width: 100%
          :align: right


.. _gui_guide_image_window_IntensityBar_Popup_VG_factor:

.. list-table::
   :widths: 80 20
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
   :widths: 80 20
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
   :widths: 80 20
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
   :widths: 80 20
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
   :widths: 80 20
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
   :widths: 80 20
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
   :widths: 80 20
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
   :widths: 80 20
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
   :widths: 80 20
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
