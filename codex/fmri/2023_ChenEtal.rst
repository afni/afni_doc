.. _codex_fmri_2023_ChenEtal:


**Chen et al. (2023).** *BOLD response is more than just magnitude: improving detection ...*
*******************************************************************************************************

.. contents:: :local:

.. highlight:: Tcsh

Introduction
============

Here we present commands used in the following paper:

* | Chen G, Taylor PA, Reynolds RC, Leibenluft E, Pine DS, Brotmas MA,
    Pagliaccio D, Haller SP (2023). BOLD response is more than just
    magnitude: improving detection sensitivity through capturing
    hemodynamic profiles. Neuroimage 277:120224.
  | `<https://pubmed.ncbi.nlm.nih.gov/37327955/>`_


| **Abstract:** Typical FMRI analyses assume a canonical hemodynamic
  response function (HRF) with a focus on the overshoot peak height,
  while other morphological aspects are largely ignored. Thus, in most
  reported analyses, the overall effect is reduced from a curve to a
  single scalar. Here, we adopt a data-driven approach to HRF
  estimation at the whole-brain voxel level, without assuming a
  profile at the individual level. Then, we estimate the BOLD response
  in its entirety with a smoothness constraint at the population level
  to improve predictive accuracy and inferential efficiency. Instead
  of using just the scalar that represents the effect magnitude, we
  assess the whole HRF shape, which reveals additional information
  that may prove relevant for many aspects of a study, as well as for
  cross-study reproducibility. Through a fast event-related FMRI
  dataset, we demonstrate the extent of under-fitting and information
  loss that occurs when adopting the canonical approach. We also
  address the following questions:
| 1. How much does the HRF shape vary across regions, conditions, and
  clinical groups?
| 2. Does an agnostic approach improve sensitivity to detect an effect
  compared to an assumed HRF?
| 3. Can examining HRF shape help validate the presence of an effect
  complementing statistical evidence?
| 4. Could the HRF shape provide evidence for whole-brain BOLD
  response during a simple task?


**Study keywords:** 
FMRI, AFNI, task-based analysis, hemodynamic response function (HRF),
processing, regularization


**Main programs:** 
``afni_proc.py``, ``@SSwarper``, ``recon-all`` (FS),
``@chauffeur_afni``, ``3dMVM``, ``3dMSS``



| **Github page:**
| See these authors' github page for full descriptions and downloads 
  of codes and supplementary text files:
| `<https://github.com/afni/apaper_hrf_profiles>`_


Download scripts
================

To download, either:

* | visit the github page:
  | `<https://github.com/afni/apaper_hrf_profiles>`_

* \.\.\. or copy+paste into a terminal::

    git clone https://github.com/afni/apaper_hrf_profiles.git

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

``do_24_ap_task_NL.tcsh``
-------------------------------------------

Full processing (through regression modeling) of a resting state FMRI
session for a single subject (with blurring, for voxelwise analysis).

`<https://github.com/afni/apaper_hrf_profiles/blob/main/scripts_biowulf/do_24_ap_task_NL.tcsh>`_

