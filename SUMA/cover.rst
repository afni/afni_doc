.. _cover:

*********
**Intro**
*********

.. contents:: :local:


.. _surface-based:

Overview
==========


SUMA is a program that adds cortical surface based functional imaging
analysis to the AFNI suite of programs https://afni.nimh.nih.gov
. SUMA allows 3D cortical surface renderings, the mapping of
volumetric data onto them and, surface based computations and
statistical inferences. In addition allows rendering and manipulation
of tractography results, connectivity graphs/matrices, and volumes.

.. _cover-figure:

.. list-table:: 
   :header-rows: 0
   :widths: 100

   * - .. image:: media/Cover2.jpg
          :width: 80%   
          :align: center
   * - SUMA also allows display and manipulation of matrices for
       various flavors of connectivity data, tractography results from
       AFNI's FATCAT toolbox, and the rendering of volumetric data.

|

.. _HBM14_01:

.. list-table:: 
   :header-rows: 0
   :widths: 100

   * - .. image:: media/image_HBM14_01.jpg
          :width: 80%   
          :align: center
   * - Whole brain deterministic tractography with AFNI-FATCAT as
       rendered with SUMA. Surface models, here shown with
       transparency, are pried apart to reveal internal structures.

|

.. _HBM14_04:

.. list-table:: 
   :header-rows: 0
   :widths: 100

   * - .. image:: media/image_HBM14_04.jpg
          :width: 80%   
          :align: center
   * - | **A**. Rendering of matrix data as a 3D graph. 
       | **B**. Graph edges represented by bundles. 
       | **C**. Matrix representation of connectivity data.

|

.. _highlights:

Highlights
==========

Multimodal rendering with direct AFNI link
---------------------------------------------------------------------------

.. list-table:: 
   :header-rows: 0
   :widths: 100

   * - .. image:: media/image_HBM14_05.jpg
          :width: 80%   
          :align: center

|

Multiple Linked Viewers
---------------------------------------------------------------------------

You can have up to 8 linked surface viewers open simultaneously.

.. list-table:: 
   :header-rows: 0
   :widths: 100

   * - .. image:: media/MultiView.jpg
          :width: 80%   
          :align: center

|

ROI Drawing
---------------------------------------------------------------------------

Freehand ROI drawing in any viewer. See :ref:`drawing_ROIs`.

.. list-table:: 
   :header-rows: 0
   :widths: 100

   * - .. image:: media/ROI_draw.jpg
          :width: 80%   
          :align: center

|

Simultaneous, yoked left/right hemisphere display
---------------------------------------------------------------------------

Most actions, such as dataset loading and parameter settings on one
hemisphere are automatically carried out on the other hemisphere.

.. list-table:: 
   :header-rows: 0
   :widths: 100

   * - .. image:: media/both_smoothwm.jpg
          :width: 80%   
          :align: center

|

Templates of standard-space volumes in MNI and TLRC
---------------------------------------------------------------------------

If your volumetric data are in Talairach space, you can display
them on these surfaces.  

See :ref:`Template Surfaces<TemplateSurfaces>` for details on
obtaining the surfaces.

.. list-table:: 
   :header-rows: 0
   :widths: 100

   * - .. image:: media/tlrc.jpg
          :width: 80%   
          :align: center

|

Multi-dataset color mapping (+ layering and opacity controls)
---------------------------------------------------------------------------

Each dataset is colored interactively using SUMA's surface
controller shown below. The color mapping of each dataset is stored
in a separate color plane whose order and opacity can be controlled
for each surface model.

Surface models with four stacked color planes consisting of the
surface convexity, drawn ROIs, functional data from AFNI and a node
color data file that looks cool.

.. list-table:: 
   :header-rows: 0
   :widths: 100

   * - .. image:: media/ColPlanes2.jpg
          :width: 80%   
          :align: center   

|

Similarly, data coloring can be done for volumes, graphs, and
connectivity matrices.

.. list-table:: 
   :header-rows: 0
   :widths: 100

   * - .. image:: media/GC_3D.jpg
          :width: 80%   
          :align: center   
   * - .. image:: media/conn_matrix_01.jpg
          :width: 80%   
          :align: center   
   * - .. image:: media/conn_matrix_02.jpg
          :width: 80%   
          :align: center   

|

Recording in continuous and single frame mode
---------------------------------------------------------------------------


Rendered images can be :ref:`captured <LC_r>` by an AFNI-esque
image viewers and saved into all formats provided by AFNI,
including animated gifs and mpegs. Saving can also be done
:ref:`directly <LC_Ctrl+r>` to disk.

.. list-table:: 
   :header-rows: 0
   :widths: 100

   * - .. image:: media/record_int.jpg
          :width: 80%   
          :align: center   

|   

Automation of GUI behavior
--------------------------

You can automate the majority of tasks normally performed
interactively. See demo scripts **@DriveSuma**, **@DriveAfni**, and
**@DO.examples** available in the `AFNI distribution
<https://afni.nimh.nih.gov/afni/download/afni/releases/latest>`_.

.. list-table:: 
   :header-rows: 0
   :widths: 100

   * - .. image:: media/Drive_S+R_F3.jpg
          :width: 80%   
          :align: center   
   * - Illustration for driving SUMA's GUI from the command line with
       DriveSuma. The example here illustrates the functioning of a
       script that automatically generates a movie of MEG SAM data
       from 0 to 600 ms after stimulus delivery. (Data and script to
       generate this movie are courtesy of Chunmao Wang, and available
       `here
       <https://afni.nimh.nih.gov/pub/dist/tgz/SumaMovieDemo.tgz>`_.

|

A library of command line programs for batch processing
-------------------------------------------------------

All voxelwise programs that make up the AFNI distribution will handle
surface-based datasets. Operations such as smoothing and clustering
that have their surface-based equivalent in **SurfSmooth** and
**SurfClust**, for instance.

``afni_proc.py``, AFNI's pipeline generating program, can directly
turn a volume-based analysis into a surface-based one with the simple
addition of two options.
 
|

Interactive Functional and Anatomical Connectivity
--------------------------------------------------

Perform simultaneous, interactive functional and anatomical
connectivity, all while maintaining a link to AFNI and original
volumetric data. Use demo script **Do_09_VISdti_SUMA_visual_ex3.tcsh**
which is part of the :ref:`FATCAT Demo <FATCAT_DEMO>` to walk through
the process.

.. list-table:: 
   :header-rows: 0
   :widths: 100

   * - .. image:: media/f+a_conn.jpg
          :width: 80%   
          :align: center   
   
