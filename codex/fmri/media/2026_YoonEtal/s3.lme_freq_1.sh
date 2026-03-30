#!/bin/bash

# run 3dLMEr for group level analysis

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
