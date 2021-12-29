.. _atlas_saleem_v2:

**D99 Atlas v2.0: Macaque template and cortical and subcortical atlas**
===============================================================================

**D99 Atlas v2.0: Macaque template and cortical and subcortical atlas**


.. contents:: :local:

.. highlight:: none


Overview
--------

This is a comprehensive MRI-histology based atlas of Rhesus macaque 
monkey brain with segmentation of both cortical and subcortical areas 
in one 3D volume (see related figure below). We mapped a total of 368 
(149 cortical+219 subcortical) regions in this atlas (see suppl Table 1). 
It is important to note that the 219 parcellated subcortical regions also 
include the non-subcortical regions such as the cerebellar cortex and the 
hippocampal formation. This version 2 of the "D99" template atlas is 
intended for use as a reference standard for macaque neuroanatomical, 
functional, and connectional imaging studies involving both cortical 
and subcortical targets. 

Download
--------------------------

The updated D99 atlas and template files are available either through
this link or by using the ``@Install_D99_macaque`` command if AFNI is
already installed on your system::

   @Install_D99_macaque

| To download and unpack the datasets from the direct link,
| `<https://afni.nimh.nih.gov/pub/dist/atlases/macaque/D99_Saleem/D99_v2.0_dist.tgz>`_

**(Atlas is a single volume with combined cortical and subcortical areas)**

You may download the D99 datasets from the AFNI website
using the links below.
* *(the plain Linux-y terminal way)* **copy+paste**::

    wget https://afni.nimh.nih.gov/pub/dist/atlases/macaque/D99_Saleem/D99_v2.0_dist.tgz
    tar -xvf D99_v2.0_dist.tgz

* | *(the mouseclick+ way)* **click on** `this link
    <https://afni.nimh.nih.gov/pub/dist/atlases/macaque/D99_Saleem/D99_v2.0_dist.tgz>`_,
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
surfs_right                   surfaces for right hemisphere
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

   * - D99 digital atlas version 2.0 cortical segmentation surfaces
   * - .. image:: media/D99_v2.0/img_D99_v2.0_fig3.png

AFNI environment variables
----------------------------------

The @Install_D99_macaque script automatically adds AFNI environment variables to use
the D99_v2.0 atlas, but these can be these variables can be configured in your .afnirc
file in your home directory to take advantage of the D99 atlas for "whereami",
"Show atlas colors" and "Go to atlas location" in the AFNI GUI:

| AFNI_SUPP_ATLAS_DIR = directory_where_you_have_installed_atlas/SARM
| AFNI_ATLAS_COLORS = Saleem_D99_v2.0
| AFNI_WHEREAMI_DEC_PLACES = 2


Citation/questions
------------------

If you make use of this version 2 of the D99 atlas, template or
accompanying surfaces in your research, please cite this updated 2021
version:

   | Kadharbatcha S Saleem, Alexandru V Avram, Daniel Glen, Cecil  
     Chern-Chyi Yen, Frank Q Ye, Michal Komlosh and Peter J Basser,
     "High-resolution mapping and digital atlas of subcortical regions
     in the macaque monkey based on matched MAP-MRI and histology."
     Neuroimage, Dec 2021.
   | `<https://doi.org/10.1016/j.neuroimage.2021.118759>`_

**Note that the cortical or subcortical  segmentations and area labels 
in this atlas should not be modified or altered.**

For questions, comments and/or suggestions, contact:

  Kadharbatcha Saleem, CNRM/HJF/NICHD-NIH 
    | **kadharbatcha.saleem.ctr at usuhs.edu**
    | **saleemks at nih.gov**
    | **kadsaleem99 at gmail.com**

  Daniel Glen, NIMH 
    | **glend at mail.nih.gov**
 
