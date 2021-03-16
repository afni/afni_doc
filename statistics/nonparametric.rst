.. _stats_nonparametric:

******************************************************
**Nonparametric Statistical Analysis of FMRI Data**
******************************************************

.. contents:: :local:

*These are notes by B. Douglas Ward, written in the Good Ol' Days.*

Abstract
===========

Parametric statistical analysis programs such as ``3dttest`` and
``3dANOVA`` assume that the underlying populations (of voxel
intensities) have a normal (or near normal) distribution.  There are
two reasons why one might prefer to use a nonparametric statistical
analysis: 1) The population in question may differ significantly from
the normal distribution. 2) Nonparametric statistical analysis
techniques are usually less sensitive to the presence of "outliers",
i.e., they are more robust.  Therefore, to provide the user with this
option, the current distribution of AFNI includes four nonparametric
analysis programs: ``3dMannWhitney``, ``3dWilcoxon``,
``3dKruskalWallis``, and ``3dFriedman``.  This set of programs is
intended to provide the capability to perfom nonparametric statistical
analysis of FMRI data, roughly corresponding to the present (\* *well,
note that "present" here is in the 90s*) capability to perform
parametric statistical analysis.

Section 1 describes Program ``3dMannWhitney``, for the comparison of
two treatments (two samples).  This program performs the
Wilcoxon-Mann-Whitney rank-sum test on two groups of 3D datasets,
voxel-by-voxel, to determine if the two samples are from the same
population.  Program otuput includes an estimate fo the treatment
effect, as well as the normalized Wilcoxon rank-sum statistic, for
each voxel.

Section 2 describes Program ``3dWilcoxon``, for the paired comparison
of two treatments.  This program performs the Wilcoxon signed-rank
test for pairs of 3D datasets.  Output includes an estimate for the
treatment effect, and the normalized Wilcoxon signed-rank statistic,
for each voxel.

Section 3 describes Program ``3dKruskalWallis``, for comparing
mulitple treatments.  This program performs the Kruskal-Wallis test to
determin if any of *k* treatments (*k* groups of 3D datasets) are
statistically different, on a voxel-by-voxel basis.  Output includes
the index of the best (highest ranking) treatment, as well as the
Kruskal-Wallis chi-square statistic, for each voxel.

Section 4 describes Program ``3DFriedman``, which compares blocked
multiple treatments.  This program performs the Friedman test for
randomized block designs, on a voxel-by-voxel basis.  Output includes
the index of the best (highest ranking) treatment, as well as the
Friedman chi-square statistic, for each voxel.

*... [end of excerpt; see below for the full document]*

\.\.\. Full Enlightenment
=========================

| For continued enjoyment of this topic, please see the complete
  document here:
| `Nonparametric.pdf
  <https://afni.nimh.nih.gov/pub/dist/doc/manual/Nonparametric.pdf>`_
