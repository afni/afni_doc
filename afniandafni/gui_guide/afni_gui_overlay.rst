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
         open and check the ``See OverLay`` button.
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
       * The sub-brick labels are assigned when the dataset is created. The 
         index values show the numerical location of the sub-brick in the 
         dataset (starting at 0 of course).
         **typo in the button help for ``ULay``**
       * The ``Thr`` allows you to choose the sub-brick of the overlay 
         dataset with which to threshold the ``Olay`` sub-brick.
       * **need screen caps here**
         
     - .. image:: media/overlay_main_ulay_olay_thr.png
          :width: 100%
          :align: right

Jump within GUI Guide
========================

.. include:: substep_gui_jump.rst
