.. _codex_fmri_2024_ReynoldsEtal:


**Reynolds et al. (2024).** *Processing, evaluating and understanding FMRI data with afni_proc.py*
****************************************************************************************************

.. contents:: :local:

.. highlight:: Tcsh

Introduction
============

Here we present commands used in the following paper:

* | Reynolds RC, Glen DR, Chen G, Saad ZS, Cox RW, Taylor PA
    (2024). Processing, evaluating and understanding FMRI data with
    afni_proc.py. arXiv:2406.05248 [q-bio.NC]
  | `<https://arxiv.org/abs/2406.05248>`_

**Abstract:** 
FMRI data are noisy, complicated to acquire, and typically go through
many steps of processing before they are used in a study or clinical
practice. Being able to visualize and understand the data from the
start through the completion of processing, while being confident that
each intermediate step was successful, is challenging. AFNI's
afni_proc.py is a tool to create and run a processing pipeline for
FMRI data. With its flexible features, afni_proc.py allows users to
both control and evaluate their processing at a detailed level. It has
been designed to keep users informed about all processing steps: it
does not just process the data, but first outputs a fully commented
processing script that the users can read, query, interpret and refer
back to. Having this full provenance is important for being able to
understand each step of processing; it also promotes transparency and
reproducibility by keeping the record of individual-level processing
and modeling specifics in a single, shareable place. Additionally,
afni_proc.py creates pipelines that contain several automatic
self-checks for potential problems during runtime. The output
directory contains a dictionary of relevant quantities that can be
programmatically queried for potential issues and a systematic,
interactive quality control (QC) HTML. All of these features help
users evaluate and understand their data and processing in detail. We
describe these and other aspects of afni_proc.py here using a set of
task-based and resting state FMRI example commands.


**Study keywords:** 
FMRI, EPI, MPRAGE, pipeline, reproducibility, understanding, quality
control, visualization, multi-echo, surface processing


**Main programs:** 
``afni_proc.py``, ``sswarper2``, ``open_apqc.py``, 
``ap_run_simple_rest.tcsh``, ``ap_run_simple_rest_me.tcsh``


| **Github page:**
| See these authors' github page for descriptions and downloads 
  of codes and supplementary text files:
| `<https://github.com/afni/apaper_afni_proc/>`_

Download scripts
================

Since there are several scripts, we recommend downloading directly
from GitHub, such as by copy+pasting this into a terminal::

   git clone https://github.com/afni/apaper_afni_proc.git


View scripts
============

*These are just a couple examples of the "Desktop" scripts on GitHub,
please see above for downloading all scripts (both the "Desktop" and
"Biowulf" versions).*

``do_20_ap_simple.tcsh``
-------------------------------------------

*This script contains the "simple" afni_proc.py wrapper for ME-FMRI
processing.*

.. literalinclude:: /codex/fmri/media/2024_ReynoldsEtal/do_20_ap_simple.tcsh
   :linenos:

``do_23_ap_ex3_vol.tcsh``
-------------------------------------------

.. literalinclude:: /codex/fmri/media/2024_ReynoldsEtal/do_23_ap_ex3_vol.tcsh
   :linenos:

.. aliases for scripts, so above is easier to read
.. |s01| replace:: :download:`do_20_ap_simple.tcsh
                   </codex/fmri/media/2024_ReynoldsEtal/do_20_ap_simple.tcsh>`
.. |s02| replace:: :download:`do_23_ap_ex3_vol.tcsh
                   </codex/fmri/media/2024_ReynoldsEtal/do_23_ap_ex3_vol.tcsh>`
