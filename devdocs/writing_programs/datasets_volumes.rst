.. _wp_datasets_volumes:

===================================
Datasets and Volumes
===================================

.. contents:: In this chapter
   :local:

Everything volumetric in AFNI is a ``THD_3dim_dataset``.  This chapter covers
its structure, how to read and load one, how to reach into its voxel data
(sub-bricks, brick factors, datum types), how to move between voxel indices
and millimeter coordinates, how to restrict work to a mask, and how to build
and write a new dataset.  The running example is again :file:`src/3dToyProg.c`.

The two core structures
=======================

``MRI_IMAGE`` -- one image / brick / vector
-------------------------------------------

``MRI_IMAGE`` (declared in ``mrilib.h``) is AFNI's fundamental n-dimensional
array.  A 1D column, a 2D slice, a 3D volume, and a single dataset sub-brick
are all ``MRI_IMAGE``\ s.  The fields you touch most:

.. code-block:: c

   typedef struct {
      int nx, ny, nz, nt, ... ;   /* dimensions (unused ones are 1) */
      int nxy ;                   /* nx*ny */
      int64_t nvox ;              /* total voxels */
      MRI_TYPE kind ;             /* datum: MRI_byte, MRI_short, MRI_float, ... */
      void *im ;                  /* the actual pixel data (cast by kind) */
      float dx, dy, dz, dt ;      /* physical voxel sizes */
      char *name ;                /* optional label / filename */
   } MRI_IMAGE ;

The datum ``kind`` is one of the ``MRI_TYPE`` enum values (``mrilib.h``):

.. code-block:: c

   typedef enum MRI_TYPE {
      MRI_byte, MRI_short, MRI_int,
      MRI_float, MRI_double, MRI_complex, MRI_rgb, MRI_rgba, ...
   } MRI_TYPE ;

There are helper accessors -- ``MRI_BYTE_PTR(im)``, ``MRI_SHORT_PTR(im)``,
``MRI_FLOAT_PTR(im)``, ``MRI_COMPLEX_PTR(im)`` -- that cast ``im->im`` to the
right pointer type.  ``MRI_TYPE_maxval[kind]`` gives the largest representable
value for a type, which is handy when choosing a scale factor for short
storage (``3dToyProg`` uses ``10.0/MRI_TYPE_maxval[MRI_short]``).

A group of images is an ``MRI_IMARR`` (image array); the ``IMARR_SUBIM(imar,i)``
and ``IMARR_COUNT(imar)`` macros walk it.

``THD_3dim_dataset`` -- a volume plus its header
------------------------------------------------

A ``THD_3dim_dataset`` (declared in ``3ddata.h``) bundles the voxel data (its
``dblk`` datablock, a stack of sub-brick ``MRI_IMAGE``\ s) with all of the
header information: the spatial axes (``daxes``), the time axis (``taxis`` if
any), attributes, labels, and statistics.  You almost never poke its fields
directly -- there is a ``DSET_*`` macro for nearly everything.  The essentials:

.. list-table::
   :header-rows: 1
   :widths: 40 60

   * - Macro
     - Returns
   * - ``DSET_NX(ds)``, ``DSET_NY(ds)``, ``DSET_NZ(ds)``
     - number of voxels along i / j / k
   * - ``DSET_NVOX(ds)``
     - voxels per sub-brick (``nx*ny*nz``)
   * - ``DSET_NVALS(ds)``
     - number of sub-bricks (values per voxel)
   * - ``DSET_NUM_TIMES(ds)``
     - number of time points (1 if not a time series)
   * - ``DSET_TR(ds)``
     - TR / time step
   * - ``DSET_PREFIX(ds)``
     - the output prefix string
   * - ``DSET_HEADNAME(ds)``
     - full path of the ``.HEAD`` file
   * - ``DSET_BRICK(ds,iv)``
     - the ``iv``-th sub-brick as an ``MRI_IMAGE *``
   * - ``DSET_ARRAY(ds,iv)``
     - raw ``void *`` data pointer of sub-brick ``iv``
   * - ``DSET_BRICK_TYPE(ds,iv)``
     - ``MRI_TYPE`` of sub-brick ``iv``
   * - ``DSET_BRICK_FACTOR(ds,iv)``
     - scale factor of sub-brick ``iv`` (0 means 1.0)

Note the axis ordering convention: **datasets are stored space-first**
(x fastest, then y, then z, then sub-brick), whereas the ``MRI_vectim``
structure discussed in :ref:`wp_cookbook` is time-first.  Keep that straight
when you convert between them.

Reading a dataset from disk
===========================

Two steps: open the header, then load the voxel data.

.. code-block:: c

   THD_3dim_dataset *dset = THD_open_dataset( fname ) ;   /* header only */
   if( dset == NULL ) ERROR_exit("Cannot open %s", fname) ;
   DSET_mallocize(dset) ;    /* force malloc (vs mmap) so you can modify */
   DSET_load(dset) ;         /* actually read the bricks into memory */

* :func:`THD_open_dataset` accepts every AFNI-recognized name form:
  ``dset+orig``, ``dset.nii.gz``, ``dset.HEAD``, a NIFTI file, and even
  sub-brick / index selectors like ``dset+orig'[0..3]'`` or
  ``dset+orig'[2,5]'``.  It reads only the header.
* ``DSET_load(dset)`` is a thin macro over ``THD_load_datablock`` that reads
  (or memory-maps) the actual voxel values.  Until you call it,
  ``DSET_ARRAY`` returns ``NULL``.
* ``DSET_mallocize(dset)`` requests that the data be ``malloc``-ed rather than
  ``mmap``-ed; do this if you intend to modify the voxels in place.
* When you are done, ``DSET_unload(dset)`` frees the voxel data but keeps the
  header; ``DSET_delete(dset)`` frees everything.

This exact open/mallocize/load sequence is what :file:`src/3dToyProg.c` uses
for its ``-input`` dataset, and what essentially every ``3d*`` program uses.

Reaching into the voxel data
============================

Sub-bricks, datum types, and brick factors
-------------------------------------------

A dataset holds ``DSET_NVALS(ds)`` sub-bricks, each a separately typed and
separately scaled volume.  A sub-brick can be ``MRI_byte``, ``MRI_short``,
``MRI_float`` (etc.), and it may carry a **brick factor**: the true value of a
voxel is ``stored_value * DSET_BRICK_FACTOR(ds,iv)`` (a factor of 0 is treated
as 1.0).  This is how AFNI stores, say, correlation coefficients compactly as
scaled shorts.

Because of the per-brick type and factor, the safe way to read voxel values is
almost never to walk ``DSET_ARRAY`` yourself.  Instead, ask for the data as
scaled floats:

.. code-block:: c

   /* one whole sub-brick as float[nvox], factor already applied: */
   float *sb = THD_extract_to_float( iv, dset ) ;
   ...
   free(sb) ;

:func:`THD_extract_to_float` allocates ``DSET_NVOX(dset)`` floats, applies the
brick factor, and hands you a clean float volume regardless of on-disk type.
This is the pattern in ``Volumewise_Operations()`` of :file:`src/3dToyProg.c`,
which accumulates a sum and a transform across all sub-bricks.

If you really do want the raw pointer (for speed, when you know the type), use
``DSET_ARRAY(ds,iv)`` and remember to honor ``DSET_BRICK_FACTOR`` yourself.

Extracting a voxel time series
------------------------------

The complement of "one brick across all voxels" is "one voxel across all
bricks" -- i.e. a time series.  Given a 1D voxel index ``nijk``:

.. code-block:: c

   float *far = (float *)calloc( DSET_NVALS(dset), sizeof(float) ) ;
   if( THD_extract_float_array( nijk, dset, far ) == -1 )
      ERROR_message("bad voxel %d", nijk) ;

or, allocating an ``MRI_IMAGE`` for you:

.. code-block:: c

   MRI_IMAGE *tsim = THD_extract_series( nijk, dset, 0 ) ;   /* 0 = scaled */
   float     *ts   = MRI_FLOAT_PTR(tsim) ;

:func:`THD_extract_series` (the third argument is a "raw/unscaled" flag) is one
of the most widely used routines in AFNI -- ``3dTcorrelate``, ``3dDetrend``,
``3dDeconvolve``, ``3dTshift``, ``3dToutcount``, ``3ddelay`` and many others
pull their per-voxel time courses this way.  For pushing a time series **into**
a dataset, use :func:`THD_insert_series` (see below).

To read the same set of voxels from many indices efficiently, there is
``THD_extract_many_arrays``; to convert an entire masked dataset to a
time-first ``MRI_vectim`` in one call, use ``THD_dset_to_vectim`` (see
:ref:`wp_cookbook`).

Navigating: voxel indices and mm coordinates
=============================================

AFNI datasets know their real-world geometry.  The ``Dataset_Navigation()``
function in :file:`src/3dToyProg.c` is a compact tour; the key ideas:

**1D index <-> 3D index.** A whole volume is one flat array of length
``DSET_NVOX``.  Convert with:

.. code-block:: c

   int ni  = DSET_NX(dset) ;
   int nij = DSET_NX(dset) * DSET_NY(dset) ;
   int nijk = AFNI_3D_to_1D_index(i, j, k, ni, nij) ;   /* (i,j,k) -> flat */
   AFNI_1D_to_3D_index(nijk, i, j, k, ni, nij) ;         /* flat -> (i,j,k) */

**Voxel (i,j,k) <-> millimeter (x,y,z).** The dataset's
``daxes->ijk_to_dicom_real`` is the 3x4 affine that maps voxel indices to
RAI-DICOM millimeters.  Load it into an augmented 4x4 and multiply:

.. code-block:: c

   float A[4][4], Ai[4][4], I[3], X[3] ;
   MAT44_TO_AFF44(A, dset->daxes->ijk_to_dicom_real) ;
   I[0]=DSET_NX(dset)/2; I[1]=DSET_NY(dset)/2; I[2]=DSET_NZ(dset)/2 ;
   AFF44_MULT_I(X, A, I) ;    /* X = A I  : voxel -> mm RAI */

   AFF44_INV(Ai, A) ;          /* invert */
   AFF44_MULT_I(I, Ai, X) ;    /* I = Ai X : mm -> voxel */

RAI-DICOM orientation means: x increases Right->Left, y Anterior->Posterior,
z Inferior->Superior (so Right, Anterior, and Inferior are the negative
directions).  Datasets may also be **oblique**; the affine handles that
transparently, which is why you should prefer the matrix over hand-rolled
``origin + index*delta`` arithmetic.

Masks
=====

Most analyses restrict computation to brain voxels.  A mask is just a
``byte *`` of length ``DSET_NVOX`` with 1 inside and 0 outside.

**From a user-supplied mask dataset** (the ``-mask`` idiom in
:file:`src/3dToyProg.c`):

.. code-block:: c

   THD_3dim_dataset *mset = THD_open_dataset( argv[++iarg] ) ;
   if( THD_dataset_mismatch(mset, iset) )     /* same grid as data? */
      ERROR_exit("grid mismatch between input and mask") ;
   byte *mask  = THD_makemask( mset, 0, 1.0, -1.0 ) ;  /* brick 0, nonzero */
   int   ncount = THD_countmask( DSET_NVOX(mset), mask ) ;
   if( ncount <= 0 ) ERROR_exit("empty mask") ;
   DSET_delete(mset) ;                                  /* done with it */

``THD_makemask(dset, ivol, bot, top)`` marks voxels whose value is in the
``[bot,top]`` range (the ``bot > top`` form used above means "any nonzero
value").  ``THD_countmask`` reports how many survived.

**Auto-generated from the data** with ``THD_automask(dset)`` -- the same
brain-extraction logic as the ``3dAutomask`` program, reused by dozens of
tools (``3dAllineate``, ``3dBandpass``, ``3dBlurToFWHM``, ``3dTcorrelate`` ...).

Creating a dataset from scratch
===============================

``New_Dataset_From_Scratch()`` in :file:`src/3dToyProg.c` shows the full
pattern.  Build the grid, declare the axes, allocate the bricks, fill them.

**1. The grid.** :func:`EDIT_geometry_constructor` builds an empty dataset from
a compact geometry string:

.. code-block:: c

   /* RAI:D: nx,xorg,dx, ny,yorg,dy, nz,zorg,dz  */
   THD_3dim_dataset *oset =
      EDIT_geometry_constructor("RAI:D:32,-12.7,6.0, 32,2.3,6.0, 10,-4.5,5.2",
                                prefix) ;

For an oblique grid you can instead pass a full 3x4 index-to-mm matrix:
``"MATRIX(a11,...,a34):nx,ny,nz"``.

**2. Declare what the dataset holds** with the variadic
:func:`EDIT_dset_items`.  It takes ``ADN_*`` key / value pairs and must end
with ``ADN_none``:

.. code-block:: c

   EDIT_dset_items( oset ,
      ADN_datum_all , MRI_short ,      /* storage type of all bricks */
      ADN_nvals     , 100 ,            /* number of sub-bricks       */
      ADN_ntt       , 100 ,            /* number of time points      */
      ADN_ttdel     , 2.0 ,            /* TR                         */
      ADN_tunits    , UNITS_SEC_TYPE ,
      ADN_prefix    , "my_output" ,
      ADN_none ) ;

Common keys: ``ADN_prefix``, ``ADN_datum_all``, ``ADN_nvals``, ``ADN_ntt``
(time points), ``ADN_ttdel`` (TR), ``ADN_tunits``, ``ADN_type`` /
``ADN_func_type``.  If you set ``ADN_ntt`` to 0 the dataset is a bucket (no
time axis) rather than a time series.

**3. Allocate and fill the bricks.**

.. code-block:: c

   for( tt=0 ; tt < nvals ; tt++ ){
      EDIT_substitute_brick(oset, tt, MRI_short, NULL) ;  /* NULL => allocate */
      EDIT_BRICK_FACTOR(oset, tt, 10.0/MRI_TYPE_maxval[MRI_short]) ;
   }
   /* push a float time series into flat voxel nijk, converting to storage type */
   THD_insert_series(nijk, oset, nvals, MRI_float, ts, 0) ;

``EDIT_substitute_brick(ds, iv, type, ptr)`` installs a data pointer as
sub-brick ``iv`` (pass ``NULL`` to have it allocated for you).  The final
argument of :func:`THD_insert_series` is a "already-scaled" flag: 0 means
"scale my floats to the brick's storage type", which is what you want when the
target is a scaled ``short``.

Deriving a new dataset from an existing one
===========================================

More often you already have an input dataset and want an output on the *same*
grid.  ``EDIT_empty_copy`` clones the header (geometry, orientation) but no
data, then you attach your results.  From ``Volumewise_Operations()`` in
:file:`src/3dToyProg.c`:

.. code-block:: c

   THD_3dim_dataset *oset = EDIT_empty_copy( dset ) ;
   EDIT_dset_items( oset ,
      ADN_prefix , outname ,
      ADN_datum_all , MRI_float ,
      ADN_nvals , 2 , ADN_ntt , 0 ,      /* 2-brick bucket */
      ADN_none ) ;

   /* attach already-computed float volumes directly (no copy, no scaling): */
   EDIT_substitute_brick( oset, 0, MRI_float, vout ) ; vout = NULL ;
   EDIT_substitute_brick( oset, 1, MRI_float, yout ) ; yout = NULL ;

   /* or store as scaled shorts, letting AFNI pick the factor (-1.0): */
   EDIT_substscale_brick( oset, 0, MRI_float, vout, MRI_short, -1.0 ) ;
   free(vout) ;

Two important subtleties, both called out in the toy program's comments:

* ``EDIT_substitute_brick`` **takes ownership of your pointer** when the types
  match -- do not ``free`` it afterward (set your copy to ``NULL``).
* ``EDIT_substscale_brick`` **copies** the data (converting/scaling into the
  storage type), so you must ``free`` your original buffer.  Passing a scale of
  ``-1.0`` asks AFNI to compute a sensible auto-scale factor.

Label your outputs and, if useful, attach custom header attributes:

.. code-block:: c

   EDIT_BRICK_LABEL(oset, 0, "sum") ;
   EDIT_BRICK_LABEL(oset, 1, "sisqrt") ;

   THD_set_string_atr( oset->dblk, "Pinot_Noir", "sideways" ) ;
   THD_set_int_atr   ( oset->dblk, "Lottery_Numbers", 6, iv6 ) ;
   THD_set_float_atr ( oset->dblk, "PI", 1, &fv ) ;

(Custom "private" attributes are not preserved when the dataset is later
copied by other programs -- use them for your own round-trips, not as a
long-term storage contract.)

The voxel-wise convenience engine
=================================

For the very common "run a function on every voxel's time series and write the
result" pattern, you do not need to write the triple loop yourself.
``MAKER_4D_to_typed_fbuc`` (and its siblings) walk the dataset, hand your
callback each voxel's (optionally detrended) time series, and assemble the
output bucket.  From ``Voxelwise_Operations()`` in :file:`src/3dToyProg.c`:

.. code-block:: c

   oset = MAKER_4D_to_typed_fbuc(
            dset,               /* input dataset                       */
            outprefix,          /* output prefix                       */
            MRI_short,          /* output datum                        */
            0,                  /* time points to skip at start        */
            1,                  /* 1 => pass a linearly detrended series*/
            2,                  /* number of output values per voxel   */
            (generic_func *)toy_tsfunc,  /* your per-voxel callback     */
            (void *)&ud,        /* user data handed to the callback    */
            voxmask,            /* byte mask (NULL = all voxels)       */
            0 ) ;               /* allow auto-scaling of output        */

Your callback has a fixed prototype and is also called once at the start and
once at the end (with ``val == NULL``) so you can allocate and free scratch
space:

.. code-block:: c

   static void toy_tsfunc( double tzero, double tdelta,
                           int npts, float ts[],
                           double ts_mean, double ts_slope,
                           void *ud, int nbriks, float *val )
   {
      if( val == NULL ){                 /* start (npts>0) / end (npts<=0) */
         ...allocate or free scratch...
         return ;
      }
      /* ts[0..npts-1] is this voxel's series; write nbriks results to val[] */
   }

This is the same engine behind ``3dTfilter``, ``3dTnorm``, ``3dPeriodogram``,
``3dDWItoDT``, ``3dRetinoPhase`` and others -- a good thing to reach for
before hand-writing voxel loops.

Writing the result
==================

Finally, stamp history and write (with the overwrite guard from
:ref:`wp_intro`):

.. code-block:: c

   tross_Copy_History( iset, oset ) ;
   tross_Make_History( "3dProgName", argc, argv, oset ) ;
   if( !THD_ok_overwrite() && THD_is_ondisk(DSET_HEADNAME(oset)) )
      ERROR_message("Output %s already exists", DSET_HEADNAME(oset)) ;
   else
      DSET_write(oset) ;
   DSET_delete(oset) ;

The output format follows the prefix: ``foo+orig`` writes BRIK/HEAD,
``foo.nii.gz`` writes gzipped NIFTI, and so on -- you do not special-case it.
