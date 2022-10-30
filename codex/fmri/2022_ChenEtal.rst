.. _codex_fmri_2022_ChenEtal:


**Chen et al. (2022).** *Hyperbolic trade-off: The importance of balancing trial ...*
**************************************************************************************

.. contents:: :local:

.. highlight:: Tcsh

Introduction
============

Here we present commands used in the following paper:

* | Chen G, Pine DS, Brotman MA, Smith AR, Cox RW, Taylor PA, Haller
    SP (2022). Hyperbolic trade-off: The importance of balancing trial
    and subject sample sizes in neuroimaging. Neuroimage
    247:118786. 
  | `<https://pubmed.ncbi.nlm.nih.gov/34906711/>`_



**Abstract:** 



Here we investigate the crucial role of trials in task-based
neuroimaging from the perspectives of statistical efficiency and
condition-level generalizability. Big data initiatives have gained
popularity for leveraging a large sample of subjects to study a wide
range of effect magnitudes in the brain. On the other hand, most
task-based FMRI designs feature a relatively small number of subjects,
so that resulting parameter estimates may be associated with
compromised precision. Nevertheless, little attention has been given
to another important dimension of experimental design, which can
equally boost a study's statistical efficiency: the trial sample
size. The common practice of condition-level modeling implicitly
assumes no cross-trial variability. Here, we systematically explore
the different factors that impact effect uncertainty, drawing on
evidence from hierarchical modeling, simulations and an FMRI dataset
of 42 subjects who completed a large number of trials of cognitive
control task. We find that, due to an approximately symmetric
hyperbola-relationship between trial and subject sample sizes in the
presence of relatively large cross-trial variability, 1) trial sample
size has nearly the same impact as subject sample size on statistical
efficiency; 2) increasing both the number of trials and subjects
improves statistical efficiency more effectively than focusing on
subjects alone; 3) trial sample size can be leveraged alongside
subject sample size to improve the cost-effectiveness of an
experimental design; 4) for small trial sample sizes, trial-level
modeling, rather than condition-level modeling through summary
statistics, may be necessary to accurately assess the standard error
of an effect estimate. We close by making practical suggestions for
improving experimental designs across neuroimaging and behavioral
studies.


**Study keywords:** 

task-block, EPI, MPRAGE, Eriksen flanker task (congruent,
incongruent), trial-level modeling, trial sample size, subject sample
size, statistical efficiency, generalizability, replicability

**Main programs:** 
``afni_proc.py``, ``3dDeconvolve`` (and ``3dREMLfit``)

Download scripts
================

To download, either:

* \.\.\. click the link(s) in the following table (perhaps Rightclick
  -> "Save Link As..."):

  .. list-table:: 
     :header-rows: 0

     * - |s01|
       - run ``afni_proc.py`` for task analysis on FMRI data
     * - |s02|
       - run ``3dDeconvolve`` (which also creates a ``3dREMLfit`` script)
     * - |s03|
       - run ``3dDeconvolve`` (which also creates a ``3dREMLfit`` script)
     * - |s04|
       - run ``3dDeconvolve`` (which also creates a ``3dREMLfit`` script)
     * - |s05|
       - run ``3dDeconvolve`` (which also creates a ``3dREMLfit`` script)

* \.\.\. or copy+paste into a terminal::

    curl -O https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/codex/fmri/media/2022_ChenEtal/s1.2022_ChenEtal.ap.tcsh
    curl -O https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/codex/fmri/media/2022_ChenEtal/s2.2022_ChenEtal.AM_decon_reml.tcsh
    curl -O https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/codex/fmri/media/2022_ChenEtal/s3.2022_ChenEtal.AMerr_decon_reml.tcsh
    curl -O https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/codex/fmri/media/2022_ChenEtal/s4.2022_ChenEtal.IM_decon_reml.tcsh
    curl -O https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/codex/fmri/media/2022_ChenEtal/s5.2022_ChenEtal.IMerr_decon_reml.tcsh

View scripts
============


``s1.2022_ChenEtal.ap.tcsh``
-------------------------------------------

.. literalinclude:: /codex/fmri/media/2022_ChenEtal/s1.2022_ChenEtal.ap.tcsh
   :linenos:

``s2.2022_ChenEtal.AM_decon_reml.tcsh``
-------------------------------------------

.. literalinclude:: /codex/fmri/media/2022_ChenEtal/s2.2022_ChenEtal.AM_decon_reml.tcsh
   :linenos:

``s3.2022_ChenEtal.AMerr_decon_reml.tcsh``
-------------------------------------------

.. literalinclude:: /codex/fmri/media/2022_ChenEtal/s3.2022_ChenEtal.AMerr_decon_reml.tcsh
   :linenos:

``s4.2022_ChenEtal.IM_decon_reml.tcsh``
-------------------------------------------

.. literalinclude:: /codex/fmri/media/2022_ChenEtal/s4.2022_ChenEtal.IM_decon_reml.tcsh
   :linenos:

``s5.2022_ChenEtal.IMerr_decon_reml.tcsh``
-------------------------------------------

.. literalinclude:: /codex/fmri/media/2022_ChenEtal/s5.2022_ChenEtal.IMerr_decon_reml.tcsh
   :linenos:


.. aliases for scripts, so above is easier to read
.. |s01| replace:: :download:`s1.2022_ChenEtal.ap.tcsh
                   </codex/fmri/media/2022_ChenEtal/s1.2022_ChenEtal.ap.tcsh>`
.. |s02| replace:: :download:`s2.2022_ChenEtal.AM_decon_reml.tcsh
                   </codex/fmri/media/2022_ChenEtal/s2.2022_ChenEtal.AM_decon_reml.tcsh>`
.. |s03| replace:: :download:`s3.2022_ChenEtal.AMerr_decon_reml.tcsh
                   </codex/fmri/media/2022_ChenEtal/s3.2022_ChenEtal.AMerr_decon_reml.tcsh>`
.. |s04| replace:: :download:`s4.2022_ChenEtal.IM_decon_reml.tcsh
                   </codex/fmri/media/2022_ChenEtal/s4.2022_ChenEtal.IM_decon_reml.tcsh>`
.. |s05| replace:: :download:`s5.2022_ChenEtal.IMerr_decon_reml.tcsh
                   </codex/fmri/media/2022_ChenEtal/s5.2022_ChenEtal.IMerr_decon_reml.tcsh>`
