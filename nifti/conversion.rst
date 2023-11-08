
.. _nifti_usage:

*****************************************
**Using NIFTI data in AFNI**
*****************************************

.. contents:: :local:

.. _nifti_usage_oview:

Overview
========

The TL;DR of this section is that it is easy to use NIFTI data in AFNI
processing:

#. Nearly all AFNI programs use NIFTI and BRIK/HEAD file formats
   interchangeably.

#. All volume-processing programs accept NIFTIs as inputs---just use
   them directly.

#. For most AFNI programs, you can just include ``.nii`` or ``.nii.gz``
   on the output filename to output a NIFTI volume.

#. If you do need to convert to/from NIFTI, that is easy to do with
   ``3dcopy`` or several other programs.

|

.. _nifti_usage_inp:

Input NIFTI datasets to AFNI programs
=======================================

Simply put, **wherever you input a volumetric dataset to an AFNI
program, you can just provide a NIFTI volume.** That is, programs read
in NIFTI or BRIK/HEAD datasets equivalently.

This applies to ``afni_proc.py``, ``3dttest++``, ``3dcalc``, and
basically every volumetric-processing program (e.g., see :ref:`here
<programs_main>` and :ref:`here <edu_class_prog>`).  For example:

* Create a mask::

    3dAutomask                                                             \
        -prefix  MASK                                                      \
        DSET.nii.gz

* Multiply two datasets (one or both inputs could be NIFTI here)::

    3dcalc                                                                 \
        -a       DSET_A.nii.gz                                             \
        -b       DSET_B+orig.HEAD                                          \
        -expr    'a*b'                                                     \
        -prefix  DSET_OUT

* Calculate voxelwise statistics::

    3dTstat                                                                \
        -median                                                            \
        -prefix  OUTPUT_MED                                                \
        DSET_4D.nii.gz

\.\.\. and so very many more.

.. _nifti_usage_out:

Output NIFTI datasets from AFNI programs
==========================================

For the vast majority of AFNI programs that output a volumetric
dataset, **whenever you specify the output name, simply put ``.nii``
or ``.nii.gz`` on the end of it, and the output will be in NIFTI
format.** There are also a couple programs that have a separate option
used to specify having NIFTI format. For example:

* Create a mask::

    3dAutomask                                                             \
        -prefix  MASK.nii.gz                                               \
        DSET.nii.gz

* Multiply two datasets (one or both inputs could be NIFTI here)::

    3dcalc                                                                 \
        -a       DSET_A.nii.gz                                             \
        -b       DSET_B+orig.HEAD                                          \
        -expr    'a*b'                                                     \
        -prefix  DSET_OUT.nii

* Calculate voxelwise statistics::

    3dTstat                                                                \
        -median                                                            \
        -prefix  OUTPUT_MED.nii.gz                                         \
        DSET_4D.nii.gz

* Threshold a continuous-valued dataset and output ROI maps, where
  each ROI is inflated a bit but in a way to not spread far into white
  matter (*NB:* this program requires the `-nifti` option to output
  volumes in NIFTI format)::

    3dROIMaker                                                             \
        -inset             CORR_VALUES.nii                                 \
        -thresh            0.6                                             \
        -volthr            100                                             \
        -inflate           2                                               \
        -wm_skel           WM_T1+orig.                                     \
        -skel_stop_strict                                                  \
        -prefix            ROI_MAP                                         \
        -nifti

\.\.\. and many, many more.  If you don't add one of those file
extensions, then AFNI programs by default will output the volume(s) in
BRIK/HEAD.  But you could just convert that to NIFTI directly then,
anyways.

Note that a couple "higher level" wrapper programs do *not* output
NIFTIs directly. The FMRI pipeline-generating program ``afni_proc.py``
is one of these.  Once can just convert the desired volumes of
interest to NIFTI volumes directly.

.. _nifti_usage_convto:

Convert BRIK/HEAD -> NIFTI
===============================

There are many ways to do this, which are fairly equivalent. We
mention a few approaches, because they might have additionally useful
functionality at the same time.

**3dcopy.** This is the simplest approach::

  3dcopy DSET DSET.nii.gz

**3dAFNItoNIFTI.** Another simple approach with short syntax, but one
that will adapt any BRIK/HEAD file with multiple scale factors to
having just one for the NIFTI file (and there are a few other options
regarding header adjustments)::

  3dAFNItoNIFTI -prefix DSET.nii.gz DSET

**3dcalc.** This might be useful if you also want to specify the data
type, for example, but that is not necessary::

  3dcalc -a DSET -expr 'a' -prefix DSET.nii -datum float

\.\.\. and can also add subbrick/subvolume selectors::
     
  3dcalc -a DSET"[0..4,7,10-14]" -expr 'a' -prefix DSET.nii -datum float

**3dTcat.** If you want to combine multiple volumes to a single NIFTI::

  3dTcat -prefix DSET_COMBO.nii.gz DSET1+orig DSET2+orig DSET3+orig ...

**3dresample.** If you want to alter header information (that is
assumed to be correct at present)::

  3dresample -prefix DSET_NEW.nii.gz -orient RAI -input DSET+tlrc

  3dresample                                                             \
      -prefix DSET_NEW.nii.gz                                            \
      -master MNI152_2009_template_SSW.nii.gz                            \
      -input  DSET+tlrc

\.\.\. and several others.


.. _nifti_usage_convfrom:

Convert NIFTI -> BRIK/HEAD
=============================

Pretty much each of the programs in the :ref:`nifti_usage_convto`
section apply here, and you would simply not put an extension on the
output dataset name.  So, for example:


**3dcopy.** This is the simplest approach::

  3dcopy DSET.nii DSET

\.\.\. etc.
