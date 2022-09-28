.. _edu_afni03_graph:


******************************************
**AFNI GUI: Graph window**
******************************************

.. contents:: :local:


Open Some Graph Windows
=======================

.. list-table::
   :widths: 50 50
   :header-rows: 0
   
   * - * ``Graph`` buttons for the adjacent views (Axial, Sagittal,
         Coronal)

         * Normal: button opens a viewing window
         * Inverted: button raises opened window
         * Right-click on an inverted button 'fetches' the graph
           window
       
       * ``Graph`` buttons are *usually* only meaningfull if the
         selected underlay dataset has a time index (*usually* some
         functional image)
              
       * ``Graph`` buttons are only enabled for datasets that are
         viewing their data files directly

         * Not warping on demand -- see the top of the ``Define
           Datamode`` control panel :ref:`(see here)<Define Datamode>`
           
     - .. image:: media/graph_window_open.png
          :width: 100%
          :align: right
          

Graph Window
============

.. list-table::
   :widths: 50 50
   :header-rows: 0
   
   * - * Graph viewer takes voxel values from same dataset as image
         viewer
   
         * If dataset has only 1 sub-brick, graph viewer only shows
           numbers (Not very useful unless you are an MRI physics
           type, perhaps)
 
       * To look at images from one dataset locked to graphs from
         another dataset, must use 2 AFNI controllers and ``Define
         Datamode`` ⇒ ``Lock`` on AFNI control panel
      
     - .. image:: media/graph_window.png
          :width: 100%
          :align: right
          
          
.. list-table::
   :widths: 50 50
   :header-rows: 0
   
   * - * If graph and image viewer in same slice orientation are both open, 
         crosshairs in image window change to show a box containing dataset 
         voxels being graphed
         
     - .. image:: media/graph_window_xhair_box.png
          :width: 100%
          :align: right
          
          
.. list-table::
   :widths: 50 50
   :header-rows: 0

   * - * Central sub-graph (current focus location) is outlined in
         *yellow*
         
       * Current time index is marked with small red diamond on data
         graph
       * Left-clicking in a non-central sub-graph moves that
         location to focus. Making it the *yellow* center sub-graph
         and moving the crosshairs on the image window to match the
         new location.
       * Left-clicking in central sub-graph moves time index to
         nearest point
       
         * Can also use ``Index`` control in AFNI controller to
           change time
         
       * Right-clicking in any sub-graph pops up some statistics of
         its data
         
     - .. image:: media/graph_window_stats.png
          :width: 100%
          :align: right
          
.. list-table::
   :widths: 50 50
   :header-rows: 0

   * - * Left-clicking the icon in the lower left corner causes icon and menu 
         buttons to disappear.
       * Useful if you want to do a screenshot to save AFNI window(s)
       * Left-clicking in same place will bring icon and buttons back
       
     - .. image:: media/graph_window_clear.png
          :width: 100%
          :align: right

Opt Menu
========

.. list-table::
   :widths: 50 50
   :header-rows: 0
   
   * - * ``Opt`` menu buttons let you control how graphs appear
       * Many items have keyboard shortcuts
       * Make sure you are typing into the correct window!
       * (XQuartz on Mac makes it difficult to see...)
         
     - .. image:: media/graph_window_opt_open2.png
          :width: 100%
          :align: right

.. list-table::
   :widths: 50 50
   :header-rows: 0
   
   * - * ``Index Pin/Stride`` changes which data points are displayed in 
         the graph. Useful when switching between datasets of different lengths.
       * The defaults (0, 0, 1) show all data points in the dataset.
       * ``Bot...`` sets which data point is the first (on the left)
       * ``Top...`` sets which data point is the last (on the right)
         
         * The number displayed will be your choosen number - 1
          
       * ``Stride`` sets the interval of data points displayed.
       
         * This number will auto correct to fit your other choices.
         
       * For example, if the data has 151 time points, setting ``Bot...`` = 
         10, ``Top...`` = 100, ``Stride`` = 9 will get you a graph that shows
         every 9th data point from the 10th to the 99th.
       * .. image:: media/graph_window_opt_index_pin_zoom.png
            :width: 100%
            
     - .. image:: media/graph_window_opt_index_pin.png
          :width: 100%
          :align: right
          
.. list-table::
   :widths: 50 50
   :header-rows: 0
   
   * - * ``Scale`` changes scale of graphs. 
          Mapping from voxel values to screen pixels.
       * ``Down [-]`` and ``Up [+]`` shrinks or expands the graphs vertically.
       * ``Choose`` lets you pick exact scale factor.
       
         * .. image:: media/graph_window_opt_scale_choose.png
              :width: 45%
         * Positive (pix/datum) = number of *y* screen pixels for each change of 
           1 in data.
         * Negative (datum/pix) = size of change in data to get 1 *y*
           screen pixel.
           
       * ``Auto [a]`` makes AFNI pick a nice scale factor (this one time)
       * ``AUTO [A]`` autoscale the graphs (every time they are redrawn)
       * Scale factor does not change when you resize graph,change matrix, etc.
         You usually have to auto-scale ``a`` of ``[A]`` afterwards.
       * Current scale factor is shown below graphs:
       * .. image:: media/graph_window_opt_scale_zoom.png
            :width: 100%
       
     - .. image:: media/graph_window_opt_scale.png
          :width: 100%
          :align: right

.. list-table::
   :widths: 50 50
   :header-rows: 0
   
   * - * ``Matrix`` changes number of sub-graphs across each row and column.
       * ``Down [m]`` and ``Up [M]`` decrease and increase number.
       * ``#`` lets you pick number exactly with allowable matrix sizes 
         between 1 and 21 
      
     - .. image:: media/graph_window_opt_matrix.png
          :width: 100%
          :align: right

.. list-table::
   :widths: 50 50
   :header-rows: 0
   
   * - * ``Grid`` lets you change spacing of vertical grid lines 
         (yellow in color by default).
       * Useful for showing regular timing interval (e.g., block timings)
       * ``Down [g]`` and ``Up [G]`` decrease and increase the spacing.
       * ``AutoGrid`` lets AFNI choose something reasonable (default)
       * ``Choose`` lets you pick the number exactly.
       
         * .. image:: media/graph_window_opt_grid_choose.png
              :width: 45%
       
       * ``HorZ [h]`` will put in a dashed line at the *y* = 0 
         level in sub-graphs.
         
         * Only useful if data range spans negative and positive values!
     
       * Current grid spacing is shown below graphs.
       * .. image:: media/graph_window_opt_grid_zoom.png
            :width: 100%
              
     - .. image:: media/graph_window_opt_grid.png
          :width: 100%
          :align: right


Jump within GUI Guide
========================

.. include:: substep_gui_jump.rst
