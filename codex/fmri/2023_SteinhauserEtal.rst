.. _codex_fmri_2023_SteinhauserEtal:


**Steinhauser et al. (2023).** *FReduced vmPFC-insula functional connectivity in generalized ...*
**************************************************************************************************

.. contents:: :local:

.. highlight:: Tcsh

Introduction
============

Here we present commands used in the following paper:

* | Steinhauser JL, Teed AR, Al-Zoubi O, Hurlemann R, Chen G, Khalsa
    SS (2023).  Reduced vmPFC-insula functional connectivity in 
    generalized anxiety disorder: a Bayesian confirmation study. Sci Rep. 
    13(1):9626. doi: 10.1038/s41598-023-35939-2
  | `<https://pubmed.ncbi.nlm.nih.gov/37316518/>`_

**Abstract:** 
Differences in the correlated activity of networked brain regions have
been reported in individuals with generalized anxiety disorder (GAD)
but an overreliance on null-hypothesis significance testing (NHST)
limits the identification of disorder-relevant relationships. In this
preregistered study, we applied both a Bayesian statistical framework
and NHST to the analysis of resting-state fMRI scans from females with
GAD and matched healthy comparison females. Eleven a-priori hypotheses
about functional connectivity (FC) were evaluated using Bayesian
(multilevel model) and frequentist (t-test) inference. Reduced FC
between the ventromedial prefrontal cortex (vmPFC) and the
posterior-mid insula (PMI) was confirmed by both statistical
approaches and was associated with anxiety sensitivity. FC between the
vmPFC-anterior insula, the amygdala-PMI, and the amygdala-dorsolateral
prefrontal cortex (dlPFC) region pairs did not survive multiple
comparison correction using the frequentist approach. However, the
Bayesian model provided evidence for these region pairs having
decreased FC in the GAD group. Leveraging Bayesian modeling, we
demonstrate decreased FC of the vmPFC, insula, amygdala, and dlPFC in
females with GAD. Exploiting the Bayesian framework revealed FC
abnormalities between region pairs excluded by the frequentist
analysis and other previously undescribed regions in GAD,
demonstrating the value of applying this approach to resting-state FC
data in clinical investigations.

**Study keywords:** 
resting state FMRI, EPI, MPRAGE, human, adult, RETROICOR, fast
ANATICOR, ROIs


**Main programs:** 
``afni_proc.py``, ``MBA`` (, ``@SSwarper``, ``recon-all`` (FS))


| **Github page:**
| See these authors' github page for full descriptions and downloads 
  of codes and supplementary text files:
| `<https://github.com/Jonas-Ste/GAD_MBA_FC>`_

Download scripts
================

To download, either:

* \.\.\. click the link(s) in the following table (perhaps Rightclick
  -> "Save Link As..."): 

  .. list-table:: 
     :header-rows: 0

     * - |s01|
       - run ``afni_proc.py`` for resting state analysis; note the
         inclusion of RETRIOCOR (``ricor``), fast ANATICOR
         (``-regress_anaticor_fast``), motion regression with
         principle components (PCs) from ventricle ROIs, nonlinear
         warps estimated with ``@SSwarper``, and ROI maps estimated by
         FreeSurfer's ``recon-all``
     * - |s02|
       - run ``MBA`` for matrix-based analysis; see the github page
         (link above) for the data table and ROI list

* \.\.\. or copy+paste into a terminal::

    curl -O https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/codex/fmri/media/2023_SteinhauserEtal/preprocessing_command_afniproc.sh
    curl -O https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/codex/fmri/media/2023_SteinhauserEtal/run_MBA_full.txt

View scripts
============


``preprocessing_command_afniproc.sh``
-------------------------------------------

.. literalinclude:: /codex/fmri/media/2023_SteinhauserEtal/preprocessing_command_afniproc.sh
   :linenos:

``run_MBA_full.txt``
-------------------------------------------

.. literalinclude:: /codex/fmri/media/2023_SteinhauserEtal/run_MBA_full.txt
   :linenos:

.. aliases for scripts, so above is easier to read
.. |s01| replace:: :download:`preprocessing_command_afniproc.sh
                   </codex/fmri/media/2023_SteinhauserEtal/preprocessing_command_afniproc.sh>`
.. |s02| replace:: :download:`run_MBA_full.txt
                   </codex/fmri/media/2023_SteinhauserEtal/run_MBA_full.txt>`
