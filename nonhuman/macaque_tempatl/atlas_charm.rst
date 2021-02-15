.. _nh_macaque_atlas_charm:


**Macaque atlas:  the CHARM**
========================================================

*Charm is more valuable than beauty. You can resist beauty, but you
can't resist charm.* --Audrey Tautou

.. note
   
   (Fortunately the CHARM atlas looks good, too!)

.. contents:: :local:

.. highlight:: none

Overview
------------------------

Here we present the Cortical Hierarchy Atlas of the Rhesus Macaque
(CHARM).

| This atlas is defined in the coordinates/space of the NMT v2
  template, described here:
| :ref:`nh_macaque_template_nmtv2`.



Contents
------------------

The CHARM parcellates the macaque cortex at six spatial scales. The
finest level is based on the D99 atlas, while the broadest level forms
four cortical lobes. Between these levels, regions are progressively
grouped to form increasingly large composite structures. This allows
the researcher to choose the appropriate scale of investigation for
their study design and data.

.. list-table:: Example of the CHARM hierarchical structure
   :header-rows: 1
   :widths: 100 

   * - Tree diagram showing successively finer parcellation of the
       inferior temporal cortex (from Jung et al., 2020)
   * - .. image:: media/charm/CHARM_Level_Flow_Orinoco.png

The CHARM is distributed as a single data set with six
sub-volumes. Note that for the purpose of using AFNI sub-brick
selectors, CHARM Level 1 is volume ``"[0]"`` and Level 6 is volume
``"[5]"``, because AFNI (like Python and C) use zero-base counting.

The CHARM is distributed with the NMT v2. The NMT v2 has several forms
and variants (based on symmetry/asymmetry, FOV and voxel size), and
for each of these there is an accompanying CHARM.

Note that the NMT download also includes a CSV table file of the ROI
labels, hierarchically organized.  This can be viewed as a simple text
file or within any spreadsheet software, such as shown in the
following image.

.. list-table:: Snippet of the CHARM hierarchical data table
   :header-rows: 1
   :widths: 100 

   * - Part of the CHARM ROI organizational table text file included
       in NMT download
   * - .. image:: media/charm/img_charm_csvtable.png


Example images
------------------

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

*The script used to make these images with ``@chauffeur_afni`` is
available here:* :download:`do_view_charm.tcsh
<media/charm/do_view_charm.tcsh>`.

Download
------------------

The CHARM is distributed as part of the NMT v2 download. For each
form/variant of the NMT, there is a matching CHARM dataset, as well.

To download and unpack the datasets, please see the instructions\.\.\.

* \.\.\. here for the **symmetric** form:
  :ref:`nh_macaque_template_nmtv2_sym_dl`

* \.\.\. here for the **asymmetric** form:
  :ref:`nh_macaque_template_nmtv2_asym_dl`


Citation/questions
------------------

If you make use of the CHARM and/or accompanying NMT v2 data in your
research, please cite:

   | Jung, B., Taylor, P.A., Seidlitz, J., Sponheim, C., Perkins P.,
     Ungerleider, L.G., Glen, D., Messinger, A. (2020)  "A comprehensive
     macaque fMRI pipeline and hierarchical atlas." NeuroImage, submitted.
   | `<https://www.biorxiv.org/content/10.1101/2020.08.05.237818v1>`_

   | Reveley C, Gruslys A, Ye FQ, Glen D, Samaha J, E Russ B, Saad Z, K
     Seth A, Leopold DA, Saleem KS (2017). Three-Dimensional Digital
     Template Atlas of the Macaque Brain. Cereb Cortex 27(9):4463-4477. 
     doi: 10.1093/cercor/bhw248.
   | `<https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6075609/>`_


| For questions, comments and/or suggestions, contact:
| **Adam.Messinger @ nih.gov**
| **benjamin.jung @ nih.gov**
| **glend @ mail.nih.gov**.
 
