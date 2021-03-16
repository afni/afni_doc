.. _stats_decon:

******************************************************
**Deconvolution Analysis of FMRI Time Series Data**
******************************************************

.. contents:: :local:

*These are notes by B. Douglas Ward, written in the Good Ol' Days, and
subsequently updated by Gang Chen.*

Abstract
=========================

Program ``3dDeconvolve`` was developed to provide deconvolution
analysis of FMRI time series data.  This has two primary
applications: (1) estimation of the system impulse response function,
and (2) multiple linear regression analysis of time series data.
Given the input stimulus function(s), and the measured FMRI signal
data, program ``3dDeconvolve`` first estimates the impulse response
time series to yield the estimated response.  Various statistics are
calculated to indicate the "goodness" of the fit.  

The capability of fitting *multiple* stimulus (or reference) waveforms
differentiates program ``3dDeconvolve`` from the cross-correlation
analysis programs (such as AFNI's ``fim`` and ``3dfim``).  Another way
that program ``3dDeconvolve`` differs from the cross-correlation
analysis programs is in the model for the output waveform.  The
cross-correlation programs model the system response as a scaled
version of a fixed waveform (such as a square wave or a sine
wave). Program ``3dDeconvolve`` uses a sum of scaled and time-delayed
versions of the stimulus time series.  The data itself determines
(within limits) teh functional form of the estimated response.  In
fact, the shape of the fitted waveform can vary from voxel to voxel.
Program ``3dDeconvolve`` is described in Section 1.

...

Program ``RSFgen`` is a simple program for generating random stimulus
functions.  This capability may be useful for experimental design, and
the evaluation fo experimental designs.  This program is described in
Section 3.  

The program ``3dConvolve``, as the name implies, performs the inverse
operation of program ``3dDeconvolve``.  That is, program
``3dConvolve`` convolves the input stimulus functions with the given
system impulse response functions, in order to predict the output
measured response.  This program is described in Section 4.

*... [end of excerpt; see below for the full document]*

\.\.\. Full Enlightenment
=========================

| For continued enjoyment of this topic, please see the complete
  document here:
| `Deconvolvem.pdf
  <https://afni.nimh.nih.gov/pub/dist/doc/manual/Deconvolvem.pdf>`_
