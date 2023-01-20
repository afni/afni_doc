.. _edu_afni03_overlay:


*************************************
**AFNI GUI: Overlay panel**
*************************************

.. contents:: :local:


.. _Define Overlay:
          
Define Overlay
==============

.. list-table::
   :widths: 30 70
   :header-rows: 0
   
   * - * Click the ``Define OverLay ->`` button to open the overlay
         panel. This will control the thresholds, colors, etc. for overlays.
       * You usually want to have the ``See OverLay`` button checked.
       * When you choose an overlay dataset, this panel *should* automatically 
         open, check the ``See OverLay`` button, and select some reasonable 
         sub-bricks for the ``OLay`` and ``Thr``.
       * For this guide we will load a stats dataset from the output of 
         ``afni_proc.py``.
       
     - .. image:: media/overlay_full_start.png
          :width: 100%
          :align: right

.. _gui_guide_overlay_ulay_olay_thr:

.. list-table::
   :widths: 60 40
   :header-rows: 1

   * - :ref:`Select sub-bricks<gui_guide_overlay_ulay_olay_thr>`
     - 
   * - * ``ULay`` or ``OLay`` will let you choose which sub-brick of the 
         underlay or overlay datasets to display. 
       * It is usually good to start here before adjusting any other options.
       * The sub-brick labels are assigned when the dataset is created. The 
         index values show the numerical location of the sub-brick in the 
         dataset (starting at 0 of course).
         **typo in the button help for ``ULay``**
       * The ``Thr`` allows you to choose the sub-brick of the overlay 
         dataset with which to threshold the ``Olay`` sub-brick.
       * In this example the "Coef" is the overlay and is thresholded by the 
         "Tstat".
         
     - .. image:: media/overlay_main_ulay_olay_thr.png
          :width: 100%
          :align: right

.. _gui_guide_overlay_ranges:

.. list-table::
   :widths: 60 40
   :header-rows: 1

   * - :ref:`Ranges<gui_guide_overlay_ranges>`
     - 
   * - * ``ULay``, ``OLay``, and ``Thr`` show the range of values for each of 
         those sub-bricks.  These are the range of the raw values in each of 
         the 3D datasets. The overlay values may be useful for choosing the 
         range for the pbar. 
         
         * If a dataset is warped from a 'parent', these statistics are taken 
           from the parent dataset.
           
       * ``autoRange`` determines whether the program or the user sets the 
         ``OLay`` value that maps to the color pbar level 1.0. 
         
         * Selected: uses the ``autoRange`` value for pbar 1.0. (default)
         * Not selected: allows the user to control the ``Range`` value with 
           the value box below. 
           
       * ``%`` determines whether the slider sets the threshold based on 
         percentile, rather than value. At 0.75, you threshold away the 
         bottom 75% of the voxels that would be displayed with no thresholding 
         at all. At 0.5, you see the top half. The slider power is ignored in 
         percentile mode, so 0.5 is the same as 5, 50, etc. Zero voxels are not 
         considered if ``Pos?`` is set (under the color bar). Otherwise, the 
         cumulative distribution  percentages come from the absolute value 
         of the voxel values.
       * The value box below ``autoRange`` is greyed out if ``autoRange`` is 
         enabled. Otherwise you can use the arrows to change the value or 
         just type in a number that will map to pbar level 1.0. (negative 
         numbers auto correct to 0).
       * The arrows for ``Rota`` will rotate the colors on the 'pbar' up or 
         down. (Press with ``Shift`` to rotate in steps of 4)
       * ``F`` will flip the color bar Top-to-Bottom. This works for the 
         continuous color scale and discretely panned color bars.

     - .. image:: media/overlay_main_ranges.png
          :width: 100%
          :align: right


.. _gui_guide_overlay_color_bar:

.. list-table::
   :widths: 60 40
   :header-rows: 1

   * - :ref:`Color Bar<gui_guide_overlay_color_bar>`
     - 
   * - * The color bar represents the color that maps to the overlay data.
       * The number in the top and bottom right (in this case 4.168 and -4.168. 
         The bottom number is out of view because of XQuartz) 
         corresponds to the range selected (in this case ``autoRange`` 
         is selected). If you were to de-select ``autoRange`` and enter a 
         number, that number would be represented here. 
       * Left clicking in the color bar will flip the colors top to bottom.
       * There is a hidden menu if you right click in the color bar. The 
         ``value`` displayed is the value at the vertical location at which 
         you right clicked. The ``RGB`` is the numerical representation of the 
         color at that point from 0 to 255 for red, green, and blue (helpful 
         if you want to color match in a figure).

         .. list-table::
             :width: 40%
             :align: center
             :header-rows: 0
 
             * - .. image:: media/overlay_main_color_bar_hidden.png
                   :width: 100%

       .. list-table::
          :widths: 60 40
          :align: center
          :header-rows: 0
          
          * - * Clicking ``Choose Colorscale`` will open a popup menu with 
                lots of choices of different color bars. I believe that 
                ``Reds_and_Blues_Inv`` is the default, but play with the 
                different choices to see what you like. There are discrete 
                integer scales that are good for atlases or region of 
                interest maps.

            - .. image:: media/overlay_main_color_bar_Choose_Colorscale.png
                 :width: 100%

       * The ``#`` drop down menu lets you subdivide the color bar into panes 
         by the selected number. The default ``**`` is a continuous color bar.
       * ``Pos?`` is de-selected by default to show positive and negative 
         values. If you select ``Pos?`` only positive overlay values will be 
         shown. The range of the color bar will start at 0, so the color 
         mapping will change accordingly. Zero overlay values are never 
         overlaid.

     - .. image:: media/overlay_main_color_bar.png
          :width: 100%
          :align: right

.. _gui_guide_overlay_thr_slider:

.. list-table::
   :widths: 60 40
   :header-rows: 1

   * - :ref:`Threshold Slider<gui_guide_overlay_thr_slider>`
     - 
   * - * Drag the slider bar to adjust the threshold for the overlay display. 
         You can left click above or below the slider to jump up or down by 
         the 3rd digit value (just try it).
   
         * Threshold doesn't apply if the dataset is RGB-format. (I have 
           never seen one of these datasets...)
         * Threshold applies to the ``Thr`` sub-brick.
         
       * The value shown to the left of the slider is between 0 and 1 
         (modified by a power of 10 as explained below).

     - .. image:: media/overlay_main_thr_slider.png
          :width: 100%
          :align: right

.. _gui_guide_overlay_p_q_10:

.. list-table::
   :widths: 60 40
   :header-rows: 1

   * - :ref:`p value etc^<gui_guide_overlay_p_q_10>`
     - 
   * - * The ``p=`` displays the estimated significance (p-value) of the 
         threshold slider if possible. This is the 'uncorrected' or per-voxel 
         value of 'p'. (This will display '[NA]' if not possible)
       * p values displayed as ``1.2-7`` are shorthand for ``1.2 x 10^(-7)``.
       * ``q=``: if FDR curves are pre-computed in the dataset header, then 
         the False Discovery Rate q value will also be shown. FDR q is the 
         estimate of above-threshold voxels that are false detections 
         ('false positives').
         
         * You can add FDR curves to a dataset with ``3drefit -addFDR`` or by 
           using the ``Add FDR Curves`` button in the hidden popup menu under 
           the label atop the threshold slider (shown below).

       * The ``10^`` drop down sets the power-of-10 range of the threshold 
         slider. If it is set to 1 (default in most cases), the slider range 
         will be ~0.0 to ~10.0. If it is set to 0, the range is ~0.0 to ~1.0,
         etc. The color bar is mapped to the slider range by the ``autoRange`` 
         or manually chosen range. 
       * If you hover over the ``p=`` or ``q=``, you will get a popup hint 
         that displays some stats.

         .. list-table::
             :width: 100%
             :align: center
             :header-rows: 0
 
             * - .. image:: media/overlay_main_p_q_10_pval_hover.png
                   :width: 100%

         * The ``Uncorrected p=`` is the same value displayed in the gui but 
           with more digits.
         * The ``alpha(p)=`` is the approximate likelihood that the p value 
           shown results from the null hypothesis, not the alternative.
         * ``FDR q=`` is the same as the gui but with more digits.
         * ``MDF=`` is a **CRUDE** estimate of the true positive voxels that 
           are below the current threshold ('false negatives').

       * If you put the cursor over the p or q area and use the scroll wheel 
         (or 2 finger swipe on the track pad) to scroll down, you will get a 
         popup dialog to let you enter the p value you want directly. If you 
         scroll up, you will get a dialog to set the q value. 

         .. list-table::
             :width: 70%
             :align: center
             :header-rows: 0
 
             * - .. image:: media/overlay_main_p_q_10_scroll_down.png
                   :width: 100%
               - .. image:: media/overlay_main_p_q_10_scroll_up.png
                   :width: 100%

       * There is a hidden menu that appears if you right click and hold in the 
         p or q area. This menu also appears if you right click and hold on the 
         ``Thr`` label atop the threshold slider.


       .. list-table::
          :widths: 70 30
          :align: center
          :header-rows: 0

          * - * ``Use Threshold?`` is selected by default. If you deselect it, the 
                threshold slider will do nothing and you will get **NO** 
                thresholding at all.
              * ``Thr = OLay ?`` sets the ``Thr`` sub-brick to be the same as the 
                ``OLay`` sub-brick. This is useful for looking at full F-stats or 
                anova's etc.
              * ``Thr = Olay+1 ?`` (**note to staff: capitalization is wrong here**) 
                sets the ``Thr`` sub-brick to be the next sub-brick after the 
                ``OLay`` that is selected. This is useful for t-tests or anything 
                with a coefficient and a T-stat.
              * ``AutoThreshold`` uses some sort of magic incantation spun by Bob 
                the Wise to select a threshold based on the alignment of the stars 
                and the user's birthday. **note to staff: fix this!!**
              * ``Set threshold`` pops up a dialog allowing you to enter a 
                number directly. It will modify the ``10^`` selection to match the 
                number you enter. If you enter a negative number, the threshold 
                slider will flash and there will be an annoying beep tone.
              * ``Set p-value`` and ``Set q-value`` will give you the same dialog 
                boxes as shown above with the scrolling actions.
              * ``Set p=0.001`` does what it says... Just quicker than messing with 
                the slider.
              * 
            - .. image:: media/overlay_main_p_q_10_right_click.png
                 :width: 100%


     - .. image:: media/overlay_main_p_q_10.png
          :width: 100%
          :align: right



Jump within GUI Guide
========================

.. include:: substep_gui_jump.rst
