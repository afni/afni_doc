.. _codex_fmri_2025_YueEtal:


**Yue et al. (2025).** *Ultrafast fMRI reveals serial queuing of information processing ...*
****************************************************************************************************

.. contents:: :local:

.. highlight:: Tcsh

Introduction
============

Here we present commands used in the following paper:

* | Yue Q, Newton AT, Marois R (2025). **Ultrafast fMRI reveals serial queuing
    of information processing during multitasking in the human
    brain.** Nat Commun 16(1):3057.
  | `<https://pmc.ncbi.nlm.nih.gov/articles/PMC11953464/>`_

**Abstract:** 
The human brain is heralded for its massive parallel processing
capacity, yet influential cognitive models suggest that there is a
central bottleneck of information processing distinct from perceptual
and motor stages that limits our ability to carry out two cognitively
demanding tasks at once, resulting in the serial queuing of task
information processing. Here we used ultrafast (199 ms TR), high-field
(7T) fMRI with multivariate analyses to distinguish brain activity
between two arbitrary sensorimotor response selection tasks when the
tasks were temporally overlapping. We observed serial processing of
task-specific activity in the fronto-parietal multiple-demand (MD)
network, while processing in earlier sensory stages unfolded largely
in parallel. Moreover, the MD network combined with modality-specific
motor areas to define the functional characteristic of the central
bottleneck at the stage of response selection. These results provide
direct neural evidence for serial queuing of information processing
and pinpoint the neural substrates undergirding the central
bottleneck.


**Study keywords:** 
FMRI, Attention, Human behaviour


**Main programs:** 
``afni_proc.py``, ``@SSwarper``, ``to3d``, ``Dimon``, 
``timing_tool.py``, ``3dcalc``

Download scripts
================

To download, either:

* \.\.\. click the link(s) in the following table (perhaps Rightclick
  -> "Save Link As..."): 

  .. list-table:: 
     :header-rows: 0

     * - |s00|
       - run ``to3d`` and ``Dimon`` to convert the datasets into NIFTI 
         format
     * - |s01|
       - run ``timing_tool.py`` to create stimulus timing files for
         the FMRI processing
     * - |s02|
       - run ``@SSwarper`` skullstripping and nonlinear warping 
         to template space
     * - |s03|
       - run ``afni_proc.py`` for task-based FMRI analysis; 
         this uses nonlinear warps estimated with ``@SSwarper``

* \.\.\. or copy+paste into a terminal::

    curl -O https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/codex/fmri/media/2025_YueEtal/do_00_recon_data.tcsh
    curl -O https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/codex/fmri/media/2025_YueEtal/do_01_prepare_timing_file.tcsh
    curl -O https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/codex/fmri/media/2025_YueEtal/do_02_preproc_anat.tcsh
    curl -O https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/codex/fmri/media/2025_YueEtal/do_03_preproc_func.tcsh

|

| **Additional code availability:**
| The authors' code is also available here, with additional
  Matlab scripts for MVPA:
| `<https://s3.accre.vu:9000/maroislabbucket/maroisnatcomms/prp_scripts.zip>`_

View scripts
============

``do_00_recon_data.tcsh``
-------------------------------------------

.. literalinclude:: /codex/fmri/media/2025_YueEtal/do_00_recon_data.tcsh
   :linenos:

``do_01_prepare_timing_file.tcsh``
-------------------------------------------

.. literalinclude:: /codex/fmri/media/2025_YueEtal/do_01_prepare_timing_file.tcsh
   :linenos:

``do_02_preproc_anat.tcsh``
-------------------------------------------

.. literalinclude:: /codex/fmri/media/2025_YueEtal/do_02_preproc_anat.tcsh
   :linenos:

``do_03_preproc_func.tcsh``
-------------------------------------------

.. literalinclude:: /codex/fmri/media/2025_YueEtal/do_03_preproc_func.tcsh
   :linenos:

.. aliases for scripts, so above is easier to read
.. |s00| replace:: :download:`do_00_recon_data.tcsh
                   </codex/fmri/media/2025_YueEtal/do_00_recon_data.tcsh>`
.. |s01| replace:: :download:`do_01_prepare_timing_file.tcsh
                   </codex/fmri/media/2025_YueEtal/do_01_prepare_timing_file.tcsh>`
.. |s02| replace:: :download:`do_02_preproc_anat.tcsh
                   </codex/fmri/media/2025_YueEtal/do_02_preproc_anat.tcsh>`
.. |s03| replace:: :download:`do_03_preproc_func.tcsh
                   </codex/fmri/media/2025_YueEtal/do_03_preproc_func.tcsh>`
