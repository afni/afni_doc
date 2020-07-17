.. _nh_macaque_template_nmtv1:


**Macaque template:  NMT v1 (older)**
========================================================

.. contents:: :local:

.. highlight:: None

Overview
------------------------

Here we present the NIMH Macaque Template (NMT), version 1.2 and 1.3.
This is a group template from 31 macaques with surfaces and GM/WM/CSF
segmentations.

**Please note that there is a newer version of this template.** See
this page: :ref:`nh_macaque_template_nmtv2`.


NMT v1.3
------------------------

Contents
^^^^^^^^^^^^^^^^^^^

.. list-table:: 
   :header-rows: 1
   :widths: 20 80
   :stub-columns: 0

   * - NMT v1.3 contents
     - Description
   * - **CustomAtlases.niml**
     - atlas description text file for AFNI
   * - **D99_atlas_1.2a_al2NMT.nii.gz**
     - D99 atlas in NMT v1.3 space
   * - **NMT_brainmask.nii.gz**
     - binary brain mask (including cerebellum)
   * - **NMT_env.csh**
     - script to set AFNI environment variables for AFNI to use
       atlases and make AFNI more monkey friendly.  **Note:** running
       this script will change your default atlases for ``whereami``
       functionality, so if you also do human studies, be aware that
       you might have to change some environment settings again later.
   * - **NMT_GM_cortical_mask.nii.gz**
     - binary mask of cortical GM
   * - **NMT_GM_cortical_mask_withWM.nii.gz**
     - map of cortical GM and WM
   * - **NMT.nii.gz**
     - the NMT itself, including non-brain material
   * - **NMT_segmentation_4class.nii.gz**
     - map of tissue segmentation, cortex and cerebellum
   * - **NMT_SS.nii.gz**
     - the NMT itself, skullstripped
   * - **NMT_subject_align**
     - a script used to perform affine and nonlinear alignments of an
       anatomical volume to the NMT using AFNI commands. **Note:** In
       the NMT v2, this script has been replaced with the AFNI command
       ``@animal_warper``
   * - **NMT_subject_morph**
     - a script that uses ANTs to perform template-based morphometrics
       of a native scan. Requires outputs from
       NMT_subject_align. **Note:** we do not recommend use of this
       script, as `the new CIVET-macaque pipeline
       <https://github.com/aces/CIVET_Full_Project>`_ conducts
       automated surface-based morphometrics in the NMT space.
   * - **NMT_subject_pipeline**
     - a wrapper script that performs NMT_subject_align,
       NMT_subject_process and NMT_subject_morph using a single
       command!
   * - **NMT_subject_process**
     - a script used to perform template-based skullstripping and
       segmentation in the native space of a subject using AFNI and
       ANTs commands. Requires outputs from
       NMT_subject_align. **Note:** In the NMT v2, template-based
       skullstripping is performed by the AFNI command
       ``@animal_warper``
   * - **processing_masks/**
     - directory of tissue and segmentation volumes
   * - **quick_view.csh**
     - example script to quickly view surfaces and volumes in ``suma``
       and ``afni``
   * - **README.md**
     - go ahead, I *dare* you to read it
   * - **supplemental_D99/**
     - directory of a table of D99 ROI index/label definitions
   * - **supplemental_masks/**
     - directory of NIFTI volumes of "other" structures (vasculature,
       cerebellum, LR brainmask, olfactory bulb)
   * - **surfaces/**
     - directory of GIFTI surfaces of many of the tissue/segmentation
       regions



Download
^^^^^^^^^^^^^^^^^^^

To download and unpack the datasts to your present working directory,
copy+paste::

  @Install_NMT -nmt_ver 1.3



Citation/questions
^^^^^^^^^^^^^^^^^^^

If you make use of the NMT v1.3 template or accompanying data in your
research, please cite:

   Seidlitz J, Sponheim C, Glen DR, Ye FQ, Saleem KS, Leopold DA,
   Ungerleider L, Messinger A (2018). "A Population MRI Brain Template
   and Analysis Tools for the Macaque." NeuroImage 170: 121–31.
   `https://doi.org/10.1016/j.neuroimage.2017.04.063`_.

   Jung B, Taylor PA, Seidlitz PA, Sponheim C, Glen DR, Messinger A
   (2020).  "A Comprehensive Macaque FMRI Pipeline and Hierarchical
   Atlas."  NeuroImage, submitted.

| For questions, comments and/or suggestions, contact:
| **Adam.Messinger@nih.gov**
| **benjamin.jung@nih.gov**
| **glend@mail.nih.gov**.

|


NMT v1.2
------------------------


.. list-table:: 
   :header-rows: 1
   :widths: 100 

   * - A SUMA view of the NMT v1.2.
   * - .. image:: media/nmt/v1/nmt_v1_afnisuma.png
          :width: 70%   
          :align: center



Download
^^^^^^^^^^^^^^^^^^^

To download and unpack the datasts to your present working directory,
copy+paste::

  @Install_NMT -nmt_ver 1.2


Citation/questions
^^^^^^^^^^^^^^^^^^^

If you make use of the NMT v1.2 template or accompanying data in your
research, please cite:

   Seidlitz J, Sponheim C, Glen DR, Ye FQ, Saleem KS, Leopold DA,
   Ungerleider L, Messinger A (2018). "A Population MRI Brain Template
   and Analysis Tools for the Macaque." NeuroImage 170: 121–31.
   `<https://doi.org/10.1016/j.neuroimage.2017.04.063>`_.

| For questions, comments and/or suggestions, contact:
| **Adam.Messinger@nih.gov**
| **Jakob.Seidlitz@nih.gov**
| **glend@mail.nih.gov**.

