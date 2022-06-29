.. _codex_fmri_2018a_ChenEtal:


**Chen et al. (2018a).** *A tail of two sides: Artificially doubled false positive ...*
*****************************************************************************************

.. contents:: :local:

.. highlight:: Tcsh

Introduction
============

Here we present commands used in the following paper:

* | Chen G, Cox RW, Glen DR, Rajendra JK, Reynolds RC, Taylor PA
    (2019).  A tail of two sides: Artificially doubled false positive
    rates in neuroimaging due to the sidedness choice with t-tests.  Human
    Brain Mapping 40:1037-1043.
  | `<https://pubmed.ncbi.nlm.nih.gov/30265768/>`_

**Abstract:** 
One-sided t-tests are widely used in neuroimaging data analysis. While
such a test may be applicable when investigating specific regions and
prior information about directionality is present,we argue here that
it is often mis-applied, with severe consequences for false positive
rate (FPR) control. Conceptually, a pair of one-sided t-tests
conducted in tandem (e.g., to test separately for both positive and
negative effects), effectively amounts to a two-sided t-test. However,
replacing the two-sided test with a pair of one-sided tests without
multiple comparisons correction essentially doubles the intended FPR
of statements made about the same study; that is, the actual
family-wise error (FWE) of results at the whole brain level would be
10% instead of the 5% intended by the researcher. Therefore, we
strongly recommend that, unless otherwise explicitly justified,
two-sided t-tests be applied instead of two simultaneous one-sided
t-tests.

**Study keywords:** 
task-block, EPI, MPRAGE, human, control, adult, MNI space, nonlinear
align

**Main programs:** 
``3dMEMA``, ``3dClustSim``, ``3dClusterize``, ``gen_group_command.py``,
``3dmask_tool``

Download scripts
================

To download, either:

* \.\.\. click the link(s) in the following table (perhaps Rightclick
  -> "Save Link As..."):

  .. list-table:: 
     :header-rows: 0

     * - |s01|
       - An example of group level analyses with two-tailed testing
         (using ``3dMEMA``, ``3dClustSim`` and ``3dClusterize``, among
         others)


* \.\.\. or copy+paste into a terminal::

    curl -O https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/codex/fmri/media/2018a_ChenEtal/s.nimh_group_level_02_mema_bisided.tcsh

View scripts
============

These scripts were run on the NIH's Biowulf HPC cluster, hence some of
the variables like ``$SLURM_CPUS_PER_TASK``, ``$SLURM_JOBID``, etc.

``s.nimh_group_level_02_mema_bisided.tcsh``
-------------------------------------------

.. literalinclude:: /codex/fmri/media/2018a_ChenEtal/s.nimh_group_level_02_mema_bisided.tcsh
   :linenos:



.. aliases for scripts, so above is easier to read
.. |s01| replace:: :download:`s.nimh_group_level_02_mema_bisided.tcsh
                   </codex/fmri/media/2018a_ChenEtal/s.nimh_group_level_02_mema_bisided.tcsh>`

