.. _edu_afni03_interactive:


****************************
**Using AFNI Interactively**
****************************

.. contents::
   :depth: 3

**Download the pdf version here:** `afni03_interactive.pdf 
<https://afni.nimh.nih.gov/pub/dist/edu/data/CD.expanded/afni_handouts/afni03_interactive.pdf>`_

Start the AFNI GUI
==================

.. list-table::
   :widths: 60 40
   :header-rows: 0
   
   * - * Start the GUI by typing ``afni`` at the command line.
      
       * How does the AFNI GUI load datasets into memory when started?
         
         * The ``afni`` GUI reads datasets from the current directory.
         * If there are no datasets in current directory, it tries to read
           sub-directories 1 level deeper.
           
       * ``afni dir1 dir2 ...`` reads datasets from directories listed.
       * ``afni -R`` reads datasets from the current directory and from all
         directories below it.
       * There are also special directories that can be specified to always
         also be opened when you run the AFNI GUI; these often contain
         reference templates and atlases, so these datasets don't have to be
         copied around.
        
         * These are specified with AFNI environment variables, such as
           ``AFNI_GLOBAL_SESSION``, ``AFNI_ATLAS_PATH``, and more.
          
     - .. image:: media/afni03_interactive/afni_controller_window.png
          :align: center
          :width: 400

.. note:: AFNI reads a settings file named ``~/.afnirc`` from your
          home directory, if it is present.  This file is used to
          change many of the defaults (cf the :ref:`list of all AFNI
          environment variables <edu_env_vars>` to set there).

Open an image for viewing
+++++++++++++++++++++++++

.. list-table::
   :widths: 60 40
   :header-rows: 0
  
   * - * An Image Window may have opened when afni was launched.
         (If not, you can open an image window by clicking ``Image`` next to 
         ``Axial``, ``Sagittal``, or ``Coronal``. 
         :ref:`see here<Open Image and Graph>` )
   
       * ``UnderLay`` chooses which 3D dataset to view as the background 
         (grayscale)
         
         * Current underlay dataset determines the resolution of and 3D region 
           covered by image viewers
         * anatomical or time series datasets usually go here
         * Datasets which can be graphed are marked with a ``*`` after 
           their names
         
       * ``OverLay`` Use this to choose which overlay (color) 3D dataset to view
         
         * Functional (statistical) dataset usually goes here
         * Functional datasets will be interpolated to the 
           underlay resolution, and flipped to that orientation (if needed)
         
           * The ``Define Datamode`` panel controls the interpolation method.
             :ref:`(See here)<edu_afni03_datamode>`
           
       * Both buttons open a dataset chooser window 
         :ref:`(See here)<edu_afni03_chooser>`
       * Datasets that are compressed have a ``z`` after their names
       * Datasets available are from the current session
       * :ref:`See here for more information on the Image Window<edu_afni03_image_window>`
       
     - .. image:: media/afni03_interactive/afni_controller_window_under_over_lay.png
          :width: 100%
          :align: right

Controller window tour
===================================

1st column
++++++++++

.. list-table::
   :widths: 60 40
   :header-rows: 0
   
   * - * The **xyz-coordinate display** in upper left corner shows
         current focus location
       * By default, the coordinates are in **RAI** order (from the
         DICOM standard):

         * x = Right (negative) to Left (positive)
         * y = Anterior (negative) to Posterior (positive)
         * z = Inferior (negative) to Superior (positive)

       * This display order can be changed to the neuroscience
         imaging order **LPI**:

         * x = Left (negative) to Right (positive)                         
         * y = Posterior (negative) to Anterior (positive)                 
         * z = Inferior (negative) to Superior (positive)                  
         * Right-click in coordinate display to change the
           coordinate order

     - .. image:: media/afni03_interactive/afni_controller_window_xyz.png 
          :width: 100%  
          :align: right
    
.. list-table::
   :widths: 60 40
   :header-rows: 0
   
   * - * ``Xhairs``: Type of crosshairs

         * *Off:* no display of crosshairs
         * *Single:* display of single crosshairs
         * *Multi:* display of crosshairs for each slice in the
           'montage' layouts
         * *LR+AP:* display crosshairs only parallel to the L-R and
           A-P axes (etc.)

       * ``X+``: Montage will show the crosshairs in all slices or
         just one slice
       * ``Color``: Change the color of crosshairs to make it more
         visible with certain image overlays
       * ``Gap``: Size of gap (in voxels) at the center of the
         crosshairs
       * ``Wrap``: Montage layout wraps around when the slices go past
         an edge of the dataset
         
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
         * Increment or decrement with the arrows or just type in
           the number
         * Right click on ``Index`` for a menu of extra options

     - .. image:: media/afni03_interactive/afni_controller_window_index.png 
          :width: 100%
          :align: right

.. _Open Image and Graph:

.. list-table::
   :widths: 60 40
   :header-rows: 0

   * - * ``Image`` and ``Graph`` buttons for the adjacent views
         (Axial, Sagittal, Coronal)

         * Normal: button opens a viewing window
         * Inverted: button raises opened window
         * Right-click on an inverted button 'fetches' the image /
           graph window

       * N.B.: AFNI does not read datasets from disk until a window is
         opened
       * This can make opening the first viewing window be quite slow
       * ``Graph`` buttons are only enabled for datasets that are
         viewing their data files directly

         * Not warping on demand -- see the top of the ``Define
           Datamode`` control panel :ref:`(see here)<Define Datamode>`

     - .. image:: media/afni03_interactive/afni_controller_window_image_graph.png
           :width: 100%
           :align: right

.. list-table::
   :widths: 60 40
   :header-rows: 0
   
   * - * ``BHelp`` button: when pressed, the cursor changes to a hand
         shape

         * Use it to click on any AFNI button and you will get a
           small help popup (and click on it when done, to close)
         * AFNI also has 'hints' (AKA 'tooltips')

       * Press the ``done`` button twice within 5 seconds to exit AFNI

         * The first button press changes ``done`` to ``DONE``
         * Fail to press second time in 5 seconds: it changes back to
           ``done``
         * Don't press a mouse button in the blank square to the
           right of ``done``
         * We won't be responsible for the consequences

     - .. image:: media/afni03_interactive/afni_controller_window_bhelp_done.png
          :width: 100%
          :align: right

2nd column
++++++++++

.. list-table::
   :widths: 60 40
   :header-rows: 0
   
   * - * Use these to select the type of view for your data. **Need more here**
         
         * ``Original View``
         * ``AC-PC Aligned``
         * ``Talairach View``
         * notes on why these are sometimes greyed out.
         
     - .. image:: media/afni03_interactive/afni_controller_window_view.png
          :width: 100%
          :align: right
          
.. list-table::
   :widths: 60 40
   :header-rows: 0
 
   * - * ``Define Overlay ->``: Use this to control the thresholds, colors,
         etc. for overlays.
         
         * More on this here -> :ref:`Overlay<edu_afni03_overlay>`
         
       * ``See Overlay``: Show / Hide the overlay dataset
       
         * This is useful for seeing what anatomical features are 'under' a 
           particular overlay color
           
       * ``Define Datamode`` Use this to control the mode in which the underlay
         data is viewed, and also to save 3D datasets to disk
         
         * More on this here -> :ref:`Datamode<edu_afni03_datamode>`
         
     - .. image:: media/afni03_interactive/afni_controller_window_overlay_datamode.png
          :width: 100%
          :align: right

.. list-table::
   :widths: 60 40
   :header-rows: 0
 
   * - * ``Switch`` Use this to choose from which session 3D datasets may be 
         viewed
         
         * All datasets in same directory are assumed to be aligned in space
         
           * **this is in the handout, but I don't think it is true...**
           
         * Any dataset can be the underlay; any dataset can be the overlay
         
       * ``Read`` Click this button to get a 'chooser' dialog window to select
         a new directory from which to read datasets
         
         * This will add a new 'session' that you can select with the ``Switch``
           button
       
     - .. image:: media/afni03_interactive/afni_controller_window_DataDir.png
          :width: 100%
          :align: right
          
<<<<<<< HEAD
=======
.. list-table::
   :widths: 60 40
   :header-rows: 0

   * - * ``UnderLay`` choose which 3D dataset to view as the background 
         (grayscale)
         
         * Current underlay dataset determines the resolution of and 3D region 
           covered by image viewers
         * anatomical or time series datasets usually go here
         * Datasets which can be graphed are marked with a ``*`` after 
           their names
         
       * ``OverLay`` Use this to choose which overlay (color) 3D dataset to view
         
         * Functional (statistical) dataset usually goes here
         * Functional datasets will be interpolated to the 
           underlay resolution, and flipped to that orientation (if needed)
         
           * The ``Define Datamode`` panel controls the interpolation method.
             :ref:`(See here)<edu_afni03_datamode>`
           
       * Both buttons open a dataset chooser window 
         :ref:`(See here)<edu_afni03_chooser>`
       * Datasets that are compressed have a ``z`` after their names
       * Datasets available are from the current session
       
     - .. image:: media/afni03_interactive/afni_controller_window_under_over_lay.png
          :width: 100%
          :align: right
>>>>>>> 412617ec43d8d0a0f8c90f01315a390a7b3b7752

.. list-table::
   :widths: 60 40
   :header-rows: 0

   * - * ``EditEnv`` **need more here**

       * ``NIML+PO``: Start listening for NIML and Plugout TCP/IP (network 
         sockets) **need more here**

         * Expecting AFNI to talk to suma and/or plugout_drive
         * Like running ``afni -niml -yesplugouts`` on the command line
         * Greyed out if already listening (you already pushed it or launched
           afni with ``-niml -yesplugouts``

     - .. image:: media/afni03_interactive/afni_controller_window_env_niml.png
          :width: 100%
          :align: right

.. list-table::
   :widths: 60 40
   :header-rows: 0
  
   * - * ``Control Surface``: control the display of overlaid surfaces in the 
         image viewers when talking with ``suma``
         
         * Surface nodes will have little boxes drawn, when they appear in a 
           slice
         * Surface triangles will have line segments drawn, where they intersect 
           a slice center-plane
         * Greyed out if ``suma`` is not running and talking with ``afni``
  
     - .. image:: media/afni03_interactive/afni_controller_window_cont_surf.png
          :width: 100%
          :align: right
          
.. list-table::
   :widths: 60 40
   :header-rows: 0
    
   * - * Green buttons open your default web browser to various afni related 
         pages.
         
       * Blue button opens an afni GUI window with lots of info
   
       * ``News``: Web link to `afni digest history 
         <https://afni.nimh.nih.gov/pub/dist/src/AFNI_digest_history.txt>`_
         
       * ``Forum``: Web link to `AFNI Message Board 
         <https://afni.nimh.nih.gov/afni/community/board/list.php?1?>`_
  
       * ``Tips``: afni GUI window with lots of info. A web based version of 
         this exists `here 
         <https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/educational/gui_readme_tips.html#afni-for-absolute-beginners>`_
  
       * ``Helps``: Web link to `All program helps 
         <https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/programs/main_toc.html>`_
       
       * ``YouTube``: Web link to the official `AFNI Bootcamp YouTube page 
         <https://www.youtube.com/channel/UC40RiNZN7_dCuB6Lg7HJl1g>`_
       
     - .. image:: media/afni03_interactive/afni_controller_window_news_etc.png
          :width: 100%
          :align: right

.. _Define Overlay:
          
Define Overlay
==============

:ref:`Open Define Overlay Page<edu_afni03_overlay>`

.. _Define Datamode:

Define Datamode
===============

:ref:`Open Define Datamode Page<edu_afni03_datamode>`

.. _Dataset Chooser:

Dataset "Chooser"
=================

:ref:`Open Dataset Chooser Page<edu_afni03_chooser>`

.. _Image Viewer:

Image Viewer
============

.. _Graph Viewer:

Graph Viewer
============





