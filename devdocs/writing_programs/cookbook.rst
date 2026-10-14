.. _wp_cookbook:

===================================
The Function Cookbook
===================================

.. contents:: In this chapter
   :local:

A categorized quick-reference to the functions you will reach for most often,
with the signature, what it does, and which shipped programs use it (so you
can read a real caller).  All of these are declared in ``3ddata.h`` /
``mrilib.h`` and available once you ``#include "mrilib.h"``.

Opening, loading, and writing datasets
======================================

.. list-table::
   :header-rows: 1
   :widths: 42 58

   * - Call
     - What it does
   * - ``THD_open_dataset(char *name)``
     - Open a dataset header from any AFNI-recognized name (BRIK/HEAD, NIFTI,
       sub-brick selectors ``'[..]'``).
   * - ``DSET_load(ds)``
     - Read/mmap the voxel data (macro over ``THD_load_datablock``).  Required
       before ``DSET_ARRAY`` is valid.
   * - ``DSET_mallocize(ds)``
     - Force ``malloc`` (not ``mmap``) so you can modify.
   * - ``DSET_unload(ds)``
     - Free voxel data, keep the header.
   * - ``DSET_delete(ds)``
     - Free the whole dataset.
   * - ``DSET_write(ds)``
     - Write to disk; format follows the prefix.
   * - ``THD_ok_overwrite()`` / ``THD_is_ondisk()``
     - Overwrite-guard the write (see :ref:`wp_intro`).
   * - ``EDIT_empty_copy(ds)``
     - Clone header (same grid), no data.
   * - ``EDIT_dset_items(ds, ADN_..., ADN_none)``
     - Set prefix, datum, nvals, TR, type, ...
   * - ``EDIT_geometry_constructor(str, prefix)``
     - Build an empty dataset from a geometry string.

Seen together in :file:`src/3dToyProg.c`; the open/load idiom is in essentially
every ``3d*`` program.

Getting voxel data in and out
=============================

Because sub-bricks are individually typed and scaled, prefer the "give it to me
as float" routines over walking ``DSET_ARRAY`` by hand.

.. list-table::
   :header-rows: 1
   :widths: 46 54

   * - Call
     - What it does
   * - ``THD_extract_to_float(iv, ds)``
     - One sub-brick ``iv`` as ``float[nvox]``, brick factor applied.  Returns
       a new array.
   * - ``THD_extract_series(ijk, ds, raw)``
     - One voxel's time series as an ``MRI_IMAGE`` (``raw=0`` applies scaling).
   * - ``THD_extract_float_array(ijk, ds, far)``
     - One voxel's time series into your ``float far[DSET_NVALS]``.  ``-1`` on
       error.
   * - ``THD_extract_many_arrays(ns, ind, ds, dsar)``
     - Many voxels' series at once.
   * - ``THD_insert_series(ijk, ds, n, type, ptr, scaled)``
     - Write a time series into voxel ``ijk`` (``scaled=0`` => convert to
       storage type).
   * - ``EDIT_substitute_brick(ds, iv, type, ptr)``
     - Install ``ptr`` as sub-brick ``iv`` (takes ownership; ``NULL`` =>
       allocate).
   * - ``EDIT_substscale_brick(ds, iv, styp, ptr, dtyp, f)``
     - Copy+scale ``ptr`` into brick ``iv`` (``f=-1.0`` => auto factor).  You
       still free ``ptr``.

``THD_extract_series`` is one of the most-used routines in the tree --
``3dTcorrelate``, ``3dDetrend``, ``3dDeconvolve``, ``3dTshift``,
``3dToutcount``, ``3ddelay``, ``3dfim+`` all read per-voxel time courses with
it.

Whole-dataset time series: the ``MRI_vectim``
=============================================

When you need *every* in-mask voxel's time series at once, converting the whole
dataset to an ``MRI_vectim`` is far more cache-friendly than repeated
``THD_extract_series`` calls.  A vectim is **time-first** (each voxel's series
is contiguous), the opposite of a dataset's space-first layout.

.. code-block:: c

   MRI_vectim *mv = THD_dset_to_vectim( dset, mask, ignore ) ; /* ignore = pts to skip */
   for( iv=0 ; iv < mv->nvec ; iv++ ){
      float *ts = VECTIM_PTR(mv, iv) ;     /* this voxel's mv->nvals-long series */
      ...
   }
   THD_vectim_normalize(mv) ;              /* L2-normalize each series in place  */
   VECTIM_destroy(mv) ;

``mv->ivec[iv]`` is the 1D voxel index that row ``iv`` came from, so you can map
results back into a dataset.  This structure is the backbone of AFNI's
correlation machinery: ``3dAutoTcorrelate``, ``3dBandpass``, ``3dECM``,
``3dDegreeCentrality``, ``3dLFCD``, ``3dLSS`` and InstaCorr/GroupInCorr all
build a vectim (normalizing it once) and then reduce correlations to dot
products.

Time-series and correlation primitives
=======================================

===============================================  ==============================================
Call                                             What it does
===============================================  ==============================================
``THD_normalize(int n, float *x)``               Normalize ``x[0..n-1]`` to unit L2 norm
                                                 (in place); returns the applied factor
                                                 ``1/norm`` (0 if the series is ~zero).
``THD_vectim_normalize(MRI_vectim *mv)``         Same, applied to every row of a vectim.
``THD_pearson_corr(int n, float *x, float *y)``  Pearson correlation of two series.
``THD_pearson_corrd(int n, double*, double*)``   Double-precision variant.
``THD_pearson_corr_wt(n, x, y, wt)``             Weighted Pearson.
===============================================  ==============================================

If both inputs are already unit-normalized (e.g. from ``THD_vectim_normalize``),
the Pearson correlation is just their dot product -- which is exactly the
shortcut InstaCorr and the ``*Tcorr*`` programs exploit.  For spectral work,
``csfft_cox(sign, nfft, complex_array)`` is the in-place FFT used by
:file:`src/3dToyProg.c`'s ``toy_tsfunc`` and by ``3dPeriodogram``.

Masks and clustering
====================

=================================================  ============================================
Call                                               What it does
=================================================  ============================================
``THD_makemask(ds, ivol, bot, top)``               ``byte[nvox]`` mask of voxels with value in
                                                   ``[bot,top]`` (``bot>top`` => any nonzero).
``THD_automask(ds)``                               Auto brain mask (the ``3dAutomask`` logic).
``THD_countmask(int nvox, byte *mask)``            Count the set voxels.
``THD_dataset_mismatch(ds1, ds2)``                 Nonzero if grids differ (always check a
                                                   ``-mask`` against the data).
=================================================  ============================================

``THD_automask`` is reused by ``3dAllineate``, ``3dBandpass``,
``3dBlurToFWHM``, ``3dBrickStat`` and many more -- prefer it to rolling your
own threshold.

Statistics: p-values and thresholds
===================================

AFNI attaches a **statistic type** and its parameters (degrees of freedom,
etc.) to each sub-brick, so a t-stat brick knows how to become a p-value.  The
type is one of the ``FUNC_*_TYPE`` codes (``3ddata.h``):

=====================  ======  =====================  ============================
Code                   Value   Statistic              Aux parameters needed
=====================  ======  =====================  ============================
``FUNC_COR_TYPE``      2       correlation coeff.     samples, fit, ort params (3)
``FUNC_TT_TYPE``       3       Student t              DOF (1)
``FUNC_FT_TYPE``       4       F                      numerator, denominator DOF (2)
``FUNC_ZT_TYPE``       5       normal / Z             none (0)
``FUNC_CT_TYPE``       6       chi-square             DOF (1)
``FUNC_BT_TYPE``       7       incomplete beta        a, b (2)
``FUNC_BN_TYPE``       8       binomial               ntrial, prob (2)
``FUNC_GT_TYPE``       9       gamma                  shape, scale (2)
``FUNC_PT_TYPE``       10      Poisson                mean (1)
=====================  ======  =====================  ============================

The number of aux parameters per code is the ``FUNC_need_stat_aux[]`` table;
their meaning is ``FUNC_label_stat_aux[]``.

**Convert statistic <-> p-value** (``stataux`` is the parameter array, e.g. a
one-element ``{dof}`` for a t-test):

.. code-block:: c

   float p = THD_stat_to_pval ( stat, FUNC_TT_TYPE, stataux ) ;  /* stat -> p  */
   float t = THD_pval_to_stat ( pval, FUNC_TT_TYPE, stataux ) ;  /* p -> stat  */
   float z = THD_stat_to_zscore( stat, FUNC_TT_TYPE, stataux ) ; /* stat -> Z  */

**Work directly from a dataset sub-brick** -- pull the code and aux from the
header instead of hand-assembling them:

.. code-block:: c

   int    code = DSET_BRICK_STATCODE(dset, iv) ;   /* 0 if not a stat brick */
   float *aux  = DSET_BRICK_STATAUX (dset, iv) ;
   float  p    = THD_stat_to_pval( val, code, aux ) ;

   /* or, the whole thing in one call (rickr, 2023): */
   float thr = THD_volume_pval_to_thresh( dset, iv, 0.001, 1 ) ; /* p -> threshold */

These conversions live in ``thd_statpval.c`` (thin wrappers over the routines
in ``mri_stats.c``) and are used by ``3dFDR``, ``3dClustCount``, ``3dTcorrMap``,
``3dECM`` and the AFNI GUI's threshold slider.

**Tag your own output as a statistic** so downstream tools (and the GUI's
p-value readout) understand it -- use the ``EDIT_BRICK_TO_FI*`` macros:

.. code-block:: c

   EDIT_BRICK_TO_FITT(oset, iv, ndof) ;          /* mark brick iv as t, ndof DOF */
   EDIT_BRICK_TO_FIFT(oset, iv, ndof, ddof) ;    /* F-stat */
   EDIT_BRICK_TO_FICT(oset, iv, ndof) ;          /* chi-square */
   EDIT_BRICK_TO_FIZT(oset, iv) ;                /* Z */
   EDIT_BRICK_TO_NOSTAT(oset, iv) ;              /* clear stat info */

1D (text column) I/O
====================

AFNI's ``.1D`` files (whitespace-delimited columns: regressors, motion
parameters, ROI averages) are read into an ``MRI_IMAGE`` of floats, stored
column-major (``nx`` = rows/time, ``ny`` = columns).

.. code-block:: c

   MRI_IMAGE *im = mri_read_1D( "motion.1D" ) ;   /* also accepts '[..]{..}' selectors */
   if( im == NULL ) ERROR_exit("cannot read 1D") ;
   float *far = MRI_FLOAT_PTR(im) ;
   /* value at row r, column c: */
   float v = far[ r + c*im->nx ] ;
   ...
   mri_write_1D( "out.1D", im ) ;
   mri_free(im) ;

Like dataset names, ``mri_read_1D`` honors selectors -- ``file.1D'[2]'`` for one
column, ``file.1D'[0..3]'`` for a range, and transpose with a trailing ``'``.
Used by ``1dplot``, ``3dDeconvolve`` (regressors), ``1d_tool.py``'s C
companions, and anywhere a program takes a ``-1D`` input.

Provenance and attributes
=========================

======================================================  ======================================
Call                                                    What it does
======================================================  ======================================
``tross_Make_History("prog", argc, argv, ds)``          Append this command to the header log.
``tross_Copy_History(src, dst)``                        Carry the input's history forward.
``EDIT_BRICK_LABEL(ds, iv, "str")``                     Name a sub-brick.
``THD_set_string_atr(ds->dblk, "NAME", "val")``         Attach a custom string attribute.
``THD_set_int_atr`` / ``THD_set_float_atr``             Attach int / float attributes.
======================================================  ======================================

Custom "private" attributes survive a write/read round-trip but are **not**
propagated when another program copies the dataset -- use them for your own
data, not as an interchange contract.

Where to read real callers
==========================

* Dataset creation, navigation, volume/voxel ops, FFT callback:
  :file:`src/3dToyProg.c` (start here).
* ``vectim`` + correlation: :file:`src/3dTcorrelate.c`,
  :file:`src/3dAutoTcorrelate.c`, :file:`src/3dBandpass.c`.
* p-value / statistic conversion: :file:`src/3dFDR.c`,
  :file:`src/thd_statpval.c`.
* NIML over sockets: :file:`src/3dGroupInCorr.c`, :file:`src/plugout_drive.c`.
* Surfaces: :file:`src/SUMA/SUMA_SurfMeasures.c`,
  :file:`src/SUMA/SUMA_3dVol2Surf.c`.
