.. _edu_afni03_graph:


******************************************
**Using AFNI Interactively: Graph Window**
******************************************

.. contents::
   :depth: 3

**Go back to the start** :ref:`HERE<edu_afni03_interactive>`

Open Some Graph Windows
=======================

.. list-table::
   :widths: 50 50
   :header-rows: 0
   
   * - * ``Graph`` buttons for the adjacent views (Axial, Sagittal, Coronal)

         * Normal: button opens a viewing window
         * Inverted: button raises opened window
         * Right-click on an inverted button 'fetches' the graph window
       
       * ``Graph`` buttons are *usually* only meaningfull if the selected 
         underlay dataset has a time index (*usually* some functional image)
              
       * ``Graph`` buttons are only enabled for datasets that are
         viewing their data files directly

         * Not warping on demand -- see the top of the ``Define
           Datamode`` control panel :ref:`(see here)<Define Datamode>`
           
     - .. image:: media/afni03_interactive/graph_window_open.png
          :width: 100%
          :align: right
          

Graph Window
============

.. list-table::
   :widths: 60 40
   :header-rows: 0
   
   * - * Graph viewer takes voxel values from same dataset as image viewer
   
         * If dataset has only 1 sub-brick, graph viewer only shows numbers
           (Not very useful unless you are an MRI physics type, perhaps)
 
       * To look at images from one dataset locked to graphs from another 
         dataset, must use 2 AFNI controllers and ``Define Datamode`` ⇒ 
         ``Lock`` on AFNI control panel
      
     - .. image:: media/afni03_interactive/graph_window.png
          :width: 100%
          :align: right
          
          
.. list-table::
   :widths: 50 50
   :header-rows: 0
   
   * - * If graph and image viewer in same slice orientation are both open, 
         crosshairs in image window change to show a box containing dataset 
         voxels being graphed
         
     - .. image:: media/afni03_interactive/graph_window_xhair_box.png
          :width: 100%
          :align: right
          
          
.. list-table::
   :widths: 50 50
   :header-rows: 0

   * - * Central sub-graph (current focus location) is outlined in *yellow*
         
         * Current time index is marked with small red diamond on data graph
         * Left-clicking in a non-central sub-graph moves that location to 
           focus. Making it the *yellow* center sub-graph and moving the 
           crosshairs on the image window to match the new location.
         * Left-clicking in central sub-graph moves time index to nearest point
         
           * Can also use ``Index`` control in AFNI controller to change time
           
         * Right-clicking in any sub-graph pops up some statistics of its data
         
     - .. image:: media/afni03_interactive/graph_window_stats.png
          :width: 100%
          :align: right
          
          
          

          
****************************************
  Using AFNI Interactively *Continued* 
****************************************

:ref:`Next (Suggested) Page: Overlay<edu_afni03_overlay>`
=========================================================


Jump to Sections
================

.. include:: afni03_jump_to_section.rst