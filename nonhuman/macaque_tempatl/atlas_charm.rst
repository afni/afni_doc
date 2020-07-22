.. _nh_macaque_atlas_charm:


**Macaque atlas:  the CHARM**
========================================================

*Charm is more valuable than beauty. You can resist beauty, but you
can't resist charm.* --Audrey Tatou

.. note
   
   (Fortunately the CHARM atlas looks good, too!)

.. contents:: :local:

.. highlight:: None

Overview
------------------------

Here we present the Cortical Hierarchy Atlas of the Rhesus Macaque
(CHARM).

| This atlas is defined in the coordinates/space of the NMT v2
  template, described here:
| :ref:`nh_macaque_template_nmtv2`.



Contents
^^^^^^^^^^^^^^^^^^^

The CHARM parcellates the macaque cortex at six spatial scales.  This
allows the researcher to choose the appropriate level of investigation
for their study design and data.  

The CHARM is distributed as a single data set with six sub-volumes.
Note that for the purpose of using AFNI sub-brick selectors, CHARM
Level 1 is volume ``"[0]"`` and Level 6 is volume ``"[5]"``, because
AFNI (like Python and C) use zero-base counting.

As a wise person once said, templates and atlases go together like
peanut butter and jelly.  It really doesn't make sense to consider and
atlas without acknowledging/using the underlaying space defined by its
associated template.  That is why the CHARM is distributed with its
definitive template, the NMT v2.  The NMT v2 has several forms and
variants (based on symmetry/asymmetry, FOV and voxel size), and for
each of these there is an accompanying CHARM.

|

Example images
^^^^^^^^^^^^^^^^^^^

The following images were made using the symmetric NMT v2 template
(with "standard" spatial resolution = 0.25 mm, and FOV = brain volume)
and accompanying CHARM.

.. list-table:: 
   :header-rows: 1
   :widths: 100 

   * - Skull-stripped NMT with the CHARM (level 1)
   * - .. image:: media/charm/img_nmt2.0symss_charmL1.axi.png
   * - .. image:: media/charm/img_nmt2.0symss_charmL1.cor.png
   * - .. image:: media/charm/img_nmt2.0symss_charmL1.sag.png

|

.. list-table:: 
   :header-rows: 1
   :widths: 100 

   * - Skull-stripped NMT with the CHARM (level 2)
   * - .. image:: media/charm/img_nmt2.0symss_charmL2.axi.png
   * - .. image:: media/charm/img_nmt2.0symss_charmL2.cor.png
   * - .. image:: media/charm/img_nmt2.0symss_charmL2.sag.png

|

.. list-table:: 
   :header-rows: 1
   :widths: 100 

   * - Skull-stripped NMT with the CHARM (level 3)
   * - .. image:: media/charm/img_nmt2.0symss_charmL3.axi.png
   * - .. image:: media/charm/img_nmt2.0symss_charmL3.cor.png
   * - .. image:: media/charm/img_nmt2.0symss_charmL3.sag.png

|

.. list-table:: 
   :header-rows: 1
   :widths: 100 

   * - Skull-stripped NMT with the CHARM (level 4)
   * - .. image:: media/charm/img_nmt2.0symss_charmL4.axi.png
   * - .. image:: media/charm/img_nmt2.0symss_charmL4.cor.png
   * - .. image:: media/charm/img_nmt2.0symss_charmL4.sag.png

|

.. list-table:: 
   :header-rows: 1
   :widths: 100 

   * - Skull-stripped NMT with the CHARM (level 5)
   * - .. image:: media/charm/img_nmt2.0symss_charmL5.axi.png
   * - .. image:: media/charm/img_nmt2.0symss_charmL5.cor.png
   * - .. image:: media/charm/img_nmt2.0symss_charmL5.sag.png

|

.. list-table:: 
   :header-rows: 1
   :widths: 100 

   * - Skull-stripped NMT with the CHARM (level 6)
   * - .. image:: media/charm/img_nmt2.0symss_charmL6.axi.png
   * - .. image:: media/charm/img_nmt2.0symss_charmL6.cor.png
   * - .. image:: media/charm/img_nmt2.0symss_charmL6.sag.png

|

Download
^^^^^^^^^^^^^^^^^^^

The CHARM is distributed as part of the NMT v2 download. For each
form/variant of the NMT, there is a matching CHARM dataset, as well.

To download and unpack the datasets, please see the instructions\.\.\.

* \.\.\. *here* for the **symmetric** form:
  :ref:`nh_macaque_template_nmtv2_sym_dl`

* \.\.\. *here* for the **asymmetric** form:
  :ref:`nh_macaque_template_nmtv2_asym_dl`


Citation/questions
^^^^^^^^^^^^^^^^^^^

If you make use of the CHARM and/or accompanying NMT v2 data in your
research, please cite:

   Jung B, Taylor PA, Seidlitz PA, Sponheim C, Glen DR, Messinger A
   (2020).  "A Comprehensive Macaque FMRI Pipeline and Hierarchical
   Atlas."  NeuroImage, submitted.

   Seidlitz J, Sponheim C, Glen DR, Ye FQ, Saleem KS, Leopold DA,
   Ungerleider L, Messinger A (2018). "A Population MRI Brain Template
   and Analysis Tools for the Macaque." NeuroImage 170: 121–31.
   `<https://doi.org/10.1016/j.neuroimage.2017.04.063>`_.


| For questions, comments and/or suggestions, contact:
| **Adam.Messinger@nih.gov**
| **benjamin.jung@nih.gov**
| **glend@mail.nih.gov**.
