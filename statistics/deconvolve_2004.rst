.. _stats_decon2004:

******************************************************
**Some 3dDeconvolve Notes**
******************************************************

.. contents:: :local:

Overview
==========

These are notes by Bob Cox, from the great 3dDeconvolve Upgrades
of 2004. This page contains notes on various features added in that
happy time.

Sections below will contain comments on underlying algorithms, option
usage, and other words of wisdom that might be useful.

.. _stats_decon2004_svd:

SVD for X-matrix pseudoinverse
=================================================

Gaussian elimination on the normal equations of X has been replaced by
using the SVD to compute the X matrix pseudoinverse. This can be
disabled using the ``-nosvd`` option. If the SVD solution is on, then
all-zero -stim_file functions will NOT be removed from the analysis
(unlike the "-nosvd" analysis).

The reason for not removing the all-zero regressors is so that GLTs
and other scripts that require knowing where various results are in
the output can still function.

* One plausible case that can give all-zero regressors: a task with
  "correct" and "incorrect" results, you analyze these cases
  separately, but some subjects are so good they don't have any
  incorrect responses.

The SVD solution will set the coefficient and statistics for an
all-zero regressor to zero.

If two identical (nonzero) regressors are input, the program will
complain but continue the analysis. In this case, each one would get
half the coefficient, which only seems fair. However, your
interpretation of such cases should be made with caution.

For those of you who aren't mathematicians: the SVD solution basically
creates the orthgonal principal components of the columns of the X
matrix (the baseline and stimulus regressors), and then uses those to
solve the linear system of equations in each voxel.


X-matrix condition numbers
====================================

The X matrix condition number is now computed and printed. This can be
disabled using the ``-nocond`` option. As a rough guide, if the matrix
condition number is about 10^p, then roundoff errors will cause about p
decimal places of accuracy to be lost in the calculation of the
regression parameter estimates. In double precision, a condition
number more than 10^7 would be worrying. In single precision, more than
1000 would be cause for concern. Note that if Gaussian elimination is
used, then the effective condition number is squared (twice as bad in
terms of lost decimal places); this is why the SVD solution was
implemented.

The condition number is the ratio of the largest to the smallest
singular value of X. If Gaussian elimination is used (``-nosvd``; see
:ref:`here <stats_decon2004_svd>`), then this ratio is squared.


.. comment: this factoid no longer applies at all, because we don't
   build+distribute 3dDeconvolve_f anymore

   Use of ``3dDeconvolve_f`` (single precision program) now requires
   "informed consent" from the user, indicated by putting the option
   "-OK" first on the command line. This is because roundoff error can
   cause big errors in single precision if the matrix condition number
   is over 1000.
