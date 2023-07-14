.. _codex_fmri_2023_ReynoldsEtal:


**Reynolds et al. (2023).** *Quality control practices in FMRI analysis: Philosophy, methods ...*
*******************************************************************************************************

.. contents:: :local:

.. highlight:: Tcsh

Introduction
============

Here we present commands used in the following paper:

* | Reynolds RC, Taylor PA, Glen DR (2023). Quality control
    practices in FMRI analysis: Philosophy, methods and examples using
    AFNI. Front. Neurosci. 16:1073800. doi: 10.3389/fnins.2022.1073800

  | `<https://www.frontiersin.org/articles/10.3389/fnins.2022.1073800/full/>`_


**Abstract:** Quality control (QC) is a necessary, but often an
under-appreciated, part of FMRI processing. Here we describe
procedures for performing QC on acquired or publicly available FMRI
datasets using the widely used AFNI software package. This work is
part of the Research Topic, “Demonstrating Quality Control (QC)
Procedures in fMRI.” We used a sequential, hierarchical approach that
contained the following major stages: (1) GTKYD (getting to know your
data, esp. its basic acquisition properties), (2) APQUANT (examining
quantifiable measures, with thresholds), (3) APQUAL (viewing
qualitative images, graphs, and other information in systematic HTML
reports) and (4) GUI (checking features interactively with a graphical
user interface); and for task data, and (5) STIM (checking stimulus
event timing statistics). We describe how these are complementary and
reinforce each other to help researchers stay close to their data. We
processed and evaluated the provided, publicly available resting state
data collections (7 groups, 139 total subjects) and task-based data
collection (1 group, 30 subjects). As specified within the Topic
guidelines, each subject’s dataset was placed into one of three
categories: Include, exclude or uncertain. The main focus of this
paper, however, is the detailed description of QC procedures: How to
understand the contents of an FMRI dataset, to check its contents for
appropriateness, to verify processing steps, and to examine potential
quality issues. Scripts for the processing and analysis are freely
available.

**Study keywords:** 
FMRI, quality control, AFNI, resting state, reproducibility, processing, 
data visualization, task-based


**Main programs:** 
``afni_proc.py``, ``ap_run_simple_rest.tcsh``, ``timing_tool.py``, 
``3dinfo``, ``nifti_tool``, 
``@SSwarper``, ``recon-all`` (FS), ``gen_ss_review_table.py``, 
``afni`` (with InstaCorr)


| **Github page:**
| See these authors' github page for full descriptions and downloads 
  of codes and supplementary text files:
| `<https://github.com/afni/apaper_afniqc_frontiers>`_

| **APQC HTML outputs:**
| To download the APQC HTML directories for all the datasets processed
  in this project, please visit:
| `<https://osf.io/qaesm/files/osfstorage>`_
| and click on the `team_results_qc_files_ReynoldsEtal2023` directory.

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


Download scripts
================

To download, either:

* | visit the github page:
  | `<https://github.com/afni/apaper_afniqc_frontiers>`_

* \.\.\. or copy+paste into a terminal::

    git clone https://github.com/afni/apaper_afniqc_frontiers.git

View scripts
============

Because there are so many scripts for this project, just recommend
downloading the full set from the github pages, above.  There are
helpful ``README*`` files there, as well, to describe the contents in
details.

Note that these scripts were run on the NIH's Biowulf HPC, so
some scriptiness deals with those specific features (batch/swarm
submission, etc.).

We just point to a couple specific examples of the ``afni_proc.py``
processing scripts here:

``do_21_ap_rest_NL.tcsh``
-------------------------------------------

Full processing (through regression modeling) of a resting state FMRI
session for a single subject (with blurring, for voxelwise analysis).

`<https://github.com/afni/apaper_afniqc_frontiers/blob/main/scripts_biowulf_fmri_rest/do_21_ap_rest_NL.tcsh>`_

``do_21_ap_task_NL.tcsh``
-------------------------------------------

Full processing (through regression modeling) of a task-based FMRI
session for a single subject (with blurring, for voxelwise analysis).

`<https://github.com/afni/apaper_afniqc_frontiers/blob/main/scripts_biowulf_fmri_task/do_21_ap_task_NL.tcsh>`_

