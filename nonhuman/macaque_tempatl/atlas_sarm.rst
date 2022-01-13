.. _nh_macaque_atlas_sarm:


**Macaque atlas:  the SARM**
========================================================

   
.. contents:: :local:

.. highlight:: none

Overview
------------------------

Here we present the Subcortical Atlas of the Rhesus Macaque
(SARM).

| This atlas is defined in the coordinates/space of the NMT v2
  template, described here:
| :ref:`nh_macaque_template_nmtv2`.



Contents
----------------------------------

Digitized anatomical atlases are crucial for examining brain structure 
and the functional networks identified by magnetic resonance imaging 
(MRI). To aid in MRI data analysis, we created a complete parcellation 
of the rhesus macaque subcortex using high-resolution ex vivo structural 
imaging and histological data. The structural scan was warped to the NIMH 
Macaque Template (NMT v2), an in vivo population template, where the 
parcellation was refined to produce the Subcortical Atlas of the Rhesus 
Macaque (SARM). The NMT v2 has several forms and variants (based on 
symmetry/asymmetry, FOV and voxel size), and for each of these there is 
an accompanying SARM.

Using an updated version of the Rhesus Monkey Brain in Stereotaxic 
Coordinates  (Paxinos et al., 2009; Paxinos et al., in preparation) for 
guidance, the SARM features 6 parcellation levels, arranged 
hierarchically from fine regions-of-interest (ROIs) to broader composite 
regions, suited for fMRI studies.

The SARM is distributed as a single dataset with six sub-volumes. Note 
that for the purpose of using AFNI sub-brick selectors, SARM Level 1 is 
volume "[0]" and Level 6 is volume "[5]", because AFNI (like Python and 
C) use zero-base counting.

Note that the NMT v2.0 download also includes a CSV table file of the 
ROI labels, hierarchically organized. This can be viewed as a simple 
text file or within any spreadsheet software, such as shown in the 
following image.


Example images
----------------------------------

The following images were made using the symmetric NMT v2 template (with
“standard” spatial resolution = 0.25 mm, and FOV for the SARM atlas) and 
accompanying SARM.

.. list-table:: 
   :header-rows: 1
   :widths: 100 

   * - NMT underlay with the SARM (level 1) overlaid
   * - .. image:: media/sarm/img_nmt2.0symss_sarmL1.axi.png
   * - .. image:: media/sarm/img_nmt2.0symss_sarmL1.cor.png
   * - .. image:: media/sarm/img_nmt2.0symss_sarmL1.sag.png

|

.. list-table:: 
   :header-rows: 1
   :widths: 100 

   * - NMT underlay with the SARM (level 2) overlaid
   * - .. image:: media/sarm/img_nmt2.0symss_sarmL2.axi.png
   * - .. image:: media/sarm/img_nmt2.0symss_sarmL2.cor.png
   * - .. image:: media/sarm/img_nmt2.0symss_sarmL2.sag.png

|

.. list-table:: 
   :header-rows: 1
   :widths: 100 

   * - NMT underlay with the SARM (level 3) overlaid
   * - .. image:: media/sarm/img_nmt2.0symss_sarmL3.axi.png
   * - .. image:: media/sarm/img_nmt2.0symss_sarmL3.cor.png
   * - .. image:: media/sarm/img_nmt2.0symss_sarmL3.sag.png

|

.. list-table:: 
   :header-rows: 1
   :widths: 100 

   * - NMT underlay with the SARM (level 4) overlaid
   * - .. image:: media/sarm/img_nmt2.0symss_sarmL4.axi.png
   * - .. image:: media/sarm/img_nmt2.0symss_sarmL4.cor.png
   * - .. image:: media/sarm/img_nmt2.0symss_sarmL4.sag.png

|

.. list-table:: 
   :header-rows: 1
   :widths: 100 

   * - NMT underlay with the SARM (level 5) overlaid
   * - .. image:: media/sarm/img_nmt2.0symss_sarmL5.axi.png
   * - .. image:: media/sarm/img_nmt2.0symss_sarmL5.cor.png
   * - .. image:: media/sarm/img_nmt2.0symss_sarmL5.sag.png

|

.. list-table:: 
   :header-rows: 1
   :widths: 100 

   * - NMT underlay with the SARM (level 6) overlaid
   * - .. image:: media/sarm/img_nmt2.0symss_sarmL6.axi.png
   * - .. image:: media/sarm/img_nmt2.0symss_sarmL6.cor.png
   * - .. image:: media/sarm/img_nmt2.0symss_sarmL6.sag.png

*The script used to make these images with ``@chauffeur_afni`` is
available here:* :download:`do_view_sarm.tcsh
<media/sarm/do_view_sarm.tcsh>`.

Download
----------------------------------

The SARM is distributed as part of the NMT v2 download using @Install_NMT
(See the instructions for the NMT installation below).

The SARM atlas is available only in the symmetric NMT space.

To download and unpack the datasets together with the NMT template and atlases,
please see these instructions\.\.\.

* \.\.\. here for the **symmetric** form:
  :ref:`nh_macaque_template_nmtv2_sym_dl`

You may download the SARM datasets separately, from the AFNI website
using the links below.
* *(the plain Linux-y terminal way)* **copy+paste**::

    curl -O https://afni.nimh.nih.gov/pub/dist/atlases/macaque/SARM/SARM.tgz
    tar -xvf SARM.tgz

* | *(the mouseclick+ way)* **click on** `this link
    <https://afni.nimh.nih.gov/pub/dist/atlases/macaque/SARM/SARM.tgz>`_,
  | \.\.\. and then unpack the zipped directory by either clicking on it
    or using the above ``tar`` command.

AFNI environment variables
----------------------------------

The @Install_NMT script automatically adds AFNI environment variables to use
the SARM atlas, but these can beThese variables can be configured in your .afnirc
file in your home directory to take advantage of the SARM atlas for "whereami",
"Show atlas colors" and "Go to atlas location" in the AFNI GUI:

| AFNI_SUPP_ATLAS_DIR = directory_where_you_have_installed_atlas/SARM
| AFNI_ATLAS_COLORS = SARM
| AFNI_WHEREAMI_DEC_PLACES = 2

Citation/questions
----------------------------------

If you make use of the SARM in your research, please cite: 

  | Hartig R, Glen D, Jung B, Logothetis NK, Paxinos G,
    Garza-Villarreal EA, Messinger A, Evrard C (2021). "Subcortical
    Atlas of the Rhesus Macaque (SARM) for Magnetic Resonance
    Imaging." NeuroImage, submitted.
  | `<https://www.biorxiv.org/content/10.1101/2020.09.16.300053v1>`_

| For questions, comments and/or suggestions, contact:
| **henry.evrard @ tuebingen.mpg.de**
| **renee.hartig @ tuebingen.mpg.de**
| **adam.messinger @ nih.gov**
| **glend @ mail.nih.gov**

