.. _stats_anova:

*********************************************************************
**Nonlinear Regression Analysis of FMRI Time Series Data (NLfim)**
*********************************************************************

.. contents:: :local:

*These are notes by B. Douglas Ward, written in the Good Ol' Days.*

Abstract
=========================

The cross-correlation coefficient has been used extensively for the
detection of a given "signal" \.\.\. in FMRI time series data.  This
works well when the signal is completely known, or known up to a
scaling constant.  However, if only the functional form of the signal
is known, with the signal itself being a nonlinear function fo several
unknown parameters, then a different approach is required to detect
the presence of the signal buried in noise.

Section 1 describes Program ``3dNLfim``, which was developed to
provide nonlinear regression analysis of 3D+time data sets.  The
nonlinear regression is accomplished by calculating a least squares
fit of the time series data to a user specified model of the
data. Program ``3dNLfim`` makes a separate least squares estimate of
the model parameters for each voxel in the input time series data set.
Program output optinos include an AFNI 'bucket' dataset containing the
estimated model parameters, various other parameters related to the
signal waveform, and the :math:`R^2` and F-statistics for significance
of the nonlinear model at each voxel location.

Section 2 describes Program ``plug_nlfit``, and AFNI "plug-in", which
displays the nonlinear least squares fit of the user specified signal
waveform on top of the actual time series data for voxels of interest.
Program ``plug_nlfit`` is the interactive version of the batch command
program ``3dNLfim``.

Program ``3dTSgen``, whcih is described in Section 3, provides a means
of generating artificial time series data, and storing such data into
an AFNI 3D+time dataset.  The time series data is generated using the
operator specified signal and noise models.  Such artificial time
series data is useful in several ways: 1) Testing of statistical
analysis programs for significance of the result.  2) Calculation of
the statistical power of a test. 3) Design of experiments.

*... [end of excerpt; see below for the full document]*

\.\.\. Full Enlightenment
=========================

| For continued enjoyment of this topic, please see the complete
  document here:
| `3dNLfim.pdf
  <https://afni.nimh.nih.gov/pub/dist/doc/manual/3dNLfim.pdf>`_
