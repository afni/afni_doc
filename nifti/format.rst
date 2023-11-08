
.. _nifti_format:

*****************************************
**The NIFTI format**
*****************************************

.. contents:: :local:

.. _nifti_format_oview:

Overview
========

In the early 2000s, a need was recognized for having a single data
format for MRI that all major software packages could read and write.
To that end, NIfTI (which stands for **N**\euroimaging
**I**\n\ **f**\ormatics **T**\echnology **I**\nitiative) was an
NIH-sponsored working group to promote interoperability of functional
neuroimaging software tools.  

| The NIfTI (or NIFTI) data format is still central to neuroimaging work
  today.  It remains opens to suggestions, while also greatly valuing
  stability as an underlying dependency to a large fraction of software
  analysis tools in the field.  The central NIFTI project GitHub
  repository, for various languages like C, Matlab and Java is here:
| `<https://github.com/NIFTI-Imaging>`_

|

NIfTI and AFNI: working together
======================================

AFNI and NIFTI have a long history of working together:

* AFNI has formally supported NIFTI usage for both input and output
  `since 2005
  <https://nifti.nimh.nih.gov/nifti-1/support/AFNIandNIfTI1>`_.

* | Bob Cox (SSCC, NIMH, NIH, USA), who started AFNI, was the primary
    architect and first author of the NIfTI data format:
  | *Cox RW, Ashburner J, Breman H, Fissell K, Haselgrove C, Holmes CJ,
    Lancaster JL, Rex DE, Smith SM, Woodward JB, Strother SC (2004). 
    (sort of) new image data format standard: NiFTI-1.* `Presented at
    the 10th Annual Meeting of the Organization for Human Brain
    Mapping <https://nifti.nimh.nih.gov/nifti-1/documentation/hbm_nifti_2004.pdf>`_.

* At present (and for many years prior), Rick Reynolds (SSCC, NIMH,
  NIH, USA), also of the AFNI group, has been the central maintainer
  of the publicly available `NIfTI C-library repository on GitHub
  <https://github.com/NIFTI-Imaging/nifti_clib>`_.

|

The NIfTI Data Format Working Group
=======================================

The original Data Format Working Group (DFWG) was comprised of the
following members from the neuroimaging community:

.. list-table:: 
   :header-rows: 0
   :widths: 50 50
   :stub-columns: 0

   * - Robert W Cox
     - SSCC/NIMH/NIH/DHHS/Bethesda
   * - John Ashburner
     - FIL/London
   * - Hester Breman 
     - Brain Innovation/Maastricht
   * - Kate Fissell
     - U Pittsburgh/Pittsburgh
   * - Christian Haselgrove
     - MGH/Charlestown
   * - Colin J Holmes
     - SGI/Mountain
   * - Jack L Lancaster
     - RIC/UTHSCSA/San Antonio
   * - David E Rex
     - LONI/UCLA/Los Angeles
   * - Stephen M Smith
     - FMRIB/Oxford
   * - Jeffrey B Woodward
     - Dartmouth College/Hanover
   * - Stephen C Strother
     - U Minnesota/Minneapolis and NIfTI-DFWG Chair

\.\.\. and Mark Jenkinson of the FMRIB/Oxford is also noted for
contributing mightily to NIfTI-1.

| More information on the background and development notes about 
  NIfTI from the early days can be found here:
| `<https://nifti.nimh.nih.gov/background>`_
| `<https://nifti.nimh.nih.gov/>`_

