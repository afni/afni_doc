.. _codex_fmri_2025_TaylorEtal:


**Taylor et al. (2025).** *Go Figure: Transparency in neuroscience images preserves context ...*
****************************************************************************************************

.. contents:: :local:

.. highlight:: Tcsh

Introduction
============

Here we present commands used in the following paper:

* | **Go Figure: Transparency in
    neuroscience images preserves context and clarifies
    interpretation.**  
  | Paul A. Taylor, Himanshu Aggarwal, Peter Bandettini, Marco
    Barilari, Molly Bright, Cesar Caballero-Gaudes, Vince Calhoun,
    Mallar Chakravarty, Gabriel Devenyi, Jennifer Evans, Eduardo
    Garza-Villarreal, Jalil Rasgado-Toledo, Remi Gau, Daniel Glen,
    Rainer Goebel, Javier Gonzalez-Castillo, Omer Faruk Gulban,
    Yaroslav Halchenko, Daniel Handwerker, Taylor Hanayik, Peter
    Lauren, David Leopold, Jason Lerch, Christian Mathys, Paul
    McCarthy, Anke McLeod, Amanda Mejia, Stefano Moia, Thomas Nichols,
    Cyril Pernet, Luiz Pessoa, Bettina Pfleiderer, Justin Rajendra,
    Laura Reyes, Richard Reynolds, Vinai Roopchansingh, Chris Rorden,
    Brian Russ, Benedikt Sundermann, Bertrand Thirion, Salvatore
    Torrisi, Gang Chen (2025). 
  | `arXiv:2504.07824 <https://doi.org/10.48550/arXiv.2504.07824>`_

**Abstract:**
Visualizations are vital for communicating scientific
results. Historically, neuroimaging figures have only depicted regions
that surpass a given statistical threshold. This practice
substantially biases interpretation of the results and subsequent
meta-analyses, particularly towards non-reproducibility. Here we
advocate for a "transparent thresholding" approach that not only
highlights statistically significant regions but also includes
subthreshold locations, which provide key experimental context. This
balances the dual needs of distilling modeling results and enabling
informed interpretations for modern neuroimaging. We present four
examples that demonstrate the many benefits of transparent
thresholding, including: removing ambiguity, decreasing
hypersensitivity to non-physiological features, catching potential
artifacts, improving cross-study comparisons, reducing
non-reproducibility biases, and clarifying interpretations. We also
demonstrate the many software packages that implement transparent
thresholding, several of which were added or streamlined recently as
part of this work. A point-counterpoint discussion addresses issues
with thresholding raised in real conversations with researchers in the
field. We hope that by showing how transparent thresholding can
drastically improve the interpretation (and reproducibility) of
neuroimaging findings, more researchers will adopt this method.

**Study keywords:** 
neuroimaging, visualization, transparent thresholds, interpretability,
reproducibility, understanding, quality control, meta-analysis


**Main programs:** 
``afni_proc.py``, ``@chauffeur_afni``, ``afni``, ``3dFWHMx``,
``3dClusterize``


Download scripts
================

| **GitHub and OSF pages:**
| See this GitHub page for descriptions and downloads of codes for 
  the salmon-related processing with ``afni_proc.py`` and visualization 
  in Ex. 4:
| `<https://github.com/afni/apaper_gofigure_salmon/>`_

| ... and this OSF project page for various other data and processing
  script downloads from the four main examples:
| `<https://osf.io/n4a37/>`_

| ... and this GitHub page for code related to NARPS data processing,
  particularly related to Ex. 3:
| `<https://github.com/afni/apaper_highlight_narps/>`_

View scripts
============

*These scripts can be run on either a desktop or slurm-managed HPC
cluster (like NIH's Biowulf). Please see the related GitHub repo for
the associated run_\*.tcsh scripts, which complement these by
potentially looping over many subjects.*

``do_21_ap.tcsh``
-------------------------------------------

*This is one example of running afni_proc.py on the salmon
dataset.*

.. literalinclude:: /codex/fmri/media/2025_TaylorEtal/do_21_ap.tcsh
   :linenos:

``do_50_clust.tcsh``
-------------------------------------------

*This is one example of running 3dClustSim on a processed dataset, as
well as using @chauffeur_afni to make snapshots (including internally
running 3dClusterize and controlling transparent thresholding).*

.. literalinclude:: /codex/fmri/media/2025_TaylorEtal/do_50_clust.tcsh
   :linenos:

.. aliases for scripts, so above is easier to read
.. |s01| replace:: :download:`do_21_ap.tcsh
                   </codex/fmri/media/2025_TaylorEtal/do_21_ap.tcsh>`
.. |s02| replace:: :download:`do_50_clust.tcsh
                   </codex/fmri/media/2025_TaylorEtal/do_50_clust.tcsh>`
