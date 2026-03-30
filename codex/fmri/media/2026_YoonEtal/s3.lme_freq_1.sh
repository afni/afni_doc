#!/bin/bash

# run 3dLMEr for group-level linear mixed effects analysis modeling
# the continuous frequency variable with random intercepts.
#
# The model (-model "Freq+(1|Subj)+(1|Subj:Run)") is designed to
# control for random effects across individual subjects and specific
# runs, while -gltCode is used to explicitly extract the main linear
# effect of the frequency.

# ============================================================================

p1=/mnt/ext4/TMN/fmri_data/preproc_data/M/TMN

3dLMEr                                                                       \
    -prefix     output_LME_1_fin.nii                                         \
    -jobs       16                                                           \
    -model      "Freq+(1|Subj)+(1|Subj:Run)"                                 \
    -qVars      'Freq'                                                       \
    -gltCode    'Freq_effect' 'Freq :'                                       \
    -mask       ${p1}/full_mask.group.M.nii                                  \
    -dataTable  @newDataTable_fin_SK.txt
