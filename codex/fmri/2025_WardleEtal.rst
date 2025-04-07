.. _codex_fmri_2025_WardleEtal:


**Wardle et al. (2025).** *Brief encounters with real objects modulate medial parietal but not occipitotemporal cortex*
*************************************************************************************************************************

.. contents:: :local:

.. highlight:: Tcsh

Introduction
============

Here we present commands used in the following paper:

* | Wardle SG, Rispoli B, Roopchansingh V, Baker CI (2025). **Brief
    encounters with real objects modulate medial parietal but not
    occipitotemporal cortex.** (*submitted*) 
    bioRxiv doi: https://doi.org/10.1101/2024.08.05.606667
  | `<https://doi.org/10.1101/2024.08.05.606667>`_

**Abstract:** 
Humans are skilled at recognizing everyday objects from pictures, even
if we have never encountered the depicted object in real life. But if
we have encountered an object, how does that real-world experience
affect the representation of its photographic image in the human
brain? We developed a paradigm that involved brief real-world manual
exploration of everyday objects prior to the measurement of brain
activity with fMRI while viewing pictures of those objects. We found
that while object-responsive regions in lateral occipital and ventral
temporal cortex were visually driven and contained highly invariant
representations of specific objects, those representations were not
modulated by this brief real-world exploration. However, there was an
effect of visual experience in object-responsive regions in the form
of repetition suppression of the BOLD response over repeated
presentations of the object images. Real-world experience with an
object did, however, produce foci of increased activation in medial
parietal and posterior cingulate cortex, regions that have previously
been associated with the encoding and retrieval of remembered items in
explicit memory paradigms. Our discovery that these regions are
engaged during spontaneous recognition of real-world objects from
their 2D image demonstrates that modulation of activity in medial
regions by familiarity is neither stimulus nor task-specific. Overall,
our results support separable coding in the human brain of the visual
appearance of an object from the associations gained via real-world
experience. The richness of object representations beyond their
photographic image has important implications for understanding object
recognition in both the human brain and in computational models.


.. comm:

   **Study keywords:** 
   FMRI, EPI, MPRAGE, 


**Main programs:** 
``afni_proc.py``

Download scripts
==================

To download, either:

* \.\.\. click the link(s) in the following table (perhaps Rightclick
  -> "Save Link As..."):

  .. list-table:: 
     :header-rows: 0

     * - |s01|
       - ``afni_proc.py`` command for multiecho FMRI

* \.\.\. or copy+paste into a terminal::

    curl -O https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/codex/fmri/media/2025_WardleEtal/s1.afni_proc.tcsh


View scripts
============

``s1.afni_proc.tcsh``
-------------------------------------------

*This script contains an afni_proc.py command for ME-FMRI processing,
with detailed regression modeling done in a separate follow-up
script.*

.. literalinclude:: /codex/fmri/media/2025_WardleEtal/s1.afni_proc.tcsh
   :language: sh
   :linenos:

.. aliases for scripts, so above is easier to read
.. |s01| replace:: :download:`s1.afni_proc.tcsh
                   </codex/fmri/media/2025_WardleEtal/s1.afni_proc.tcsh>`
