
.. _nifti_notes:

*********************************************************
**NIFTI and BRIK/HEAD: Similarities and differences**
*********************************************************

.. contents:: :local:

.. _nifti_notes_oview:

Overview
========

The NIFTI format was created to provide a single format for volumetric
neuroimaging data that major software packages could all read and
write.  NIFTI was created in the context of trying to take useful
information from existing formats, and create a realistic+useful
compromise.  In particular, it was meant to upgrade the much older
"ANALYZE 7.5" file format (`*.img/*.hdr`) used by some software, in
particular to remove ambiguity.

There is a large amount of overlap between the BRIK/HEAD and NIFTI
formats, as well as a few differences that are useful to be aware of.
We cover some of these here.

.. note:: The formal name of the format is NIfTI, but we often write
          NIFTI for simplicity of typing.

|

.. _nifti_notes_dh:

One file vs two files
=======================================

Some image formats separate the data (numbers comprising the
volumetric information) and header ("meta" information that allows
data to be realized as grids with physical spacing of mm, etc.) into
separate files.  This means that the data part can be stored in binary
format, while the much smaller header information can simply be
human-readable text.  The former can be zipped/compressed for
efficient disk store, while the latter can then be conveniently
queried or read without the work of unzipping it.  The BRIK/HEAD and
IMG/HDR file formats have this organizational structure.

The NIFTI format is a single file that contains both the data and
header together in a binary-format file. This means the file must be
unzipped to query the header. But this single-file format has the
convenience of only needing to copy around a single file as one works
(as opposed to a data+header pair), also making data directories
easier to read.


.. _nifti_notes_fix_flex:

Minimal/fixed vs flexible headers (and extensions)
====================================================

The NIFTI header fields were designed to be *fixed* and rather
minimal.  That is, the set of items does not change (and they take up
a known number of bytes on the disk), and there is intentionally not a
very large set of them.

| The original list of fields for NIFTI (which is now known as
  NIFTI-1) is shown here:
| `<https://nifti.nimh.nih.gov/nifti-1/documentation/nifti1fields>`_.
| This takes up 348 bytes total.

|

| In 2011, updates were made to create a NIFTI-2 format.  One reason
  was to permit the use of larger datasets, by encoding dimensions
  with 64-bit integers (rather than earlier 16-bit signed
  integers). Some other changes included rearranging the order of
  header fields a bit. There was a public/open discussion of this, and
  the full set of proposed changes was approved; see 
  `here <https://www.nitrc.org/forum/forum.php?thread_id=2070&forum_id=1941>`_
  for a large part of the discussion. In the end, the NIFTI-2 header
  also contains a fixed number of fields, shown here in the 
  ``struct nifti_2_header``:
| `<https://nifti.nimh.nih.gov/pub/dist/doc/nifti2.h>`_.
| This takes up 540 bytes total.

|

| These are also useful webpages (kudos to AM Winkler) for
  descriptions of NIFTI header info:
| Re. NIFTI-1: `<https://brainder.org/2012/09/23/the-nifti-file-format/>`_
| RE. NIFTI-2: `<https://brainder.org/2015/04/03/the-nifti-2-file-format/>`_

|

.. note:: Some updates (such as allowed field values described `here
          <https://www.nitrc.org/forum/forum.php?thread_id=10029&forum_id=1942>`_)
          have also occurred in the ensuing years, so always check the
          most up-to-date documentation, as well.

In contrast, the BRIK/HEAD file headers are more flexible and can
store a larger amount of information directly. While the BRIK/HEAD
fields greatly overlap and directly map onto the smaller set of NIFTI
fields, additional items that AFNI used include:

* space descriptions

* subbrick/subvolume labels, which are useful for knowing what each
  volume is

* statistical information, such as the type of the stat, its degrees
  of freedom, etc.

* flags to use an integer-like colormap when viewing in the GUI
  (useful for ROI maps and atlases)

* multiple scale factors, one per volume

* the accumulated history of commands run on the data, which is useful
  for detailed data provenance

\.\.\. and more.  Many of these pieces of information have been quite
beneficial for assisting visualization and data interpretation.

**Importantly,** even though the NIFTI header format is fixed, it
*does* allow for "extensions" to be included.  This is a means for
storing additional information with the NIFTI dataset (an alternative
that appears to be increasingly used in the field is using a JSON
sidecar with the file).  However, software packages will generally not 
preserve the extension information that they do not formally produce
themselves, which is reasonable enough.  So, users should be aware that
switching between software during an analysis can lead to purging 
of extensions.

When AFNI outputs NIFTI datasets, by default it will include the
contents of what would have been the "HEAD" file an
extension. Therefore, even NIFTI files can contain the useful
information described above (processing history, statistical degrees
of freedom, etc.).  The overlapping content in the NIFTI header and
this extension *should* always agree, particularly when input/output
by AFNI programs.

**A caveat:** Properly managing header information is a major
consideration for software developers.  Users who read in data on
their own and process it on their shown should be very, very careful
to ensure that all header information afterwards remains appropriate.
Often changes to the data mean that header information must be
correspondingly updated, and simply propagating headers is not always
correct.  For examples, changing the type of the data requires a
corresponding header change.  This is a major consideration during
processing, to not introduce subtle errors that are difficult to track
down later.

.. _nifti_notes_qsform:

NIFTI: possible ambiguity in `qform_code` and `sform_code` 
=============================================================

Throughout much of neuroimaging's history, it has been useful to know
whether the given dataset is still in its "original" or "native" space
(or at least only rotated/shifted), or whether it has been
aligned/warped to a template or reference ("standard") space.  There
are different ways to encode this information in headers.

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

   * - value
     - label
     - description
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

Within the BRIK/HEAD format, the information about space is stored in
the header in the ``TEMPLATE_SPACE`` attribute, as well as reflected
in the filename itself as typically either ``+orig`` or ``+tlrc``
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


**Essentially,** the mapping rules are as follows:

* NIFTI ``[qs]form_code`` values of 3, 4 or 5 denote that the dataset
  is in some standard space, and map to BRIK/HEAD view extensions of
  ``+tlrc``.  Furthermore, the latter's ``TEMPLATE_SPACE`` attribute
  can carry more specific naming information about the template, even
  within the Talairach, MNI, IBT, etc. families.

* NIFTI ``[qs]form_code`` values of 0 or 1 denote that the dataset is
  in some original or native coordinate space, and map to BRIK/HEAD
  view extensions of ``+orig``.  The latter's ``TEMPLATE_SPACE`` should
  correspondingly be simply ``ORIG``.

* *If* ``AFNI_NIFTI_VIEW = tlrc``, then NIFTI ``[qs]form_code`` values
  of 2 will be interpreted as representing data in some standard
  space, and map to BRIK/HEAD view extensions of ``+tlrc``; the
  latter's ``TEMPLATE_SPACE`` attribute will be ``TLRC``. But if
  ``AFNI_NIFTI_VIEW = orig``, the dataset will be interpreted as being
  in some native or original coordinate space, and map to BRIK/HEAD
  view extensions of ``+orig`` and ``TEMPLATE_SPACE`` name of ``ORIG``.

Easy, right?


.. note:: As a final sidenote here, there are three methods that can be
          used for mapping the data values to grid coordinates
          (conveniently called Method 1, Method 2 and Method 3).  More
          details of this are provided in the `NIFTI C-library code
          <https://github.com/NIFTI-Imaging/nifti_clib/blob/master/nifti2/nifti1.h>`_,
          but basically: Method 1 is the old way that applies only
          when :math:`qform_code = 0`; Method 2, when
          :math:`qform_code > 0` (and ``quatern_*`` and ``qoffset_*``
          header information is used); and Method 3 when
          :math:`sform_code > 0` (and ``srow_*`` information is used).




