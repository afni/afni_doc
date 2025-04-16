.. _codex_fmri_2023_LeppingEtal:


**Lepping et al. (2023).** *Quality control in resting-state fMRI: the benefits of visual inspection*
****************************************************************************************************************

.. contents:: :local:

.. highlight:: Tcsh

Introduction
============

Here we present commands used in the following paper:

* | Lepping RJ, Yeh HW, McPherson BC, Brucks MG, Sabati M, Karcher RT,
    Brooks WM, Habiger JD, Papa VB, Martin LE. Quality control in
    resting-state fMRI: the benefits of visual inspection. Front
    Neurosci 17:1076824. 
  | `<https://www.frontiersin.org/journals/neuroscience/articles/10.3389/fnins.2023.1076824/full/>`_

**Abstract:**  

Background: A variety of quality control (QC) approaches are employed
in resting-state functional magnetic resonance imaging (rs-fMRI) to
determine data quality and ultimately inclusion or exclusion of a fMRI
data set in group analysis. Reliability of rs-fMRI data can be
improved by censoring or “scrubbing” volumes affected by motion. While
censoring preserves the integrity of participant-level data, including
excessively censored data sets in group analyses may add
noise. Quantitative motion-related metrics are frequently reported in
the literature; however, qualitative visual inspection can sometimes
catch errors or other issues that may be missed by quantitative
metrics alone. In this paper, we describe our methods for performing
QC of rs-fMRI data using software-generated quantitative and
qualitative output and trained visual inspection.

Results: The data provided for this QC paper had relatively low
motion-censoring, thus quantitative QC resulted in no
exclusions. Qualitative checks of the data resulted in limited
exclusions due to potential incidental findings and failed
pre-processing scripts.

Conclusion: Visual inspection in addition to the review of
quantitative QC metrics is an important component to ensure high
quality and accuracy in rs-fMRI data analysis.  



**Study keywords:**
artifacts; functional magnetic resonance imaging (fMRI); 
quality control; reproducibility of results; resting state---fMRI. 


**Main programs:** 
``afni_proc.py``, ``@SSwarper``


Download scripts
================

| **Github page:**
| See this GitHub page for full descriptions and downloads 
  of codes and supplementary text files:
| `<https://github.com/rlepping/kumc-hbic/tree/rsfMRI-qc-paper>`_
 
\... or copy+paste the following in a terminal::

  git clone https://github.com/rlepping/kumc-hbic/tree/rsfMRI-qc-paper.git
  

**Note:** This work was one of several contributed to the following
Frontiers Research Topic project, described here:

* | Taylor PA, Etzel JA, Glen D, Reynolds RC (2022).  Demonstrating
    Quality Control (QC) Procedures in fMRI.
  | `Research Topic homepage <https://www.frontiersin.org/research-topics/33922/demonstrating-quality-control-qc-procedures-in-fmri>`_

The datasets analyzed within it are publicly available and located
here:

* | Taylor PA, Etzel JA, Glen D, Reynolds RC, Moraczewski D, Basavaraj
    A (2022). FMRI Open QC Project.  DOI 10.17605/OSF.IO/QAESM 
  | `<https://osf.io/qaesm/>`_


View scripts
============

*Additional notes are available in the GitHub repo above, as well.*


``1_SSWarper.sh``
-------------------------------------------

Process the T1w anatomical volume with ``@SSwarper``, to skullstrip
(SS) and estimate nonlinear alignment (warping) to a template.

`<https://github.com/rlepping/kumc-hbic/blob/rsfMRI-qc-paper/1_SSWarper.sh>`_

``2_Preprocess.sh``
-------------------------------------------

Full processing (through regression modeling) of a task-based FMRI
session for a single subject (with blurring, for voxelwise analysis).

`<https://github.com/rlepping/kumc-hbic/blob/rsfMRI-qc-paper/2_Preprocess.sh>`_

