#!/bin/bash

# run 3dLMEr for group-level linear mixed effects analysis modeling
# the continuous frequency variable with random intercepts.
#
# This script runs a parallel 3dLMEr analysis (to s3*.sh) using an
# alternative input data table structure for comparative evaluation,
# applying the same model specifications as in the other 3dLMEr command.

# ============================================================================

p1=/mnt/ext4/TMN/fmri_data/preproc_data/M/TMN

3dLMEr                                                                       \
    -prefix     output_LME_2.nii                                             \
    -jobs       16                                                           \
    -model      "Freq+(1|Subj)+(1|Subj:Run)"                                 \
    -qVars      'Freq'                                                       \
    -gltCode    'Freq_effect' 'Freq :'                                       \
    -mask       ${p1}/full_mask.group.M.nii                                  \
    -dataTable  @newDataTable_fin_SK_2.txt


