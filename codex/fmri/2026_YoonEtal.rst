.. _codex_fmri_2026_YoonEtal:


**Yoon et al. (2026).** *Exclusive ipsilateral representation of sequential tactile differences ...*
**************************************************************************************************************************************

.. contents:: :local:

.. highlight:: Bash

Introduction
============

Here we present commands used in the following paper:

* | Yoon H, Park S, Kim S (2026). **Exclusive ipsilateral representation of sequential tactile differences challenges contralateral dominance.**
    *(submitted)*
  | `<https://www.biorxiv.org/content/10.1101/2025.11.13.688241v1.full>`_

**Abstract:** 
Tactile perception is traditionally attributed to contralateral
somatosensory (S1) processing, yet the functional role of ipsilateral
S1 in human tactile discrimination remains unclear. Using fMRI during
a sequential vibrotactile discrimination task, we examined how
frequency information is represented when participants judged which of
two successive stimuli delivered to the same fingertip was higher in
frequency. Contralateral S1 showed robust activation, and ipsilateral
S1 showed suppression during unilateral stimulation; however, linear
mixed-effects analyses revealed reliable frequency-dependent
modulation in ipsilateral S1, which was absent when no comparison was
required. Multivariate representational analyses further demonstrated
that fMRI activity patterns representing the differences between
successive stimuli were strengthened under memory demands,
particularly within ipsilateral S1 and parietal cortices. Furthermore,
the representational separability predicted individual discrimination
accuracy. The exclusive representation in the ipsilateral S1 was not
hand-specific; that is, the results were consistent for both hands,
indicating a bilateral and symmetric encoding scheme. These surprising
findings demonstrate that the ipsilateral, not contralateral, S1
contributes to tactile discrimination, challenging classic
contralateral models of somatosensory processing. These unprecedented
findings highlight interhemispheric coordination as a key mechanism
underlying perceptual decisions.


.. comm:
   **Study keywords:** 



**Main programs:** 
``dcm2niix_afni``, ``afni_proc.py``, ``3dLMEr``


Download scripts
================

To download, either:

* \.\.\. click the link(s) in the following table (perhaps Rightclick
  -> "Save Link As..."): 

  .. list-table:: 
     :header-rows: 0

     * - |s1|
       - run ``dcm2niix_afni`` to convert DICOMs to NIFTI volumes
     * - |s2|
       - run ``afni_proc.py`` for full single subject processing
     * - |s3|
       - run ``3dLMEr`` for group-level analysis
     * - |s4|
       - run ``3dLMEr`` for group-level analysis

* \.\.\. or copy+paste into a terminal::

    curl -O https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/codex/fmri/media/2026_YoonEtal/s1.convert_DICOM.zsh
    curl -O https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/codex/fmri/media/2026_YoonEtal/s2-i.create_proc_M.zsh
    curl -O https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/codex/fmri/media/2026_YoonEtal/s3.lme_freq_1.sh
    curl -O https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/codex/fmri/media/2026_YoonEtal/s4.lme_freq_2.sh

|

| **Additional code availability:**
| The authors' code is also available here, including the datatable files
  used in the 3dLMEr commands here:
| `<https://github.com/Harryyonss/TMN/tree/main/AFNI>`_



View scripts
============

*The scripts shown here contain full examples of the per-subject
commands created by the above GitHub repository's Python
implementation.*

``s1.convert_DICOM.zsh``
-------------------------------------------

.. literalinclude:: /codex/fmri/media/2026_YoonEtal/s1.convert_DICOM.zsh
   :linenos:

``s2-i.create_proc_M.zsh``
-------------------------------------------

.. literalinclude:: /codex/fmri/media/2026_YoonEtal/s2-i.create_proc_M.zsh
   :linenos:

``s3.lme_freq_1.sh``
-------------------------------------------

.. literalinclude:: /codex/fmri/media/2026_YoonEtal/s3.lme_freq_1.sh
   :linenos:

``s4.lme_freq_2.sh``
-------------------------------------------

.. literalinclude:: /codex/fmri/media/2026_YoonEtal/s4.lme_freq_2.sh
   :linenos:

.. aliases for scripts, so above is easier to read
.. |s1| replace:: :download:`s1.convert_DICOM.zsh
                   </codex/fmri/media/2026_YoonEtal/s1.convert_DICOM.zsh>`
.. |s2| replace:: :download:`s2-i.create_proc_M.zsh
                   </codex/fmri/media/2026_YoonEtal/s2-i.create_proc_M.zsh>`
.. |s3| replace:: :download:`s3.lme_freq_1.sh
                   </codex/fmri/media/2026_YoonEtal/s3.lme_freq_1.sh>`
.. |s4| replace:: :download:`s4.lme_freq_2.sh
                   </codex/fmri/media/2026_YoonEtal/s4.lme_freq_2.sh>`
