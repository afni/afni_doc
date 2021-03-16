.. _stats_anova:

******************************************************
**Analysis of Variance (ANOVA)**
******************************************************

.. contents:: :local:

*These are notes by B. Douglas Ward, written in the Good Ol' Days.*

Abstract
===========

This document describes the programs contained within the AFNI
distribution for performing Analysis of Variance on collections of
3-dimensional data sets.  Specifically, programs ``3dANOVA``,
``3dANOVA2``, and ``3dANOVA3`` (for one, two and three factor Analysis
of Variance, respectively) are described herein.


Program 3dANOVA
=========================

Purpose
---------

Program ``3dANOVA`` was developed to perform single-factor analysis of
variance on collections of 3-dimensional data sets, voxel by voxel.
Through the command line inputs, the user specifies which data sets
are to be used in the analysis, and to which factor level they belong.
Various output options are available, including the F-test for
equality of factor level means, estimation of individual factor level
means, estimation of the difference btween two factor level means,
andestimation of contrasts.  The resulting outpu may be stored either
as multiple AFNI 2 sub-brick datasets, or as a single AFNI "bucket"
type dataset.

*... [end of excerpt; see below for the full document]*

\.\.\. Full Enlightenment
=========================

| For continued enjoyment of this topic, please see the complete
  document here:
| `3dANOVA.pdf
  <https://afni.nimh.nih.gov/pub/dist/doc/manual/3dANOVA.pdf>`_
