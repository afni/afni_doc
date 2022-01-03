.. _atlas_d99v2:

**Macaque Atlas: D99 v2.0 (current)**
===============================================================================

.. contents:: :local:

.. highlight:: none


Overview
--------

This page describes the **D99 Atlas v2.0: a macaque template and
cortical and subcortical atlas**, as well as how to download it. The
atlas is distributed as a single volume with combined cortical and
subcortical areas.

This is a comprehensive, MRI-histology based atlas of the Rhesus macaque 
monkey brain with segmentation of both cortical and subcortical areas 
in one 3D volume (see related figure below). We mapped a total of 368 
(149 cortical+219 subcortical) regions in this atlas (see suppl Table 1). 
It is important to note that the 219 parcellated "subcortical" regions also 
include non-subcortical regions such as the cerebellar cortex and the 
hippocampal formation. This version 2 of the "D99" template atlas is 
intended for use as a reference standard for macaque neuroanatomical, 
functional, and connectional imaging studies involving both cortical 
and subcortical targets. 

Download
--------------------------

You can download and unpack the updated D99 v2.0 atlas and template in
any of the following ways:

* *(the AFNI way)* **copy+paste**::

    @Install_D99_macaque

* *(the plain Linux-y terminal way)* **copy+paste**::

    wget https://afni.nimh.nih.gov/pub/dist/atlases/macaque/D99_Saleem/D99_v2.0_dist.tgz
    tar -xvf D99_v2.0_dist.tgz

* | *(the mouseclick+ way)* **click here**:
  | `<https://afni.nimh.nih.gov/pub/dist/atlases/macaque/D99_Saleem/D99_v2.0_dist.tgz>`_
  | \.\.\. and then unpack the zipped directory by either clicking on it
    or using the above ``tar`` command.


Contents
------------------

============================= ======================================================================
D99 related files 		          Description
============================= ======================================================================
D99_atlas_v2.0.nii.gz         symmetric atlas of cortical+subcortial regions
D99_template.nii.gz           ex vivo MTR D99 volume template
D99_atlas_v2.0_right.nii.gz   atlas of only right hemisphere
D99_Suppl_Table_1.xlsx        spreadsheet with all 368 areas segmented areas in the atlas
D99_v2.0_labels_semicolon.txt abbreviations of the 368 areas used in this atlas
roilists.txt                  useful lists of label combinations
surfs_right/                  directory of surfaces for right hemisphere
============================= ======================================================================

Example images
------------------

Top row: This updated D99 digital atlas (version 2.0), now with
combined cortical and subcortical segmentation overlaid on the
horizontal, sagittal, and coronal D99 ex-vivo MRI template. The
cross-hairs in these images show the same location of thalamic
subregion VPLc (ventral posterior lateral caudal nucleus) in different
planes of sections. Bottom row: The spatial location of segmented
subcortical regions on the dorsal and lateral views in 3D. The
selected subcortical regions are also indicated with cortical areas in
top row. For the segmentation of cortical areas, see
below. Abbreviations: 9d-dorsal prefrontal area; SCP-superior
cerebellar peduncle; V1-primary visual cortex.  Orientation: D-dorsal;
V-ventral; R-rostral; C-caudal; L-lateral.  Scale bar: 10 mm applies
to R-C top row only.

.. list-table:: 
   :header-rows: 1
   :widths: 100 

   * - D99 digital atlas version 2.0 with combined cortical and subcortical
       segmentation
   * - .. image:: media/D99_v2.0/img_D99_v2.0_fig1.png
   * - .. image:: media/D99_v2.0/img_D99_v2.0_fig2.png

.. list-table:: 
   :header-rows: 1
   :widths: 100 

   * - D99 digital atlas version 2.0 cortical segmentation surfaces
   * - .. image:: media/D99_v2.0/img_D99_v2.0_fig3.png

AFNI environment variables
----------------------------------

The ``@Install_D99_macaque`` command automatically adds AFNI environment variables to use
the D99_v2.0 atlas, but these variables can be configured in your ``~/.afnirc``
file in your home directory to take advantage of the D99 atlas for ``whereami``,
``Show atlas colors`` and ``Go to atlas location`` in the AFNI GUI::

  AFNI_SUPP_ATLAS_DIR = directory_where_you_have_installed_D99v2_atlas
  AFNI_ATLAS_COLORS = Saleem_D99_v2.0
  AFNI_WHEREAMI_DEC_PLACES = 2


Citation/questions
------------------

If you make use of this v2.0 of the D99 atlas, template or
accompanying surfaces in your research, please cite this updated 2021
reference:

   | Saleem KS, Avram AV, Glen D, Yen CC-C, Ye FQ, Komlosh M, Basser
     PJ (2021). High-resolution mapping and digital atlas of
     subcortical regions in the macaque monkey based on matched
     MAP-MRI and histology. Neuroimage 245:118759.
   | `<https://doi.org/10.1016/j.neuroimage.2021.118759>`_

*Note that the cortical or subcortical segmentations and area labels
in this atlas should not be modified or altered.*

For questions, comments and/or suggestions, contact:

  **Kadharbatcha Saleem (CNRM/HJF/NICHD-NIH)**
    | kadharbatcha.saleem.ctr at usuhs.edu
    | saleemks at nih.gov
    | kadsaleem99 at gmail.com

  **Daniel Glen (NIMH, NIH)**
    | glend at mail.nih.gov
 
