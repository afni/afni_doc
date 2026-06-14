.. _codex_fmri_2026_ChaoTorrisi:


**Chao & Torrisi (2026).** *Effects of predicted Khamisiyah exposure on default mode network ...*
**************************************************************************************************************************************

.. contents:: :local:

.. highlight:: Bash

Introduction
============

Here we present commands used in the following paper:

* | Chao LL, Torrisi S (2026). **Effects of predicted Khamisiyah exposure on default mode network resting state functional connectivity in Gulf War Veterans.**
    Front Toxicol. 8:1772515.
  | `<https://www.frontiersin.org/journals/toxicology/articles/10.3389/ftox.2026.1772515/full>`_

| **Abstract:** 
| *Introduction:*
| Potentially more than 100,000 US troops were exposed to organophosphorus (OP) nerve agents when an ammunition bunker at Khamisiyah, Iraq was destroyed shortly after the end of the 1991 Gulf War (GW). We previously reported evidence of differences in brain structure and function in GW veterans with predicted exposure to the Khamisiyah plume compared to veterans without predicted exposure. Here, we investigate the effects of predicted exposure to the Khamisiyah plume on brain functional connectivity in the default mode network (DMN).

| *Methods:*
| Forty-one GW veterans (19 with and 22 without predicted exposure) underwent structural and resting-state magnetic resonance imaging (MRI) on a 3 Tesla scanner. Differences in DMN connectivity between veterans with and without predicted Khamisiyah exposure were examined using a left posterior cingulate cortex (PCC) seed-based analysis in AFNI. FreeSurfer was used to derive quantitative estimates of total hippocampal volume. The veterans were also assessed with the Conners Continuous Performance Test (CPT).

| *Results:*
| Compared to veterans without predicted exposure, those with predicted Khamisiyah exposure demonstrated weaker connectivity between the left PCC and a cluster in the caudal right anterior cingulate cortex (ACC). Veterans with predicted exposure also had smaller left hippocampal volume compared to unexposed veterans.

| *Discussion:*
| Although the cross-sectional nature of this study precludes conclusions about causality, the finding of decreased DMN functional connectivity in GW veterans with predicted Khamisiyah exposure warrants replication in a larger, independent sample. If confirmed, this result would add to the literature suggesting persistent differences in brain function between deployed GW veterans with and without predicted Khamisiyah exposure and argue for further investigation into the long-term effects of GW-deployment related exposures.


.. comm:
   **Study keywords:** 



**Main programs:** 
``dcm2niix_afni``, ``sswarper2``, ``afni_proc.py``, ``3dmaskave``, 
``3dTcorr1D``, ``3dMean``, ``3dcalc``, ``3dresample``, ``3dttest++``


Download scripts
================

To download, either:

* \.\.\. click the link(s) in the following table (perhaps Rightclick
  -> "Save Link As..."): 

  .. list-table:: 
     :header-rows: 0

     * - |s1|
       - show major processing steps in single file

* \.\.\. or copy+paste into a terminal::

    curl -O https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/codex/fmri/media/2026_ChaoTorrisi/s1.processing_cmds.tcsh


View scripts
============

*The script shown here contains major processing steps/stages used in
the associated paper.*

``s1.processing_cmds.tcsh``
-------------------------------------------

.. literalinclude:: /codex/fmri/media/2026_ChaoTorrisi/s1.processing_cmds.tcsh
   :linenos:

.. aliases for scripts, so above is easier to read
.. |s1| replace:: :download:`s1.processing_cmds.tcsh
                   </codex/fmri/media/2026_ChaoTorrisi/s1.processing_cmds.tcsh>`
