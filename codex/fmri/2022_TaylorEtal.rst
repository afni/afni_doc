.. _codex_fmri_2022_TaylorEtal:


**Taylor et al. (2022).** *Highlight Results, Don't Hide Them: Enhance interpretation, ...*
*******************************************************************************************************

.. contents:: :local:

.. highlight:: Tcsh

Introduction
============

Here we present commands used in the following paper:

* | Taylor PA, Reynolds RC, Calhoun V, Gonzalez-Castillo J, Handwerker
    DA, Bandettini PA, Mejia AF, Chen G (2022).  Highlight Results,
    Don't Hide Them: Enhance interpretation, reduce biases and improve
    reproducibility. (submitted)

  | `<https://www.biorxiv.org/content/10.1101/2022.10.26.513929v2>`_

**Abstract:** Most neuroimaging studies display results that represent
only a tiny fraction of the collected data. While it is conventional
to present "only the significant results" to the reader, here we
suggest that this practice has several negative consequences for both
reproducibility and understanding. This practice hides away most of
the results of the dataset and leads to problems of selection bias and
irreproducibility, both of which have been recognized as major issues
in neuroimaging studies recently. Opaque, all-or-nothing thresholding,
even if well-intentioned, places undue influence on arbitrary filter
values, hinders clear communication of scientific results, wastes
data, is antithetical to good scientific practice, and leads to
conceptual inconsistencies. It is also inconsistent with the
properties of the acquired data and the underlying biology being
studied. Instead of presenting only a few statistically significant
locations and hiding away the remaining results, we propose that
studies should "highlight" the former while also showing as much as
possible of the rest. This is distinct from but complementary to
utilizing data sharing repositories: the initial presentation of
results has an enormous impact on the interpretation of a study. We
present practical examples for voxelwise, regionwise and cross-study
analyses using publicly available data that was analyzed previously by
70 teams (NARPS; Botvinik-Nezer, et al., 2020), showing that it is
possible to balance the goals of displaying a full set of results with
providing the reader reasonably concise and "digestible" findings. In
particular, the highlighting approach sheds useful light on the kind
of variability present among the NARPS teams' results, which is
primarily a varied strength of agreement rather than
disagreement. Using a meta-analysis built on the informative
"highlighting" approach shows this relative agreement, while one using
the standard "hiding" approach does not. We describe how this simple
but powerful change in practice-focusing on highlighting results,
rather than hiding all but the strongest ones-can help address many
large concerns within the field, or at least to provide more complete
information about them. We include a list of practical suggestions for
results reporting to improve reproducibility, cross-study comparisons
and meta-analyses.

**Study keywords:** 
FMRI, EPI, MPRAGE, human, adult, data visualization, transparent
thresholding, reproducibility, interpretation, task-based FMRI,
amplitude modulation, meta-analysis


**Main programs:** 
``afni_proc.py``, ``timing_tool.py``, ``@SSwarper``, ``recon-all``
(FS), ``gen_ss_review_table.py``, ``3dttest++``, ``3dttest++ -Clustsim
..``, ``3dttest++ -Clustsim -ETAC ..``, ``gen_group_command.py``,
``RBA``, ``@chauffeur_afni``


| **Github page:**
| See these authors' github page for full descriptions and downloads 
  of codes and supplementary text files:
| `<https://github.com/afni/apaper_highlight_narps>`_

Download scripts
================

To download, either:

* | visit the github page:
  | `<https://github.com/afni/apaper_highlight_narps>`_

* \.\.\. or copy+paste into a terminal::

    git clone https://github.com/afni/apaper_highlight_narps.git

View scripts
============

Because there are so many scripts for this project, just recommend
downloading the full set from the github pages, above.  There are
helpful ``README*`` files there, as well, to describe the contents in
details.

Note that these scripts were run on the NIH's Biowulf HPC, so
some scriptiness deals with those specific features (batch/swarm
submission, etc.).

We just point to a couple specific examples of the ``afni_proc.py``
processing scripts here:

``do_22_ap_task.tcsh``
-------------------------------------------

Full processing (through regression modeling) of a task-based FMRI
session for a single subject.  This **does not** include blurring,
because it will be used for ROI-based analysis.

`<https://github.com/afni/apaper_highlight_narps/blob/main/scripts_biowulf/do_22_ap_task.tcsh>`_

``do_23_ap_task_b.tcsh``
-------------------------------------------

Full processing (through regression modeling) of a task-based FMRI
session for a single subject.  This **does** include blurring, because
it will be used for voxelwise analysis.

`<https://github.com/afni/apaper_highlight_narps/blob/main/scripts_biowulf/do_23_ap_task_b.tcsh>`_

