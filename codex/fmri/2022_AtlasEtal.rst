.. _codex_fmri_2022_AtlasEtal:


**Atlas et al. (2022).** Instructions and experiential learning have similar impacts on pain and pain-related brain responses but produce dissociations in value-based reversal learning.
******************************************************************************************************************************************************************************************

.. contents:: :local:

.. highlight:: Tcsh

Introduction
============

Here we present commands used in the following paper:

* | Atlas LY, Dildine TC, Palacios-Barrios EE, Yu Q, Reynolds RC,
    Banker LA, Grant SS, Pine DS (2022). Instructions and experiential
    learning have similar impacts on pain and pain-related brain
    responses but produce dissociations in value-based reversal
    learning. (submitted)
  | `<https://www.biorxiv.org/content/10.1101/2021.08.25.457682v1>`_



**Abstract:** 

Recent data suggest that interactions between systems involved in
higher order knowledge and associative learning drive responses during
appetitive and aversive learning. However, it is unknown how these
systems impact subjective responses, such as pain. We tested how
instructions and reversal learning influence pain and pain-evoked
brain activation. Healthy volunteers (n = 40) were either instructed
about contingencies between cues and aversive outcomes or learned
through experience in a paradigm where contingencies reversed three
times. We measured predictive cue effects on pain and heat-evoked
brain responses using functional magnetic resonance
imaging. Predictive cues dynamically modulated pain perception as
contingencies changed, regardless of whether participants received
contingency instructions. Heat-evoked responses in the insula,
anterior cingulate, and putamen updated as contingencies changed,
whereas the periaqueductal gray and thalamus responded to initial
contingencies throughout the task. Quantitative modeling revealed that
expected value was shaped purely by instructions in the Instructed
Group, whereas expected value updated dynamically in the Uninstructed
Group as a function of error-based learning. These differences were
accompanied by dissociations in the neural correlates of value-based
learning in the rostral anterior cingulate, medial prefrontal cortex,
and orbitofrontal cortex. These results show how predictions impact
subjective pain. Moreover, imaging data delineate three types of
networks involved in pain generation and value-based learning: those
that respond to initial contingencies, those that update dynamically
during feedback-driven learning as contingencies change, and those
that are sensitive to instruction. Together, these findings provide
multiple points of entry for therapies designs to impact pain.



**Study keywords:** 
task-block, EPI, multi-echo FMRI (ME-FMRI), optimally combined (OC)
echoes, MPRAGE, human, adult,

.. comment: paper keywords
   pain, reversal learning, expectancy, conditioning, fMRI,
   computational modeling, prediction

**Main programs:** 
``@SSwarper``, ``afni_proc.py``

Download scripts
================

To download, either:

* \.\.\. click the link(s) in the following table (perhaps Rightclick
  -> "Save Link As..."):

  .. list-table:: 
     :header-rows: 0

     * - |s01|
       - run ``@SSwarper`` for skullstripping (SS) and nonlinear
         alignment (warp) estimation to a standard volumetric template
     * - |s02|
       - run ``afni_proc.py`` for task analysis on ME-FMRI data

* \.\.\. or copy+paste into a terminal::

    curl -O https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/codex/fmri/media/2022_AtlasEtal/s1.2022_AtlasEtal_ssw.tcsh
    curl -O https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/codex/fmri/media/2022_AtlasEtal/s2.2022_AtlasEtal_ap.tcsh

View scripts
============


``s1.2022_AtlasEtal_ssw.tcsh``
-------------------------------------------

.. literalinclude:: /codex/fmri/media/2022_AtlasEtal/s1.2022_AtlasEtal_ssw.tcsh
   :linenos:

``s2.2022_AtlasEtal_ap.tcsh``
-------------------------------------------

.. literalinclude:: /codex/fmri/media/2022_AtlasEtal/s2.2022_AtlasEtal_ap.tcsh
   :linenos:



.. aliases for scripts, so above is easier to read
.. |s01| replace:: :download:`s1.2022_AtlasEtal_ssw.tcsh
                   </codex/fmri/media/2022_AtlasEtal/s1.2022_AtlasEtal_ssw.tcsh>`
.. |s02| replace:: :download:`s2.2022_AtlasEtal_ap.tcsh
                   </codex/fmri/media/2022_AtlasEtal/s2.2022_AtlasEtal_ap.tcsh>`

