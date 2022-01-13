.. _codex_fmri_2018b_ChenEtal:


**Chen et al. (2018b).** Handling Multiplicity in Neuroimaging Through Bayesian Lenses with Multilevel Modeling
****************************************************************************************************************

.. contents:: :local:

.. highlight:: Tcsh

Introduction
============

Here we present commands used in the following paper:

* | Chen G, Xiao Y, Taylor PA, Rajendra JK, Riggins T, Geng F, Redcay
    E, Cox RW (2019). Handling Multiplicity in Neuroimaging Through
    Bayesian Lenses with Multilevel Modeling. Neuroinformatics. 
    17(4):515-545. doi:10.1007/s12021-018-9409-6
  | `<https://pubmed.ncbi.nlm.nih.gov/30649677/>`_

**Abstract:** 
Here we address the current issues of inefficiency and
over-penalization in the massively univariate approach followed by the
correction for multiple testing, and propose a more efficient model
that pools and shares information among brain regions. Using Bayesian
multilevel (BML) modeling, we control two types of error that are more
relevant than the conventional false positive rate (FPR): incorrect
sign (type S) and incorrect magnitude (type M). BML also aims to
achieve two goals: 1) improving modeling efficiency by having one
integrative model and thereby dissolving the multiple testing issue,
and 2) turning the focus of conventional null hypothesis significant
testing (NHST) on FPR into quality control by calibrating type S
errors while maintaining a reasonable level of inference
efficiency. The performance and validity of this approach are
demonstrated through an application at the region of interest (ROI)
level, with all the regions on an equal footing: unlike the current
approaches under NHST, small regions are not disadvantaged simply
because of their physical size. In addition, compared to the massively
univariate approach, BML may simultaneously achieve increased spatial
specificity and inference efficiency, and promote results reporting in
totality and transparency. The benefits of BML are illustrated in
performance and quality checking using an experimental dataset. The
methodology also avoids the current practice of sharp and arbitrary
thresholding in the p-value funnel to which the multidimensional data
are reduced. The BML approach with its auxiliary tools is available as
part of the AFNI suite for general use.

**Study keywords:** 
task-block, EPI, MPRAGE, human, adult


**Main programs:** 
``BayesianGroupAna.py``

Download scripts
================

To download, either:

* \.\.\. click the link(s) in the following table (perhaps Rightclick
  -> "Save Link As..."):

  .. list-table:: 
     :header-rows: 0

     * - |s01|
       - An example of group level analysis with the "Bayesian
         multilevel" (BML) approach via ``BayesianGroupAna.py``.
     * - |s02|
       - The data table of subject information input into the BML
         analysis.  See the associated paper for full description and
         generation.

* \.\.\. or copy+paste into a terminal::

    curl -O https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/codex/fmri/media/2018b_ChenEtal/runBGA.tcsh
    curl -O https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/codex/fmri/media/2018b_ChenEtal/test_ToMI_1106.txt

View scripts
============


``runBGA.tcsh``
-------------------------------------------

.. literalinclude:: /codex/fmri/media/2018b_ChenEtal/runBGA.tcsh
   :linenos:

``test_ToMI_1106.txt``
-------------------------------------------

.. literalinclude:: /codex/fmri/media/2018b_ChenEtal/test_ToMI_1106.txt
   :linenos:



.. aliases for scripts, so above is easier to read
.. |s01| replace:: :download:`runBGA.tcsh
                   </codex/fmri/media/2018b_ChenEtal/runBGA.tcsh>`
.. |s02| replace:: :download:`test_ToMI_1106.txt
                   </codex/fmri/media/2018b_ChenEtal/test_ToMI_1106.txt>`


