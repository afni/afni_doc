.. _codex_fmri_2016_ChenEtal:


**Chen et al. (2016).** Untangling the Relatedness among Correlations, Part II: Inter-Subject Correlation Group Analysis through Linear Mixed-Effects Modeling
**************************************************************************************************************************************************************

.. contents:: :local:

.. highlight:: Tcsh

Introduction
============

Here we present commands used in the following paper:


* | Chen G, Taylor PA, Shin YW, Reynolds RC, Cox RW (2017). Untangling
    the Relatedness among Correlations, Part II: Inter-Subject
    Correlation Group Analysis through Linear Mixed-Effects
    Modeling. Neuroimage 147:825-840.
  | `<https://doi.org/10.1016/j.neuroimage.2016.08.029>`_
  | `<https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5303634/>`_

**Abstract:** 
It has been argued that naturalistic conditions in FMRI studies
provide a useful paradigm for investigating perception and cognition
through a synchronization measure, inter-subject correlation
(ISC). However, one analytical stumbling block has been the fact that
the ISC values associated with each single subject are not
independent, and our previous paper (Chen et al., 2016) used
simulations and analyses of real data to show that the methodologies
adopted in the literature do not have the proper control for false
positives. In the same paper, we proposed nonparametric subject-wise
bootstrapping and permutation testing techniques for one and two
groups, respectively, which account for the correlation structure, and
these greatly outperformed the prior methods in controlling the false
positive rate (FPR); that is, subject-wise bootstrapping (SWB) worked
relatively well for both cases with one and two groups, and
subject-wise permutation (SWP) testing was virtually ideal for group
comparisons. Here we seek to explicate and adopt a parametric approach
through linear mixed-effects (LME) modeling for studying the ISC
values, building on the previous correlation framework, with the
benefit that the LME platform offers wider adaptability, more powerful
interpretations, and quality control checking capability than
nonparametric methods. We describe both theoretical and practical
issues involved in the modeling and the manner in which LME with
crossed random effects (CRE) modeling is applied. A data-doubling step
further allows us to conveniently track the subject index, and achieve
easy implementations. We pit the LME approach against the best
nonparametric methods, and find that the LME framework achieves proper
control for false positives. The new LME methodologies are shown to be
both efficient and robust, and they will be publicly available in AFNI
(http://afni.nimh.nih.gov).

**Study keywords:** 
naturalistic, EPI, MPRAGE, human, control, adult, Talairach space,
nonlinear align, FreeSurfer, fANATICOR

**Main programs:** 
``recon-all`` (FS), ``@SUMA_Make_Spec_FS``, ``afni_proc.py``

Download scripts
==================

To download, either:

* \.\.\. click the link(s) in the following table (perhaps Rightclick
  -> "Save Link As..."):

  .. list-table:: 
     :header-rows: 0

     * - |s01a|
       - FreeSurfer segmentation with ``recon-all``;
         ``@SUMA_Make_Spec_FS``; tissue selection
     * - |s02a|
       - ``afni_proc.py`` command

* \.\.\. or copy+paste into a terminal::

    wget https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/codex/fmri/media/2016_ChenEtal/s.2016_ChenEtal_01_init.tcsh
    wget https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/codex/fmri/media/2016_ChenEtal/s.2016_ChenEtal_02_ap.tcsh

View scripts
============

``s.2016_ChenEtal_01_init.tcsh``
-----------------------------------------

.. literalinclude:: /codex/fmri/media/2016_ChenEtal/s.2016_ChenEtal_01_init.tcsh
   :linenos:

``s.2016_ChenEtal_02_ap.tcsh``
--------------------------------------

.. literalinclude:: /codex/fmri/media/2016_ChenEtal/s.2016_ChenEtal_02_ap.tcsh
   :linenos:



.. aliases for scripts, so above is easier to read
.. |s01a| replace:: :download:`s.2016_ChenEtal_01_init.tcsh
                     </codex/fmri/media/2016_ChenEtal/s.2016_ChenEtal_01_init.tcsh>`
.. |s02a| replace:: :download:`s.2016_ChenEtal_02_ap.tcsh
                     </codex/fmri/media/2016_ChenEtal/s.2016_ChenEtal_02_ap.tcsh>`
  
