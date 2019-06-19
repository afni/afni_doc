.. _stats_lme_model:

******************************************************
**Linear Mixed-Effects Modeling**
******************************************************

.. contents:: :local:

Introduction
------------

Program ``3dLME`` in the AFNI suite is a program that runs FMRI group
analysis with a linear mixed-effects modeling approach. One simple
criterion to decide whether ``3dLME`` is appropriate is that each subject
has to have two or more measurements at each spatial location (except
for a small portion of subjects with missing data). In other words, at
least one within-subject (or repeated-measures) factor serves as
explanatory variable. Input files for ``3dLME`` can be in AFNI, NIfTI, or
surface (niml.dset or 1D) format.

Now ``3dLME`` has been fully revamped with a standard AFNI-style
scripting interface. For usage and options, type the following on
terminal for details::

  3dLME | less

Three examples are provided in the above **help** document. In
addition, more theoretical discussions and examples can be found in
the following publication:

Chen, G., Saad, Z.S., Britton, J.C., Pine, D.S., Cox,
R.W. (2013). Linear Mixed-Effects Modeling Approach to FMRI Group
Analysis.  NeuroImage,
http://dx.doi.org/10.1016/j.neuroimage.2013.01.047

The `Group Analysis slides <https://afni.nimh.nih.gov/pub/dist/edu/latest/afni_handouts/afni24_GroupAna.pdf>`_
and its `Hands-On presentation <https://afni.nimh.nih.gov/pub/dist/edu/latest/afni_handouts/afni25_GroupAna_HO.pdf>`_
from AFNI workshop are also good resources for various modeling
approaches.
