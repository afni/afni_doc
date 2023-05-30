
.. _tut_surflayers:

***********************
SurfLayers Demo 1
***********************

.. contents:: :local:

.. highlight:: Tcsh


Introduction
============

We briefly describe the SurfLayers Demo, which combines AFNI+SUMA
functionality to investigate surface layers in MRI data.  This Demo
was presented at OHBM 2021:

    | **Creating Layered Surfaces to Visualize with AFNI + SUMA, with
      applications to laminar fMRI**
    | by Torrisi S, Lauren P, Taylor PA, Park S, Feinberg D, Glen DR.
    | `Torrisi et al. (2021) OHBM poster.
      <https://afni.nimh.nih.gov/pub/dist/HBM2021/OHBM2021_SurfLayers_v2.pdf>`_

To run this demo, your system's AFNI version should be at least
21.1.14.

The Demo of scripts+data can be downloaded by running::

  @Install_SURFLAYERS_DEMO1

The above command will both download and unpack the SurfLayers Demo
within the directory from which it is run.  There is a descriptive
``README.txt`` for users to |ss| ignore |se| read.

This demo makes use of and presents several new (at the time) features
within AFNI and SUMA.  Firstly, these scripts utilize the
``SurfLayers`` and ``quickspecSL`` programs, to estimate intermediate
surface layers.  Secondly, they utilize the **clipping plane mode**
within SUMA, whereby one can focus on subregions within the viewer and
investigate nested surface layers.

Each script uses terminal commands to "drive" both the ``afni`` and
``suma`` GUIs, so you can visualize your data.  That is in fact one of
the purposes of these new tools (and of AFNI in general): *to keep
users close to their data, to understand it better.* The GUIs also
"talk" to one another, sending information back and forth in realtime,
so you can really explore your data in fun and informative ways.

| For suggestions on applying SUMA's "Clipping plane" functionality,
  please see this part of the documentation: 
| :ref:`suma_clipping`
| \.\.\. which contains a useful cheatsheet of keystrokes.


Scripts 1 and 2: basic MRI surface
==================================

These scripts use data from the AFNI Bootcamp, namely within the
``AFNI_data6/FT_analyis/`` directory (which is part of the standard
CD.tgz Bootcamp data package):

* the ``FT/SUMA/*`` data, which were created by running FreeSurfer's
  ``recon-all`` on the subject's anatomical, followed by AFNI's
  ``@SUMA_Make_Spec_FS`` to create NIFTI volumes and standardized
  surface meshes.

* the results directory made by running the ``s05.ap.uber`` script,
  which contains an ``afni_proc.py`` command.  (One could also run
  ``s05.ap.uber.NL`` there, which runs an ``afni_proc.py`` command
  that makes using on nonlinear alignment between the subject and
  template space, for more detailed matching).

These scripts are not *really* doing laminar work, per se, because
this data isn't high enough resolution.  However, these scripts do
give a good intro to the functionality and viewing, at a resolution
many people are used to working.

.. list-table:: 
   :header-rows: 1
   :width: 90%

   * - Running script ``s01*``
   * - .. image:: media/img_SL_s01.png
          :width: 100%
          :align: center

.. list-table:: 
   :header-rows: 1
   :width: 90%

   * - Running script ``s02*``
   * - .. image:: media/img_SL_s02.png
          :width: 100%
          :align: center



Scripts 3 and 4: laminar FMRI hemisphere
===========================================

These scripts utilize data contained within the demo itself---and this
is a real, laminar FMRI dataset.  The ``dataset2`` directory contains
one anatomical (MP2RAGE) hemisphere and a 7T fingertapping dataset
using accelerated GRASE sequence.


.. list-table:: 
   :header-rows: 1
   :width: 90%

   * - Running script ``s03*``
   * - .. image:: media/img_SL_s03.png
          :width: 100%
          :align: center

.. list-table:: 
   :header-rows: 1
   :width: 90%

   * - Running script ``s04*``
   * - .. image:: media/img_SL_s04.png
          :width: 100%
          :align: center


Scripts 5 and 6: laminar FMRI patch
=========================================

These scripts also utilize laminar FMRI data contained within the demo
itself (also a 7T accelerated GRASE dataset with an MP2RAGE structural
scan).  The ``dataset3`` directory contains a left calcarine patch
that was drawn on retinotopic (meridian-mapping) functional results on
a spherical surface.

.. list-table:: 
   :header-rows: 1
   :width: 90%

   * - Running script ``s05*``
   * - .. image:: media/img_SL_s05.png
          :width: 100%
          :align: center

.. list-table:: 
   :header-rows: 1
   :width: 90%

   * - Running script ``s06*``
   * - .. image:: media/img_SL_s06.png
          :width: 100%
          :align: center


Questions/Contact
===================

For questions/comments/suggestions, please contact:

.. list-table:: 
   :header-rows: 0
   :align: left

   * - Salvatore (Sam) Torrisi
     - *torrisi __at__ berkeley.edu*
   * - Daniel Glen
     - *glend __at__ mail.nih.gov*
   * - Paul Taylor
     - *paul.taylor __at__ nih.gov*

| \.\.\. and/or use the ever-popular AFNI Messageboard:
| `<https://discuss.afni.nimh.nih.gov>`_



.. |ss| raw:: html

   <strike>

.. |se| raw:: html

   </strike>
