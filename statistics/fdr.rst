.. _stats_fdr:

******************************************************
**False Discovery Rate (FDR)**
******************************************************

.. contents:: :local:

*These are notes by B. Douglas Ward, written in the Good Ol' Days.*


Program 3dFDR
=========================

Purpose
---------

Program ``3dFDR`` implements the False Discovery Rate (FDR) algorithm
for thresholding of voxelwise statistics.  Instead of controlling for
*alpha* (the probabilty of a false positive anywhere in the volume),
the FDR algorithm controls for the proportion of false positives
relative to the number of detections.

Program input consists of a dataset containing one (or more)
statistical sub-bricks.  Output consists of a bucket dataset with one
sub-brick for each input sub-brick.  For non-statistical input
sub-bricks, the output sub-brick is a copy of the input.  However,
statistical input sub-bricks are replaced by the corresponding FDR
values, as follows:

For each voxel, the minimum value of *q* is determined such that

   .. math:: E(FDR) \leq q

leads to rejection of the null hypothesis in that voxel.  Only voxels
inside the user specified mask (optional) will be considered.  These
*q*\ -values are them mapped to *z*\ -scores for compatability with
the AFNI statistical threshold display, i.e., 

   .. math:: {\rm input~stat} \rightarrow p \mbox{-value} \rightarrow
             {\rm FDR}~q \mbox{-value} \rightarrow {\rm FDR}~z
             \mbox{-score}

These calculations are performed independently for each statistical
sub-brick.



*... [end of excerpt; see below for the full document]*

\.\.\. Full Enlightenment
=========================

| For continued enjoyment of this topic, please see the complete
  document here:
| `3dFDR.pdf
  <https://afni.nimh.nih.gov/pub/dist/doc/manual/3dFDR.pdf>`_
