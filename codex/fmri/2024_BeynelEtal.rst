.. _codex_fmri_2024_BeynelEtal:


**Beynel et al. (2024).** *Lessons learned from an fMRI-guided rTMS study ...*
**************************************************************************************************

.. contents:: :local:

.. highlight:: Tcsh

Introduction
============

Here we present commands used in the following paper:

* | Beynel L, Gura H, Rezaee Z, Ekpo EC, Deng ZD, Joseph JO, Taylor P,
    Luber B, Lisanby SH (2024). Lessons learned from an fMRI-guided
    rTMS study on performance in a numerical Stroop task. PLoS One
    19(5):e0302660. doi: 10.1371/journal.pone.0302660.
  | `<https://pubmed.ncbi.nlm.nih.gov/38709724/>`_

**Abstract:** 
The Stroop task is a well-established tool to investigate the
influence of competing visual categories on decision
making. Neuroimaging as well as rTMS studies have demonstrated the
involvement of parietal structures, particularly the intraparietal
sulcus (IPS), in this task. Given its reliability, the numerical
Stroop task was used to compare the effects of different TMS targeting
approaches by Sack and colleagues (Sack AT 2009), who elegantly
demonstrated the superiority of individualized fMRI targeting. We
performed the present study to test whether fMRI-guided rTMS effects
on numerical Stroop task performance could still be observed while
using more advanced techniques that have emerged in the last decade
(e.g., electrical sham, robotic coil holder system, etc.). To do so we
used a traditional reaction time analysis and we performed, post-hoc,
a more advanced comprehensive drift diffusion modeling
approach. Fifteen participants performed the numerical Stroop task
while active or sham 10 Hz rTMS was applied over the region of the
right intraparietal sulcus (IPS) showing the strongest functional
activation in the Incongruent > Congruent contrast. This target was
determined based on individualized fMRI data collected during a
separate session. Contrary to our assumption, the classical reaction
time analysis did not show any superiority of active rTMS over sham,
probably due to confounds such as potential cumulative rTMS effects,
and the effect of practice. However, the modeling approach revealed a
robust effect of rTMS on the drift rate variable, suggesting
differential processing of congruent and incongruent properties in
perceptual decision-making, and more generally, illustrating that more
advanced computational analysis of performance can elucidate the
effects of rTMS on the brain where simpler methods may not.


**Study keywords:** 
task-based FMRI, EPI, MPRAGE, human, adult, rTMS


**Main programs:** 
``afni_proc.py``, ``@SSwarper``


| **Github page:**
| See these authors' github page for descriptions and downloads 
  of codes and supplementary text files:
| `<https://github.com/afni/apaper_rtms_fmri_stroop>`_

Download scripts
================

To download, either:

* \.\.\. click the link(s) in the following table (perhaps Rightclick
  -> "Save Link As..."): 

  .. list-table:: 
     :header-rows: 0

     * - |s01|
       - run ``@SSwarper`` for nonlinear alignment to a template, and 
         skullstripping of the subject's T1w anatomical volume
     * - |s02|
       - run ``afni_proc.py`` for task-based FMRI analysis (Stroop
         task); this uses nonlinear warps estimated with ``@SSwarper``

* \.\.\. or copy+paste into a terminal::

    curl -O https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/codex/fmri/media/2024_BeynelEtal/do_13_ssw.bash
    curl -O https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/codex/fmri/media/2024_BeynelEtal/do_20_ap_targeting.bash

View scripts
============


``do_13_ssw.bash``
-------------------------------------------

.. literalinclude:: /codex/fmri/media/2024_BeynelEtal/do_13_ssw.bash
   :linenos:

``do_20_ap_targeting.bash``
-------------------------------------------

.. literalinclude:: /codex/fmri/media/2024_BeynelEtal/do_20_ap_targeting.bash
   :linenos:

.. aliases for scripts, so above is easier to read
.. |s01| replace:: :download:`do_13_ssw.bash
                   </codex/fmri/media/2024_BeynelEtal/do_13_ssw.bash>`
.. |s02| replace:: :download:`do_20_ap_targeting.bash
                   </codex/fmri/media/2024_BeynelEtal/do_20_ap_targeting.bash>`
