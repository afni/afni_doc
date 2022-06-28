.. _codex_fmri_2018_TaylorEtal:


**Taylor et al. (2018).** *FMRI processing with AFNI: Some comments and corrections ...*
******************************************************************************************

.. contents:: :local:

.. highlight:: Tcsh

Introduction
============

Here we present commands used in the following paper:

* | Taylor PA, Chen G, Glen DR, Rajendra JK, Reynolds RC, Cox RW
    (2018).  FMRI processing with AFNI: Some comments and corrections
    on 'Exploring the Impact of Analysis Software on Task fMRI
    Results'. bioRxiv 308643; doi:10.1101/308643
  | `<https://www.biorxiv.org/content/10.1101/308643v1.abstract>`_

**Abstract:** A recent study posted on bioRxiv by Bowring, Maumet and
Nichols aimed to compare results of FMRI data that had been processed
with three commonly used software packages (AFNI, FSL and SPM). Their
stated purpose was to use “default” settings of each software’s
pipeline for task-based FMRI, and then to quantify overlaps in final
clustering results and to measure similarity/dissimilarity in the
final outcomes of packages. While in theory the setup sounds simple
(implement each package’s defaults and compare results), practical
realities make this difficult. For example, different softwares would
recommend different spatial resolutions of the final data, but for the
sake of comparisons, the same value must be used across all. Moreover,
we would say that AFNI does not have an explicit default pipeline
available: a wide diversity of datasets and study designs are acquired
across the neuroimaging community, often requiring bespoke tailoring
of basic processing rather than a “one-size-fits-all”
pipeline. However, we do have strong recommendations for certain
steps, and we are also aware that the choice of a given step might
place requirements on other processing steps. Given the very clear
reporting of the AFNI pipeline used in Bowring et al. paper, we take
this opportunity to comment on some of these aspects of processing
with AFNI here, clarifying a few mistakes therein and also offering
recommendations. We provide point-by-point considerations of using
AFNI’s processing pipeline design tool at the individual level,
afni_proc.py, along with supplementary programs; while specifically
discussed in the context of the present usage, many of these choices
may serve as useful starting points for broader processing. It is our
intention/hope that the user should examine data quality at every
step, and we demonstrate how this is facilitated in AFNI, as well.

**Study keywords:** 
task-block, EPI, MPRAGE, human, control, adult, MNI space, nonlinear
align

**Main programs:** 
``afni_proc.py``, ``3dmask_tool``, ``recon-all`` (FS),
``@SUMA_Make_Spec_FS``

Download scripts
================

To download, either:

* \.\.\. click the link(s) in the following table (perhaps Rightclick
  -> "Save Link As..."):

  .. list-table:: 
     :header-rows: 0

     * - |s01|
       - BMN-AFNI processing with ``afni_proc.py``
     * - |s02|
       - NIMH-AFNI processing: skullstripping and alignment to standard
         space (via ``@SSwarper``)
     * - |s03|
       - NIMH-AFNI processing with ``afni_proc.py``
     * - |s04|
       - NIMH-AFNI group level processing: ``3dMEMA``, ``3dClustSim``,
         clusterizing


* \.\.\. or copy+paste into a terminal::

    curl -O https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/codex/fmri/media/2018_TaylorEtal/s.bmn_subject_level_02_ap.tcsh
    curl -O https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/codex/fmri/media/2018_TaylorEtal/s.nimh_subject_level_01_qwarp.tcsh
    curl -O https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/codex/fmri/media/2018_TaylorEtal/s.nimh_subject_level_02_ap.tcsh
    curl -O https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/codex/fmri/media/2018_TaylorEtal/s.nimh_group_level_02_mema.tcsh

View scripts
============

These scripts describe different approaches for processing FMRI data
with AFNI. Please read the comments at the tops of the scripts
carefully, as well as the bioRxiv papers associated with each, in
order to understand the steps. 

These scripts were run on the NIH's Biowulf HPC cluster, hence some of
the variables like ``$SLURM_CPUS_PER_TASK``, ``$SLURM_JOBID``, etc.

``s.bmn_subject_level_02_ap.tcsh``
-----------------------------------------

**Comment:** Several aspects of this particular script's command would
*not* be recommended for processing (e.g., the nonlinear alignment
program; the selection of volreg reference, and more).  Please see the
main paper for further details.

.. literalinclude:: /codex/fmri/media/2018_TaylorEtal/s.bmn_subject_level_02_ap.tcsh
   :linenos:

Script: ``s.nimh_subject_level_01_qwarp.tcsh``
-----------------------------------------------

**Comment:** ``@SSwarper`` syntax has changed a lot since these days.

.. literalinclude:: /codex/fmri/media/2018_TaylorEtal/s.nimh_subject_level_01_qwarp.tcsh
   :linenos:

Script: ``s.nimh_subject_level_02_ap.tcsh``
-----------------------------------------------

.. literalinclude:: /codex/fmri/media/2018_TaylorEtal/s.nimh_subject_level_02_ap.tcsh
   :linenos:


Script: ``s.nimh_group_level_02_mema.tcsh``
-----------------------------------------------

**Comment:** Instead of using ``3dclust`` here, the more modern and
convenient ``3dClusterize`` would now be recommended.

.. literalinclude:: /codex/fmri/media/2018_TaylorEtal/s.nimh_group_level_02_mema.tcsh
   :linenos:



.. aliases for scripts, so above is easier to read
.. |s01| replace:: :download:`s.bmn_subject_level_02_ap.tcsh
                   </codex/fmri/media/2018_TaylorEtal/s.bmn_subject_level_02_ap.tcsh>`
.. |s02| replace:: :download:`s.nimh_subject_level_01_qwarp.tcsh
                   </codex/fmri/media/2018_TaylorEtal/s.nimh_subject_level_01_qwarp.tcsh>`
.. |s03| replace:: :download:`s.nimh_subject_level_02_ap.tcsh
                   </codex/fmri/media/2018_TaylorEtal/s.nimh_subject_level_02_ap.tcsh>`
.. |s04| replace:: :download:`s.nimh_group_level_02_mema.tcsh
                   </codex/fmri/media/2018_TaylorEtal/s.nimh_group_level_02_mema.tcsh>`
  
