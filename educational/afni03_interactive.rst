.. _afni03_interactive:


****************************
**Using AFNI Interactively**
****************************

.. contents::
   :depth: 3

Start AFNI
==========

* ``afni`` reads datasets from the current directory.
    * If no datasets in current directory, tries to read sub-directories 1 level deeper.
* ``afni dir1 dir2 ...`` reads datasets from directories listed.
* ``afni -R`` reads datasets from the current directory and from all directories below it.

.. note:: AFNI reads the file named .afnirc from your home directory, if it is present.
          This file is used to change many of the defaults (cf. File README.environment)

.. image:: media/afni03_interactive/afni_controller_window.png
    :width: 50%
    :align: center
 
Controller window tour
===================================

1st column
++++++++++

.. list-table::
    :widths: 60 40
    :header-rows: 0
    
    * - * xyz-coordinate display in upper left corner shows current focus location
        * By default, the coordinates are in RAI order (from the DICOM standard):
            * x = Right (negative) to Left (positive)
            * y = Anterior (negative) to Posterior (positive)
            * z = Inferior (negative) to Superior (positive)
        * This display order can be changed to the neuroscience imaging order LPI:
            * x = Left (negative) to Right (positive)                         
            * y = Posterior (negative) to Anterior (positive)                 
            * z = Inferior (negative) to Superior (positive)                  
            * Right-click in coordinate display to change the coordinate order
      - .. image:: media/afni03_interactive/afni_controller_window_xyz.png 
                   :width: 100%  
                   :align: right
    
.. list-table::
    :widths: 60 40
    :header-rows: 0
    
    * - * ``Xhairs``: Type of crosshairs
            * Off: no display of crosshairs
            * Single: display of single crosshairs
            * Multi: display of crosshairs for each slice in the 'montage' 
              layouts
            * LR+AP: display crosshairs only parallel to the L-R and A-P axes 
              (etc.)
        * ``X+``: Montage will show the crosshairs in all slices or just one slice                   
        * ``Color``: Change the color of crosshairs to make it more visible with 
          certain image overlays
        * ``Gap``: Size of gap (in voxels) at the center of the crosshairs
        * ``Wrap``: Montage layout wraps around when the slices go past an edge 
          of the dataset
      - .. image:: media/afni03_interactive/afni_controller_window_xhairs.png 
                 :width: 100%
                 :align: right

.. list-table::
    :widths: 60 40
    :header-rows: 0

    * - * ``Index``: Time index
            * Controls the time index of the images being viewed
            * Controls the underlay image only
            * Only available for images that have multiple subbricks 
              (usually for time)
            * Increment or decrement with the arrows or just type in the number
            * Right click on ``Index`` for a menu of extra options
      - .. image:: media/afni03_interactive/afni_controller_window_index.png 
                 :width: 100%
                 :align: right

.. list-table::
    :widths: 60 40
    :header-rows: 0

    * - * ``Image`` and ``Graph`` buttons for the adjacent views (Axial, Sagittal, Coronal)
            * Normal: button opens a viewing window
            * Inverted: button raises opened window
            * Right-click on an inverted button 'fetches' the image / graph window
        * N.B.: AFNI does not read datasets from disk until a window is opened
        * This can make opening the first viewing window be quite slow
        * ``Graph`` buttons are only enabled for datasets that are viewing their data files directly 
            * Not warping on demand -- see the top of the ``Define Datamode`` 
              control panel
      - .. image:: media/afni03_interactive/afni_controller_window_image_graph.png
                   :width: 100%
                   :align: right

.. list-table::
    :widths: 60 40
    :header-rows: 0
    
    * - * The ``BHelp`` button: when pressed, the cursor changes to a hand shape
            * use it to click on any AFNI button and you will get a small help popup
            * AFNI also has ‘hints’ (AKA ‘tooltips’)
        * Press the [done] button twice within 5 seconds to exit AFNI
            * The first button press changes ‘done’ to ‘DONE’
            * Fail to press second time in 5 seconds: it changes back to ‘done’
            * Don’t press a mouse button in the blank square to the right of [done]
            * We won’t be responsible for the consequences
      - .. image:: media/afni03_interactive/afni_controller_window_bhelp_done.png
                   :width: 350
                   :align: right

2nd column
++++++++++
