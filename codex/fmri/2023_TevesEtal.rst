.. _codex_fmri_2023_TevesEtal:


**Teves et al. (2023).** *The art and science of using quality control to understand and ...*
****************************************************************************************************************

.. contents:: :local:

.. highlight:: Tcsh

Introduction
============

Here we present commands used in the following paper:

* | Teves JB, Gonzalez-Castillo J, Holness M, Spurney M, Bandettini
    PA, Handwerker DA (2023).  The art and science of using quality
    control to understand and improve fMRI data. Front Neurosci 17:1100544.
  | `<https://www.frontiersin.org/journals/neuroscience/articles/10.3389/fnins.2023.1100544/full/>`_


**Abstract:**  
Designing and executing a good quality control (QC) process is vital
to robust and reproducible science and is often taught through hands
on training. As FMRI research trends toward studies with larger sample
sizes and highly automated processing pipelines, the people who
analyze data are often distinct from those who collect and preprocess
the data. While there are good reasons for this trend, it also means
that important information about how data were acquired, and their
quality, may be missed by those working at later stages of these
workflows. Similarly, an abundance of publicly available datasets,
where people (not always correctly) assume others already validated
data quality, makes it easier for trainees to advance in the field
without learning how to identify problematic data. This manuscript is
designed as an introduction for researchers who are already familiar
with fMRI, but who did not get hands on QC training or who want to
think more deeply about QC. This could be someone who has analyzed
fMRI data but is planning to personally acquire data for the first
time, or someone who regularly uses openly shared data and wants to
learn how to better assess data quality. We describe why good QC
processes are important, explain key priorities and steps for fMRI QC,
and as part of the FMRI Open QC Project, we demonstrate some of these
steps by using AFNI software and AFNI's QC reports on an openly shared
dataset. A good QC process is context dependent and should address
whether data have the potential to answer a scientific question,
whether any variation in the data has the potential to skew or hide
key results, and whether any problems can potentially be addressed
through changes in acquisition or data processing. Automated metrics
are essential and can often highlight a possible problem, but human
interpretation at every stage of a study is vital for understanding
causes and potential solutions.

**Study keywords:** 
GLM; fMRI; neuroimaging; noise removal; quality control; 
reproducibility; resting state


**Main programs:** 
``afni_proc.py``, ``timing_tool.py``, 
``abids_tool.py``, 
``@SSwarper``, ``recon-all`` (FS)


Download scripts
================

| **Github page:**
| See this GitHub page for full descriptions and downloads 
  of codes and supplementary text files:
| `<https://github.com/nimh-sfim/SFIM_Frontiers_Neuroimaging_QC_Project>`_
 
\... or copy+paste the following in a terminal::

  git clone https://github.com/nimh-sfim/SFIM_Frontiers_Neuroimaging_QC_Project.git
  
|

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

*Because there are so many scripts for this project, we recommend
downloading the full set from the github pages, above.  There are
helpful supplemental notes there, as well.*


``ap_rest.sh``
-------------------------------------------

Full processing (through regression modeling) of a resting state FMRI
session for a single subject (with blurring, for voxelwise analysis).

`<https://github.com/nimh-sfim/SFIM_Frontiers_Neuroimaging_QC_Project/blob/main/code/ap_rest.sh>`_

``ap_task_unifize.sh``
-------------------------------------------

Full processing (through regression modeling) of a task-based FMRI
session for a single subject (with blurring, for voxelwise analysis).

`<https://github.com/nimh-sfim/SFIM_Frontiers_Neuroimaging_QC_Project/blob/main/code/ap_task_unifize.sh>`_

