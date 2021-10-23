.. _nh_macaque_taskfmri:


Task FMRI processing: the MACAQUE_DEMO
==========================================

.. contents:: :local:

.. highlight:: none

**Overview**
------------------------

Welcome to the homepage of the demo for processing task FMRI macaque
data.

The demo dataset contains an anatomical dataset and several EPIs
collected during a visual stimulus with four stimulus classes related
to specific faces and objects shown to the subject.  

The processing scripts include calculating nonlinear alignment between
the subject's anatomical (using AFNI's ``@animal_warper``) and the
stereotaxic NMT template.  Additionally, a full single subject
processing pipeline is constructed with ``afni_proc.py``, including an
HRF appropriate for this EPI data that had been collected with MION.

These scripts are meant to providing and example and starting point of
task processing.  Many features can (and, in general, will) be
adjusted for your own study's design.  Please feel free to ask
question on the AFNI Message Board, even with regards to setting up
your study.

Thanks go to Adam Messinger, Ben Jung and Jakob Seidlitz for both the
accompanying macaque data set and many processing suggestions/advice.

*Updated Oct 23, 2021: MACAQUE_DEMO v4.0.*

**Download the MACAQUE_DEMO**
------------------------------

To get the demo, copy+paste::

  @Install_MACAQUE_DEMO

This will both download and unpack the demo in the directory where the
command is run.  

There is a ``README.txt`` describing the contents and how to execute
the scripts.

**Demo contents**
------------------------

Input datasets
^^^^^^^^^^^^^^

The demo contains one subject's initial data:

* a standard, high-res anatomical (T1w) dataset

* a set of task FMRI (EPI) datasets; these are raw EPIs, with "place
  correction" already performed

* a set of stimulus timing files; these have already been adjusted for
  the TR removal that will be performed during processing

* reference template and atlas: here, the stereotaxic NMT and the D99
  template in that space

Processing: nonlinear alignment with @animal_warper
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

All demo scripts are distributed in a directory called ``scripts/``.
See the ``README.txt`` in the main demo directory for dsecriptions of
what each contains and how to run them.

Some processed datasets are also included.  In particular, AFNI's
``@animal_warper`` command was run on the anatomical dataset to
perform both skullstripping and nonlinear alignment to template space
(here, the stereotaxic NMT template).  This has been performed with
the included ``do_13_aw.tcsh`` script.  Some of the functionality and
output of this step can be seen in the automatically generated QC
images:

.. list-table:: 
   :header-rows: 1
   :widths: 100 

   * - Alignment check: warped anatomical overlaying reference base edges
   * - .. image:: media/tbfmri_qc/qc_00_e_temp+wrpd_inp.sag.png
          :width: 100%   
          :align: center

.. list-table:: 
   :header-rows: 1
   :widths: 100 

   * - Skullstripping check: native space anatomical underlaying brain mask
   * - .. image:: media/tbfmri_qc/qc_02_orig_inp+mask.sag.png
          :width: 100%   
          :align: center

.. list-table:: 
   :header-rows: 1
   :widths: 100 

   * - Atlas ROIs mapped to native space 
   * - .. image:: media/tbfmri_qc/qc_03_ee_orig_inp+wrpd_atlas.sag.png
          :width: 100%   
          :align: center

.. list-table:: 
   :header-rows: 1
   :widths: 80 

   * - SUMA view of ROI parcellation in native space (some ROIs have
       been made nearly transparent to show show inner regions)
   * - .. image:: media/tbfmri_qc/d99.gif
          :width: 80%   
          :align: center


Outputs from this step are included as inputs for ``afni_proc.py``.


|

Processing: full single subject preprocessing with afni_proc.py 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

A full preprocessing script for the subject, including motion
correction and regression modeling, is generated using
``afni_proc.py``.  The ``do_20_ap.tcsh`` script contains an example of
including 4 EPI datasets for processing, and the ``do_21_ap_all.tcsh``
script runs over all 15 EPIs included in the demo (the latter takes
notably longer to run).

The outputs of the the ``afni_proc.py``\-generated scripts are not
included, but their automatically generated QC HTML files are.

.. list-table:: 
   :header-rows: 1
   :widths: 50 50 

   * - QC blocks: anat-to-template and stat modeling (full F-stat)
     - QC block: motion and outliers
   * - .. image:: media/tbfmri_qc/apqc_va2t_vstat.png
          :width: 100%   
          :align: center
     - .. image:: media/tbfmri_qc/apqc_mot.png
          :width: 100%   
          :align: center

.. list-table:: 
   :header-rows: 1
   :widths: 50 50 

   * - QC block: warnings (collinearity, censoring, etc.)
     - QC block: regression (ideal response, DF counts, etc.)
   * - .. image:: media/tbfmri_qc/apqc_warns.png
          :width: 100%   
          :align: center
     - .. image:: media/tbfmri_qc/apqc_regr.png
          :width: 100%   
          :align: center

|

Additional reading
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

For more information about ``@animal_warper``, please see:

* | Jung B, Taylor PA, Seidlitz PA, Sponheim C, Perkins P, Glen DR,
    Messinger A (2020). A Comprehensive Macaque FMRI Pipeline and
    Hierarchical Atlas. NeuroImage 235:117997.
  | `<https://pubmed.ncbi.nlm.nih.gov/33789138/>`_
  | `<https://www.biorxiv.org/content/10.1101/2020.08.05.237818v1>`_

For more information about the NMTv2 template and CHARM and SARM atlas,
please see:

* | Jung B, Taylor PA, Seidlitz PA, Sponheim C, Perkins P, Glen DR,
    Messinger A (2020). A Comprehensive Macaque FMRI Pipeline and
    Hierarchical Atlas. NeuroImage 235:117997.
  | `<https://pubmed.ncbi.nlm.nih.gov/33789138/>`_
  | `<https://www.biorxiv.org/content/10.1101/2020.08.05.237818v1>`_

* | Hartig R, Glen D, Jung B, Logothetis NK, Paxinos G,
    Garza-Villareal EA, Messinger A, Evrard HC (2020).  Subcortical
    Atlas of the Rhesus Macaque (SARM) for neuroimaging. NeuroImage
    235:117996.
  | `<https://pubmed.ncbi.nlm.nih.gov/33794360/>`_
  | `<https://www.biorxiv.org/content/10.1101/2020.09.16.300053v1.full>`_

For more information about the PRIME-RE (the PRIMatE Resource
Exchange), please see:

* | Messinger A, Sirmpilatze N, Heuer K, Loh K, Mars R, Sein J, Xu T,
    Glen D, Jung B, Seidlitz J, Taylor P, Toro R, Garza-Villareal E,
    Sponheim C, Wang X, Benn A, Cagna B, Dadarwal R, Evrard H,
    Garcia-Saldivar P, Giavasis S, Hartig R, Lepage C, Liu C, Majka P,
    Merchant H, Milham M, Rosa M, Tasserie J, Uhrig L, Margulies D,
    Klink PC (2020).  A collaborative resource platform for non-human
    primate neuroimaging. Neuroimage, 226:117519.
  | `<https://pubmed.ncbi.nlm.nih.gov/33227425/>`_
  | `<https://doi.org/10.1016/j.neuroimage.2020.117519>`_
