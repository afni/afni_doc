

.. _tut_afni_gen_files_gen:

******************************************
Using volumetric (and other) files in AFNI
******************************************

.. contents:: :local:

.. highlight:: Tcsh

NB: most of the shell syntax here applies equally to common shells
such as ``tcsh``, ``bash``, ``zsh``, etc.  We typically default to
``tcsh`` syntax, such as for defining variables::
  
  set var = 10

The user can translate these aspects to ``bash``::

  var=10

\.\.\. or to other shells.  The AFNI functionality applies
equivalently.


.. _tut_afni_data_files_gen_fly:

'On-the-Fly' datasets: general syntax
==============================================

Most AFNI programs can take as input datasets that are modified in
various ways as they are read in. The methods for specifying such
datasets are described below.

They all use special characters such as ``$``, ``( ... )``, ``[...]``,
and ``<...>``.  Within a given set of brackets (and we discuss what
each kind does, below), you can specify: 

* comma-separated lists: ``0,10,15``, ``0,2,4,1,3,5``, etc.

* intervals separated with ``..``: ``0..5``, ``3..15``, etc.  NB: both
  boundaries are *included* in the interval (i.e., closed interval).

* step-sizes within an interval (default step=1): ``0..5(2)``
  (stepsize=2), ``3..15(4)`` (stepsize=4), etc.

* and combinations of the above: ``0..3,5,7..15(3)``, etc.

Note that the indices all start a 0, which is called **zero-base**
counting, such as is used in the C and Python programming languages
(but not in Matlab or R).  There is also a special way to specify "the
last volume", using the ``$`` character (though you might have to
include the ``\`` as an escape character in some contexts, see below).
Thus, ``0..$`` runs from beginning to end.

Many shells interpret the brackets in ways antithetical to AFNI, so
you will have to escape these characters on the command line. This can
be done in different ways:

* You can put the entire dataset plus selection list inside double
  quotes: ``"fred+orig[5..7,9]"``.  

  In this case, other special characters inside the single quotes
  *will* be recognized by the shell, so you could include a variable
  like::

    set nn = 32
    afni elvis+orig"[0..${nn}]"

  If you want to use the ``$`` character to indicate the last
  sub-brick in a dataset (instead of to indicate shell variable
  expansion), then you would have to escape it with the backslash:
  ``'fred+orig[5..7,9..\$]'``.

* You can put the entire dataset plus selection list inside single
  quotes: ``'fred+orig[5..7,9]'``.  

  In this case, other special characters inside the single quotes will
  *not* be recognized by the shell, so you could *not* use other shell
  variables as selectors.  Here, if you want to use the ``$``
  character to indicate the last sub-brick in a dataset you don't need
  to escape it: ``'fred+orig[5..7,9..$]'``.

* You can put single or double quotes around just the selectors, if
  you prefer, such as: ``fred+orig'[5..7,9]'`` or
  ``fred+orig"[5..7,9]"``.  The respective rules of dealing with other
  special characters inside the given quotes still apply, as described
  above.

.. note:: I (who shall remain as nameless as Odysseus in Polyphemus's
          cave) prefer the double quotes when I script, because I am
          often using variables, as well.

          PS: yes, I realize I also just used Odysseus's name there.
          But he spoiled the whole thing for himself as well, innit?

Sub-brick selection: ``[..]``
================================

You can add a sub-brick selection list after the end of the dataset
name. This allows only a subset of the sub-bricks to be read in (by
default, all of a dataset's sub-bricks are input). 

Sub-brick indexes start at 0.  That is, ``[0]`` refers to the first
sub-brick in a dset, and ``[0..20]`` refers to 21 sub-bricks, not
to 20.  You can use the character ``$`` to indicate the last sub-brick
in a dataset. A sub-brick selection list looks like one of the
following forms::

   fred+orig'[5]'            # only sub-brick 5
   fred+orig'[5,9,17]'       # 5, 9, and 17
   fred+orig'[5..8]'         # 5, 6, 7, and 8 (closed interval)
   fred+orig'[5..$]'         # 5 through to the end (closed interval)
   fred+orig'[5..13(2)]'     # 5, 7, 9, 11, and 13 (closed interval, stepsize=2)
   fred+orig'[0..$(3)]'      # every third volume from full range


The sub-bricks are read in the order specified, which may not be the
order in the original dataset. For example, using::

  fred+orig'[0..$(2),1..$(2)]'

\.\.\. will cause the sub-bricks in fred+orig to be input into memory
in an interleaved fashion. 

Using::

  fred+orig'[$..0]'

will reverse the order of the sub-bricks. (It is hard to conceive of
an application for such an ability, but AFNI gives it to you anyway.)

NB: Datasets using sub-brick/sub-range selectors are treated as:

* 3D+time, if the dataset is 3D+time and more than 1 brick is chosen

* Otherwise, as bucket datasets (-abuc or -fbuc) (in particular, fico,
  fitt, etc datasets are converted to fbuc!)


Sub-range selection: ``<..>``
================================

You may also use the syntax ``<a..b>`` after the name of an input
dataset to restrict the range of values read in to the numerical
values in [a, b], which is inclusive. This may be used with/without
the sub-brick selectors.  For example::

  fred+orig'[5..7]<100..200>'

creates a 3 sub-brick dataset, zeroing out values in the original dset
that were less than 100 or greater than 200. If you use the ``<...>``
sub-range selection *without* the ``[...]`` sub-brick selection, it is
the same as if you had put ``'[0..$]'`` in front of the sub-range
selection.

This capability was mostly intended to allow easy extraction of a
sub-mask from a mask dataset containing multiple values, each value
corresponding to a distinct anatomical region.  For example, this::

  ethel+orig'<4,7>'

\.\.\. picks out the ROIs with value 4 or 7 from an atlas (and if
there *wasn't* a value 4 or 7 there, then the output dset will be all
zeros).

If you have labels associated with an ROI, then you can select based
on those.  For example::

  ethel+orig'<Left-Inf-Lat-Vent,Left-Thalamus-Proper>'

\.\.\. picks out the specified ROIs (if they exist in the dset).  **In
general, this provides a much more stable and useful way to select
ROIs from atlases, than using number selection!**

Calculated datasets
======================

Datasets may also be specified as runtime-generated results from
program ``3dcalc``. This type of dataset specifier is enclosed in
quotes, and starts with the string ``'3dcalc('``::

    '3dcalc( opt opt ... opt )'

where each opt is an option to program ``3dcalc`` (and opt must *not*
be in quotes). This program is run to generate a dataset in the
directory given by environment variable TMPDIR (default =
``/tmp``). This dataset is then read into memory, locked in place, and
deleted from disk. For example::

    afni -dset '3dcalc( -a r1+orig -b r2+orig -expr a/b )'

\.\.\. will let you look at the ratio of datasets r1+orig and r2+orig,
without pre-computing it into a disk file you'll have to delete later.
And *do* leave spacing between the opts within the parentheses and the
parentheses themselves.

This option can be particularly useful for computing a mask on-the-fly
from a master dataset, as in::

  3dmaskave                                                   \
      -mask '3dcalc( -a stat+orig[3] -b stat+orig[5] -expr step(a-3.3)*step(b-3.3) )'  \
      fred+orig

NB: using this dataset input method can use lots of memory,
depending on the dsets!


Auto-Tcat datasets
======================

Multiple datasets can be combined in the time dimension by putting
spaces between them, with the whole 'dataset_name' enclosed in quotes
on the command line. For example::

  3dTstat 'a+orig b+orig c+orig'

will compute the mean of each voxel, across 3 datasets and along the
time axis. An alternative way to perform this task would be to create
a temporary dataset::

     3dTcat -prefix ttt a+orig b+orig c+orig

     3dTstat ttt+orig

     \rm -f ttt+orig.*



.. come back to this...

    Datasets on the Web
    =========================

    It is also possible to read datasets across the Web; for example::

      afni                                                       \
          -com 'OPEN_WINDOW axialimage'                          \
          http://afni.nimh.nih.gov/pub/dist/data/TTatlas.nii.gz

    The file(s) are actually fetched to the ``/tmp`` directory, then read
    in from disk, locked into memory (marked as un-purge-able in AFNI),
    and then the files are deleted from ``/tmp``. You cannot use sub-brick
    selectors or other modifiers on such datasets.

Make a volume of arbitary dimensions
=============================================

There is special functionality in ``3dcalc`` to generate a dset of
arbitrary dimensions that contains random numbers (from the uniform
distribution in the range [-1,1]).  This is useful for testing
purposes, and you can change the random numbers into other things, as
well, fairly directly.

If you want to make a :math:`3\times7\times5` volume with 46 time
points, then run::

  3dcalc -a jRandomDataset:3,7,5,46 -expr 'a' -prefix test_00.nii.gz

What properties does it have?  Check out ``3dinfo`` on it:

.. hidden-code-block:: none
   :label: - show header y/n -

   ++ 3dinfo: AFNI version=AFNI_20.3.03 (Dec 21 2020) [64-bit]

   Dataset File:    /home/ptaylor/afni_doc/tutorials/afni_gen/test_00.nii.gz
   Identifier Code: AFN_ykCWh2fr3mL7f-B5d8DtHg  Creation Date: Thu Jan  7 16:18:06 2021
   Template Space:  ORIG
   Dataset Type:    Echo Planar (-epan)
   Byte Order:      LSB_FIRST {assumed} [this CPU native = LSB_FIRST]
   Storage Mode:    NIFTI
   Storage Space:   19,320 (19 thousand) bytes
   Geometry String: "MATRIX(1,0,0,0,0,1,0,0,0,0,1,0):3,7,5"
   Data Axes Tilt:  Plumb
   Data Axes Orientation:
     first  (x) = Right-to-Left
     second (y) = Anterior-to-Posterior
     third  (z) = Inferior-to-Superior   [-orient RAI]
   R-to-L extent:     0.000     -to-     2.000 [L] -step-     1.000 mm [  3 voxels]
   A-to-P extent:     0.000     -to-     6.000 [P] -step-     1.000 mm [  7 voxels]
   I-to-S extent:     0.000     -to-     4.000 [S] -step-     1.000 mm [  5 voxels]
   Number of time steps = 46  Time step = 1.00000none  Origin = 0.00000none
     -- At sub-brick #0 '?' datum type is float:    -0.984937 to      0.998833
     -- At sub-brick #1 '?' datum type is float:    -0.988655 to      0.993098
     -- At sub-brick #2 '?' datum type is float:    -0.998977 to      0.993811
   ** For info on all 46 sub-bricks, use '3dinfo -verb' **

   ----- HISTORY -----
   [ptaylor@porthos: Thu Jan  7 16:18:06 2021] {AFNI_20.3.03:linux_ubuntu_16_64} 3dcalc -a jRandomDataset:3,7,5,46 -expr a -prefix test_00.nii.gz

Notice that the header has has lots of "default" properties that you
would have to set elsewhere, like TR, voxel size, origin, extent,
etc. to be meaningful (if you cared about those).  These could then be
changed or set with ``3drefit``, say. It will have RAI (= DICOM) dset
orientation by default.

If you wanted to make such a dset of constant values (say,
approx. :math:`pi`), then you could run::

  3dcalc -a jRandomDataset:3,7,5,46 -expr '3.14' -prefix test_01.nii.gz

\.\.\. and even from the ``3dinfo`` on that, you will see the ranges
of each brick are [3.14, 3.14].

If you only want a 3D volume, just make the time dimension 1::

  3dcalc -a jRandomDataset:3,7,5,1 -expr '3.14' -prefix test_02.nii.gz

The smallest spatial dimension the dset can have is
:math:`2\times2\times1`.  That is, it must be at least a "plane" of
some kind.

If you have an existing dset and you want to make a copy of the same
size (with matching header info), you could use ``3dcalc``\ 's random
functions.  Consider making a copy of anat+orig.HEAD that is pure
Gaussian noise of mean=0 and stdev=3::

  3dcalc -a anat+orig.HEAD -expr 'gran(0,3)' -prefix test_04.nii.gz

If you wanted this noise added into the input dset, then you could
run::

  3dcalc -a anat+orig.HEAD -expr 'a+gran(0,3)' -prefix test_05.nii.gz

See ``3dcalc``\ 's help for more random distributions.

If you want to make a new dset with a size related to an existing
dset, such as adding or subtracting a few slices, then consider using
``3dZeropad``.  As the program's name implies, it can add slices to a
dset in various ways (by side, symmetrically, evening out...), but
when using negative values of arguments it can also *remove* slices.
Most of the header info should still match the input dset (except for
matrix size, obviously), which can be convenient.
