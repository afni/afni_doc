.. _nh_macaque_template_nmtv2:


**Macaque template:  NMT v2 (current)**
========================================================

.. contents:: :local:

.. highlight:: None

Overview
------------------------

Here we present the NIMH Macaque Template (NMT), version 1.2 and 1.3.
This is a group template from 31 macaques with surfaces and GM/WM/CSF
segmentations.

The NMT v2 is the most current version of this dataset.

| Be sure to also check out the accompanying *CHARM (Cortical
  Hierarchy Atlas of the Rhesus Macaque)*, described here: 
| :ref:`nh_macaque_atlas_charm`.


Contents
^^^^^^^^^^^^^^^^^^^

There are both symmetric and asymmetric "variants" for the NMT v2. 

Additionally, for each variant there are sets of data with different
spatial resolution and FOV:

* the "standard" NMT has 0.25 mm isotropic voxels and a
  "brain-focused" FOV,

* the "low-res" NMT has 0.5 mm isotropic voxels and a "brain-focused"
  FOV,

* the "full-head" NMT has 0.25 mm isotropic voxels and a larger FOV,
  encompassing more non-brain material.

An example of the contents in the download of the symmetric NMT v2
(which is essentially mirrored in the asymmetric version) is provided
here:

.. list-table:: 
   :header-rows: 1
   :widths: 20 80
   :stub-columns: 0

   * - NMT v2 contents
     - Description
   * - **CustomAtlases.niml**
     - atlas description text file for AFNI
   * - **NMT_changelog.txt**
     - text file of changes and updates to the distributed datasets
   * - **NMT_v2.0_sym/**
     - directory of the "standard" NMT files (i.e., standard spatial
       resolution of 0.25 mm iso voxels and brain-focused FOV)
   * - **NMT_v2.0_sym_05mm/**
     - directory of the "low-res" NMT files (0.5 mm iso voxels; lower
       spatial resolution but still useful, if not preferred, for some
       analysis cases like in standard FMRI processing)
   * - **NMT_v2.0_sym_env.csh**
     - script to set AFNI environment variables for AFNI to use
       atlases and make AFNI more monkey friendly.  **Note:** running
       this script will change your default atlases for ``whereami``
       functionality, so if you also do human studies, be aware that
       you might have to change some environment settings again later.
   * - **NMT_v2.0_sym_fh/**
     - directory of the "full head" NMT files (i.e., 0.25 mm iso
       voxels but a larger FOV, more non-brain material), which may be
       useful for some alignment cases
   * - **NMT_v2.0_sym_surfaces/**
     - directory of GIFTI surfaces of many of the tissue/segmentation
       regions
   * - **supplemental_CHARM/**
     - directory of tables of CHARM ROI index/label definitions and more
   * - **supplemental_D99/**
     - directory of a table of D99 ROI index/label definitions
   * - **supplemental_Paxinos/**
     - directory of a table of Paxinos ROI index/label definitions

|

An example of the contents of the "standard" NMT directory
**NMT_v2.0_sym/**, above are as follows (within similar sets of data
in the "low-res" and "full-head" directories):

.. list-table:: 
   :header-rows: 1
   :widths: 20 80
   :stub-columns: 0

   * - NMT_v2.0_sym/ contents
     - Description
   * - **CHARM_in_NMT_v2.0_sym.nii.gz**
     - hierarchical atlas (6 levels) in NMT v2 space
   * - **D99_atlas_in_NMT_v2.0_sym.nii.gz**
     - D99 atlas in NMT v2 space
   * - **NMT_v2.0_sym_brainmask.nii.gz**
     - binary brain mask (including cerebellum)
   * - **NMT_v2.0_sym_GM_cortical_mask.nii.gz**
     - binary mask of cortical GM
   * - **NMT_v2.0_sym.nii.gz**
     - the NMT v2 template, with non-brain material surrounding
   * - **NMT_v2.0_sym_segmentation.nii.gz**
     - tissue segmentation of the whole brain
   * - **NMT_v2.0_sym_SS.nii.gz**
     - the NMT itself, skullstripped, not stirred
   * - **Paxinos_atlas_in_NMT_v2.0_sym.nii.gz**
     - Paxinos atlas in NMT v2 space
   * - **supplemental_CHARM/**
     - the CHARM atlas levels as individual volumetric files
   * - **supplemental_masks/**
     - masks of "other" things (cerebellum, ventricles, L-R hemispheres)


|

Download
^^^^^^^^^^^^^^^^^^^

To download and unpack the datasts to your present working directory,
copy+paste ...

* ... this for the *symmetric* variant::

    @Install_NMT -nmt_ver 2.0 -sym sym

* ... this for the *asymmetric* variant::

    @Install_NMT -nmt_ver 2.0 -sym asym


Citation/questions
^^^^^^^^^^^^^^^^^^^

If you make use of the NMT v2 template or accompanying data in your
research, please cite:

   Seidlitz J, Sponheim C, Glen DR, Ye FQ, Saleem KS, Leopold DA,
   Ungerleider L, Messinger A (2018). "A Population MRI Brain Template
   and Analysis Tools for the Macaque." NeuroImage 170: 121–31.
   `<https://doi.org/10.1016/j.neuroimage.2017.04.063>`_.

   Jung B, Taylor PA, Seidlitz PA, Sponheim C, Glen DR, Messinger A
   (2020).  "A Comprehensive Macaque FMRI Pipeline and Hierarchical
   Atlas."  NeuroImage, submitted.

| For questions, comments and/or suggestions, contact:
| **Adam.Messinger@nih.gov**
| **benjamin.jung@nih.gov**
| **glend@mail.nih.gov**.
