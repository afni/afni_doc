
.. _nifti_qsform:

**********************************************************************
Space names, ``qform_code`` and ``sform_code``
**********************************************************************

.. contents:: :local:

.. _nifti_qsform_oview:

Overview
========

Throughout much of neuroimaging's history, it has been useful to know
whether the given dataset is still in its "original" or "native" space
(or at least only rotated/shifted), or whether it has been
aligned/warped to a template or reference ("standard") space.  There
are different ways to encode this information in headers.

.. _nifti_qsform_nifti:

NIFTI: ``qform_code`` and ``sform_code``
=============================================================

In NIFTI, the ``qform_code`` and ``sform_code`` values control this.
These are each integer values that hierarchically encode whether the
data are in "original" or in a "template" space---or, confusingly,
whether it is an "arbitrary" space.  The latter ambiguity seems a
particularly unfortunate allowed choice; it was implemented to provide
backwards compatability with the ANALYZE format that some software
used. Unfortunately, such cases specifying an ambiguous space still
get output in some software (NB: this should not happen in AFNI
output).

The currently (as of Nov, 2023) recognized ``qform_code`` and
``sform_code`` scalar values, and their interpretations, are shown in
the following table:

.. list-table:: 
   :header-rows: 1
   :widths: 10 35 55
   :stub-columns: 0

   * - Value
     - Label
     - Description
   * - 0
     - ``NIFTI_XFORM_UNKNOWN``
     - Arbitrary coordinates (Method 1).
   * - 1
     - ``NIFTI_XFORM_SCANNER_ANAT``
     - Scanner-based anatomical coordinates.
   * - 2
     - ``NIFTI_XFORM_ALIGNED_ANAT``
     - Coordinates aligned to another file's, or to anatomical
       "truth". **This is ambiguous as to being in standard space or
       not.**
   * - 3
     - ``NIFTI_XFORM_TALAIRACH``
     - Coordinates aligned to Talairach-Tournoux Atlas; (0,0,0)=AC,
       etc.
   * - 4
     - ``NIFTI_XFORM_MNI_152``
     - MNI 152 normalized coordinates.
   * - 5
     - ``NIFTI_XFORM_TEMPLATE_OTHER``
     - Normalized coordinates (for any general standard template
       space). Added March 8, 2019.

.. note:: Why do we have ``qform_code`` and ``sform_code`` integers?
          In NIFTI, there are three methods that can be used for
          mapping the data values to grid coordinates, and these are
          conveniently called Method 1, Method 2 and Method 3.  More
          details of this are provided in the `NIFTI C-library code
          <https://github.com/NIFTI-Imaging/nifti_clib/blob/master/nifti2/nifti1.h>`_,
          but basically the ``[qs]form_code`` values encode which
          coordinate method should be used: Method 1 is the "old way"
          that applies only when :math:`qform_code = 0`; Method 2 uses
          ``quatern_*`` and ``qoffset_*`` header info and applies when
          :math:`qform_code > 0`; and Method 3 uses ``srow_*`` info
          and applies when :math:`sform_code > 0`.


.. _nifti_qsform_bh:

BRIK/HEAD: space names and mapping to/from NIFTI
===================================================

Within the BRIK/HEAD format, the information about space is stored in
the header in the ``TEMPLATE_SPACE`` attribute.  It is also reflected
in the filename itself, typically as either ``+orig`` or ``+tlrc``
(AFNI's "view extension for the space", seen with ``3dinfo
-av_space``).

* The *view extension* parts of the filename are fairly generic,
  reflecting simply being in native or *some* standard space
  specifically (NB: use of "+tlrc" isn't just restricted to Talairach
  space---that is somewhat a legacy convention from The Old Days when
  there were a very small number of standard spaces).

* In contrast, the ``TEMPLATE_SPACE`` is a more specific space name;
  it encodes a more *specific* version of Talairach (like ``TT_N27``)
  or MNI or IBT or HaskinsPeds or NMT template; and for native space
  data, it is just ``ORIG``.

There is a 1-to-1 mapping between AFNI view extension and the
*unambiguous* ``[qs]form_code`` values, and then some extra
information is necessary to deal with the arbitrary case.  This will
be done by setting the following AFNI environment variable:

``AFNI_NIFTI_VIEW``
    *The default view extension used for output when creating AFNI format
    datasets from NIFTI datasets.This variable is only applicable for
    sform and qform codes that do not have clearly defined views
    (sform/qform code = 2). Set to "tlrc" or "orig". See also
    AFNI_DEFAULT_STD_SPACE and AFNI_NIFTI_PRIORITY. Note sform/qform code=5
    can be used for spaces other than MNI or TLRC including MNI_ANAT or D99
    spaces.*

**Essentially,** the NIFTI-BRIK/HEAD space labeling rules are as
follows:

* NIFTI ``[qs]form_code`` values of 3, 4 or 5 denote that the dataset
  is in some standard space, and map to BRIK/HEAD view extensions of
  ``+tlrc``.  Furthermore, the latter's ``TEMPLATE_SPACE`` attribute
  can carry more specific naming information about the template, even
  within the Talairach, MNI, IBT, etc. families.

* NIFTI ``[qs]form_code`` values of 0 or 1 denote that the dataset is
  in some original or native coordinate space, and map to BRIK/HEAD
  view extensions of ``+orig``.  The latter's ``TEMPLATE_SPACE`` should
  correspondingly be simply ``ORIG``.

* NIFTI ``[qs]form_code`` values of 2 will be interpreted as one of
  the following:

  * *If* ``AFNI_NIFTI_VIEW = tlrc``, they will be treated as
    representing data in some standard space; these would map to
    BRIK/HEAD view extensions of ``+tlrc`` and ``TEMPLATE_SPACE``
    attributes of ``TLRC``.

  * *If* ``AFNI_NIFTI_VIEW = orig``, they will be treated as
    representing data in some native or original coordinate space;
    these would map to BRIK/HEAD view extensions of ``+orig`` and
    ``TEMPLATE_SPACE`` attributes of ``ORIG``.

Easy, right?

.. _nifti_qsform_gui:

GUI visualization, with space considerations
==================================================

Within the AFNI GUI, one cannot overlay a "+orig" dataset on a
"+tlrc" one, and vice versa.  This should generally not cause too much
hassle.  For example, when AFNI programs warp an original space
dataset to a standard space template, the newly-warped output will
pick up the template's space attribute, so they can be overlayed
without woe.

However, a potential difficulty arises when one has a NIFTI dataset
with the ambiguous qform_code or sform_code value of 2, which can
happen in some other software.  AFNI will use the user-specified (or
default) ``AFNI_NIFTI_VIEW`` value to interpret whether such a dataset
should be treated as "+orig" or "+tlrc". The user just needs to make
sure that this environment variable is set appropriately for each of
their use cases.  It is a far, far better thing to not leave the
interpretation to chance, and to change/fix the header ``qform_code``
and ``sform_code`` values directly (using ``nifti_tool`` or
``3drefit``).


.. _nifti_qsform_info:

Get header information
===========================

NIFTI dataset header information can be checked with ``nifti_tool``.
One can display the full header::

  nifti_tool -disp_hdr -infiles DSET

\.\.\. or specific field(s), like the qform_code and sform_code
values::

  nifti_tool -disp_hdr                           \
      -field qform_code -field sform_code        \
      -infiles var.1.scale.r01.nii.gz 



