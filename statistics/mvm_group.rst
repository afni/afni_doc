.. _stats_mvm_group:

************************************************************
**Multivariate modeling (MVM) approach for group analysis**
************************************************************

.. contents:: :local:

Introduction
============

Program ``3dMVM`` in the AFNI suite is a program that runs FMRI group
analysis with a multivariate modeling approach that can handle
situations with an ANOVA or ANCOVA-style structure. Input files for
``3dMVM`` can be in AFNI, NIfTI, or surface (niml.dset or 1D)
format. If offers a comprehensive and valid approach and avoids the
serious issues that have been plaguing some implementations in the
field (e.g. GLM, flexible factorial design) for a long time.

Why another group analysis program?
====================================

It seems that there are quite a few group analysis programs already in
the AFNI suite: ``3dttest++``, ``3dMEMA``, ``3dANOVAx``, ``GroupAna``,
and ``3dLME``. Theoretically speaking, ``3dLME`` could handle almost
all of the complex situations of FMRI group analysis. However, there
are a couple of thorny issues with the LME approach in practice even
for some relatively simple analyses: flexible but
difficult-to-standardize interface with the underlying R function, and
controversial assignment of degrees of freedom to the testing
statistics. For most experiments typically encountered in FMRI, it
feels like taking a spear to kill a fly when using the LME method to
handle the conventional AN(C)OVA-type data structure. This grey area
between ``3dLME`` and the other AFNI group analysis programs was the
motivation for a new approach: multi-variate modeling.

Written in R, ``3dMVM`` performs the typical ANOVA as well as
ANCOVA. In other words, it can take both categorical and quantitative
variables. More importantly, there is no bound on the number of
explanatory variables that could be incorporated into the
model. Similar to most group analysis programs (and unlike
``3dMEMA``), ``3dMVM`` only takes the effect estimates (no
t-statistics) as input. The approach would avoid some implementation
problems involved in the general linear modeling method popularly
adopted in other packages such as Flexible Factorial Design in SPM and
FEAT in FSL. The technical details can be found in the following
paper:

Chen, G., Adleman, N.E., Saad, Z.S., Leibenluft, E., Cox, R.W. (2014).
Applications of Multivariate Modeling to Neuroimaging Group Analysis:
A Comprehensive Alternative to Univariate General Linear
Model. NeuroImage 99:571-88. 
https://afni.nimh.nih.gov/pub/dist/HBM2014/Chen_in_press.pdf


How is 3dMVM compared to 3dANOVAx?
====================================

**Advantages of 3dANOVAx:**

#. Super fast!

#. You probably already know how to use it.

**Limitations of 3dANOVAx:**

#. Limited to only two explanatory variables.

#. Unequal number of subjects not allowed across groups in ``3dANOVA2``
   and ``3dANOVA3``.

#. Quantitative variables (covariates) not allowed.

#. Sphericity assumption for F-statistic when a within-subject
   (repeated-measures) factor with more than two levels is involved.

**Advantages of 3dMVM:**

#. No limit on the number of explanatory variables.

#. Unequal number of subjects across groups is allowed

#. Quantitative variables (covariates) are allowed.

#. Correction for sphericity violation is possible.

**Limitations of 3dMVM:**

#. Super slow.

If you can analyze your data with ``3dttest++``, ``3dMEMA``, or
``3dANOVAx``, there is no point using ``3dMVM`` unless you're
concerned about sphericity violation whose correction usually
decreases the original t-statistics.

How is 3dMVM compared to GroupAna?
======================================

**Advantages of GroupAna:**

1) Maybe a little faster than ``3dMVM``?

**Limitations of GroupAna:**

1) Have to purchase commercial software Matlab and an expensive
   toolbox Statistics.

2) Limited to four explanatory variables.

3) Quantitative variables (covariates) not allowed.

4) Only pairwise comparisons are available

5) Sphericity assumption for F-statistic when a within-subject
   (repeated-measures) factor with more than two levels is involved.

**Advantages of 3dMVM:**

#. No limit on the number of explanatory variables.

#. Quantitative variables (covariates) are allowed.

#. Correction for sphericity violation is possible.

#. General linear tests are available: weights don't have to add up to
   0!

**Limitations of 3dMVM:**

#. Probably a little slower than GroupAna.

I guess ``GroupAna`` can pretty much retire now into history? Unless
you're too fond of it...

How is 3dMVM compared to 3dLME?
====================================

``3dMVM`` was written to relieve some of the burden from ``3dLME`` so
that the latter would be only used for some really sophisticated
scenarios (not exhaustive here):

#. Group analysis when the BOLD response is modeled with multiple
   basis functions AND when there is one group of subjects under one
   condition.

#.  A within-subject quantitative variable is involved (e.g., separate
    reaction time for each level of condition (positive, neutral, and
    negative)).

#.  Missing data of a within-subject factor.

#.  Subjects are family numbers or twins.


3dMVM usage
============

``3dMVM`` has the standard AFNI-style interface, and most of the usage
information can be found at the terminal::

  3dMVM -help | less

Three examples are also provided in the help. Input files can be in
AFNI, NIfTI, or surface (.niml.dset) format.
