.. _codex_fmri_2021_YangEtal:


**Yang et al. (2021).** *Different activation signatures in the primary sensorimotor ...*
********************************************************************************************

.. contents:: :local:

.. highlight:: Tcsh

Introduction
============

Here we present commands used in the following paper:

* | Yang J, Molfese PJ, Yu Y, Handwerker DA, Chen G, Taylor PA, Ejima
    Y, Wu J, Bandettini PA (2021).  Different activation signatures in
    the primary sensorimotor and higher-level regions for haptic
    three-dimensional curved surface exploration. Neuroimage 231:117754.
  | `<https://pubmed.ncbi.nlm.nih.gov/33454415/>`_

**Abstract:** 
Haptic object perception begins with continuous exploratory contact,
and the human brain needs to accumulate sensory information
continuously over time. However, it is still unclear how the primary
sensorimotor cortex (PSC) interacts with these higher-level regions
during haptic exploration over time. This functional magnetic
resonance imaging (fMRI) study investigates time-dependent haptic
object processing by examining brain activity during haptic 3D curve
and roughness estimations. For this experiment, we designed sixteen
haptic stimuli (4 kinds of curves x 4 varieties of roughness) for the
haptic curve and roughness estimation tasks. Twenty participants were
asked to move their right index and middle fingers along the surface
twice and to estimate one of the two features-roughness or
curvature-depending on the task instruction. We found that the brain
activity in several higher-level regions (e.g., the bilateral
posterior parietal cortex) linearly increased as the number of curves
increased during the haptic exploration phase. Surprisingly, we found
that the contralateral PSC was parametrically modulated by the number
of curves only during the late exploration phase but not during the
early exploration phase. In contrast, we found no similar parametric
modulation activity patterns during the haptic roughness estimation
task in either the contralateral PSC or in higher-level regions. Thus,
our findings suggest that haptic 3D object perception is processed
across the cortical hierarchy, whereas the contralateral PSC interacts
with other higher-level regions across time in a manner that is
dependent upon the features of the object.


**Study keywords:** 
task-block, EPI, MPRAGE, human, adult, surface, blip up/down correction,

.. comment: paper keywords
   Cortical hierarchy, Haptic object perception, Parametric modulation,
   Primary motor cortex, Primary somatosensory cortex, fMRI

**Main programs:** 
``afni_proc.py``, ``gen_group_command.py``, ``3dttest++``,
``3dANOVA2``, ``3dMVM``

Download scripts
================

To download, either:

* \.\.\. click the link(s) in the following table (perhaps Rightclick
  -> "Save Link As..."):

  .. list-table:: 
     :header-rows: 0

     * - |s01|
       - run ``afni_proc.py`` for task analysis on a surface
         (FreeSurfer's ``recon-all`` was run prior to this); blip
         up/down correction is also used
     * - |s02|
       - run ``afni_proc.py`` for task analysis on a surface
         (FreeSurfer's ``recon-all`` was run prior to this); blip
         up/down correction is also used
     * - |s03|
       - run ``gen_group_command.py`` to build ``3dttest++`` commands
     * - |s04|
       - run ``gen_group_command.py`` to build ``3dANOVA2`` commands
         for each hemisphere
     * - |s05|
       - run ``3dMVM``

* \.\.\. or copy+paste into a terminal::

    curl -O https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/codex/fmri/media/2021_YangEtal/s1.2021_YangEtal_ap.tcsh
    curl -O https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/codex/fmri/media/2021_YangEtal/s2.2021_YangEtal_ap.tcsh
    curl -O https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/codex/fmri/media/2021_YangEtal/s3.2021_YangEtal_gen_ttest++.tcsh
    curl -O https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/codex/fmri/media/2021_YangEtal/s4.2021_YangEtal_gen_ANOVA2.tcsh
    curl -O https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/codex/fmri/media/2021_YangEtal/s5.2021_YangEtal_MVM.tcsh

View scripts
============


``s1.2021_YangEtal_ap.tcsh``
-------------------------------------------

**Comment:** One would probably add ``-html_review_style pythonic`` here,
to have the fancier version of the automatically generated QC HTML. 

.. literalinclude:: /codex/fmri/media/2021_YangEtal/s1.2021_YangEtal_ap.tcsh
   :linenos:

``s2.2021_YangEtal_ap.tcsh``
-------------------------------------------

**Comment:** One would probably add ``-html_review_style pythonic`` here,
to have the fancier version of the automatically generated QC HTML.

.. literalinclude:: /codex/fmri/media/2021_YangEtal/s2.2021_YangEtal_ap.tcsh
   :linenos:

``s3.2021_YangEtal_gen_ttest++.tcsh``
-------------------------------------------

.. literalinclude:: /codex/fmri/media/2021_YangEtal/s3.2021_YangEtal_gen_ttest++.tcsh
   :linenos:

``s4.2021_YangEtal_gen_ANOVA2.tcsh``
-------------------------------------------

.. literalinclude:: /codex/fmri/media/2021_YangEtal/s4.2021_YangEtal_gen_ANOVA2.tcsh
   :linenos:

``s5.2021_YangEtal_MVM.tcsh``
-------------------------------------------

.. literalinclude:: /codex/fmri/media/2021_YangEtal/s5.2021_YangEtal_MVM.tcsh
   :linenos:





.. aliases for scripts, so above is easier to read
.. |s01| replace:: :download:`s1.2021_YangEtal_ap.tcsh
                   </codex/fmri/media/2021_YangEtal/s1.2021_YangEtal_ap.tcsh>`
.. |s02| replace:: :download:`s2.2021_YangEtal_ap.tcsh
                   </codex/fmri/media/2021_YangEtal/s2.2021_YangEtal_ap.tcsh>`
.. |s03| replace:: :download:`s3.2021_YangEtal_gen_ttest++.tcsh
                   </codex/fmri/media/2021_YangEtal/s3.2021_YangEtal_gen_ttest++.tcsh>`
.. |s04| replace:: :download:`s4.2021_YangEtal_gen_ANOVA2.tcsh
                   </codex/fmri/media/2021_YangEtal/s4.2021_YangEtal_gen_ANOVA2.tcsh>`
.. |s05| replace:: :download:`s5.2021_YangEtal_MVM.tcsh
                   </codex/fmri/media/2021_YangEtal/s5.2021_YangEtal_MVM.tcsh>`
