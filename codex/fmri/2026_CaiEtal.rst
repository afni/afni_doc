.. _codex_fmri_2026_CaiEtal:


**Cai et al. (2025).** *The Hemodynamic Response Function Varies Across Anatomical Location and ...*
****************************************************************************************************

.. contents:: :local:

.. highlight:: Bash

Introduction
============

Here we present commands used in the following paper:

* | Cai Z, von Ellenrieder N, Arafat T, Kho HM, Chen G, Koupparis A,
    Abdallah C, Dudley R, Nguyen DK, Hall J, Dubeau F, Gotman J,
    Bernhardt B (2025). **The Hemodynamic Response Function Varies
    Across Anatomical Location and Pathology in the Epileptic Brain.**
    *(submitted)*
  | `<https://www.biorxiv.org/content/10.64898/2025.12.16.694757v1.full/>`_

**Abstract:** 
The hemodynamic response function (HRF) links neuronal activity to
functional magnetic resonance imaging (fMRI) signals. While most fMRI
studies use a “canonical” HRF, increasing evidence from studies of
healthy subjects suggests that the HRF depends on anatomical location
and disease states. Here, we investigate how HRF variability relates
to anatomical location and pathology in the epileptic brain, using a
large simultaneous electroencephalogram and fMRI dataset. Applying HRF
deconvolution and temporal decomposition, we built the first
whole-brain HRF library specific to epilepsy, identifying four
distinct shape groups. We mapped HRF features across parcellations of
two atlases using novel Bayesian hierarchical models. In
non-epileptogenic regions, HRF shape and spatial distributions align
with findings from healthy subjects. Within pathological regions, they
vary significantly according to pathology. Our results indicate that
HRF variability is associated with pathology, in addition to its
dependence on anatomical location, motivating region- and
pathology-based HRF modulation in epilepsy studies.


**Study keywords:** 
Epilepsy, HRF, EEG-fMRI, Pathology, Bayesian hierarchical modeling


**Main programs:** 
``@SUMA_Make_Spec_FS``, ``@SSwarper``, ``afni_proc.py``


Download scripts
================

To download, either:

* \.\.\. click the link(s) in the following table (perhaps Rightclick
  -> "Save Link As..."): 

  .. list-table:: 
     :header-rows: 0

     * - |s00|
       - run ``@SUMA_Make_Spec_FS`` (after FreeSurfer's ``recon-all``)
         to convert the volumetric datasets into NIFTI format and the
         surfaces into standardized meshes in GIFTI format
     * - |s01|
       - run ``@SSwarper`` skullstripping and nonlinear warping 
         to template space
     * - |s02|
       - run ``afni_proc.py`` for task-based FMRI analysis; 
         this uses nonlinear warps estimated with ``@SSwarper``

* \.\.\. or copy+paste into a terminal::

    curl -O https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/codex/fmri/media/2026_CaiEtal/do_00_fssuma.bash
    curl -O https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/codex/fmri/media/2026_CaiEtal/do_01_ssw.bash
    curl -O https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/codex/fmri/media/2026_CaiEtal/do_02_ap.bash

|

| **Additional code availability:**
| The authors' code is also available here, with additional Python
  scripts for generating commands on the authors' local HPC system:
| `<https://github.com/zhengchencai/epilepsy_hrf_lib/tree/main/HRF_deconvolution>`_



View scripts
============

*The scripts shown here contain full examples of the per-subject
commands created by the above GitHub repository's Python
implementation.*

``do_00_fssuma.bash``
-------------------------------------------

.. literalinclude:: /codex/fmri/media/2026_CaiEtal/do_00_fssuma.bash
   :linenos:

``do_01_ssw.bash``
-------------------------------------------

*This command uses ``@SSwarper`` for combined skullstripping and
nonlinear warping. In subsequent work, it has been updated to use the
more modern version of this program in AFNI, ``sswarper2``, which has
similar purpose, option usage and integration with ``afni_proc.py``.*

.. literalinclude:: /codex/fmri/media/2026_CaiEtal/do_01_ssw.bash
   :linenos:

``do_02_ap.bash``
-------------------------------------------

*The FMRI processing here makes use of the TENT deconvolution approach
used by* :ref:`Chen et al. (2023) <codex_fmri_2023_ChenEtal>`.

.. literalinclude:: /codex/fmri/media/2026_CaiEtal/do_02_ap.bash
   :linenos:

.. aliases for scripts, so above is easier to read
.. |s00| replace:: :download:`do_00_fssuma.bash
                   </codex/fmri/media/2026_CaiEtal/do_00_fssuma.bash>`
.. |s01| replace:: :download:`do_01_ssw.bash
                   </codex/fmri/media/2026_CaiEtal/do_01_ssw.bash>`
.. |s02| replace:: :download:`do_02_ap.bash
                   </codex/fmri/media/2026_CaiEtal/do_02_ap.bash>`
