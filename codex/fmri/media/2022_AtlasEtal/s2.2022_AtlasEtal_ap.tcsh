#!/bin/tcsh 

# The afni_proc.py command used to process task-based multi-echo FMRI
# (ME-FMRI) data in the present study.  It incorporates skullstripping
# (SS) and nonlinear alignment (warp) results from @SSwarper.
#
# Used for processing in: 
#
#    Atlas LY, Dildine TC, Palacios-Barrios EE, Yu Q, Reynolds RC,
#    Banker LA, Grant SS, Pine DS (2022). Instructions and
#    experiential learning have similar impacts on pain and
#    pain-related brain responses but produce dissociations in
#    value-based reversal learning. (submitted)
#    https://www.biorxiv.org/content/10.1101/2021.08.25.457682v1
#
# To run for a single subject, type (while providing actual values for
# SUBJ_ID and DATA_DIR):
#
#    tcsh s2.2022_AtlasEtal_ap.tcsh  SUBJ_ID  DATA_DIR
# 
# ===========================================================================

# user inputs 
set subj     = "$1"           # subject ID
set data_dir = "$2"           # path to datasets

set template = MNI152_2009_template_SSW.nii.gz

# set some environment variables
setenv AFNI_COMPRESSOR GZIP
setenv OMP_NUM_THREADS 16

# generate+run the ME-FMRI processing script
afni_proc.py                                                                 \
    -subj_id                  ${subj}_NL                                     \
    -blocks                   tshift align tlrc volreg mask combine          \
                              scale blur regress                             \
    -radial_correlate_blocks  tcat volreg                                    \
    -dsets_me_echo            ${data_dir}/epi_run*_e01.nii                   \
    -dsets_me_echo            ${data_dir}/epi_run*_e02.nii                   \
    -dsets_me_echo            ${data_dir}/epi_run*_e03.nii                   \
    -echo_times               11.0 22.72 34.44                               \
    -reg_echo                 2                                              \
    -tcat_remove_first_trs    4                                              \
    -copy_anat                ${data_dir}/anatSS.${subj}.nii                 \
    -anat_has_skull           no                                             \
    -anat_uniform_method      unifize                                        \
    -align_opts_aea           -cost lpc                                      \
                              -Allineate_opts '-maxscl 1.01'                 \
                              -source_automask                               \
                              -align_epi_strip_method 3dSkullStrip           \
    -volreg_align_to          MIN_OUTLIER                                    \
    -volreg_align_e2a                                                        \
    -volreg_tlrc_warp                                                        \
    -volreg_compute_tsnr      yes                                            \
    -tlrc_base                ${template}                                    \
    -tlrc_NL_warp                                                            \
    -tlrc_NL_warped_dsets     ${data_dir}/anatQQ.${subj}.nii                 \
                              ${data_dir}/anatQQ.${subj}.aff12.1D            \
                              ${data_dir}/anatQQ.${subj}_WARP.nii            \
    -mask_epi_anat            yes                                            \
    -combine_method           OC                                             \
    -blur_size                4                                              \
    -regress_stim_times       ${data_dir}/${subj}_onsets_cue.txt             \
                              ${data_dir}/${subj}_heatonsets_HH.txt          \
                              ${data_dir}/${subj}_heatonsets_LL.txt          \
                              ${data_dir}/${subj}_heatonsets_currentHM.txt   \
                              ${data_dir}/${subj}_heatonsets_currentLM.txt   \
                              ${data_dir}/${subj}_onsets_scale.txt           \
    -regress_stim_labels      cue HH LL HM LM scale                          \
    -regress_stim_types       times times times times times times            \
    -regress_basis_multi      'BLOCK(1,1)' 'BLOCK(8,1)' 'BLOCK(8,1)'         \
                              'BLOCK(8,1)' 'BLOCK(8,1)' 'BLOCK(1,1)'         \
    -regress_opts_3dD                                                        \
        -jobs                 10                                             \
        -gltsym               'SYM: +HH -LL'                                 \
        -glt_label            1 'HvL'                                        \
        -gltsym               'SYM: +HM - LM'                                \
        -glt_label            2 'CurrentHMvLM'                               \
        -gltsym               'SYM: +HH +HM +LM +LL'                         \
        -glt_label            3 'HeatFX'                                     \
    -regress_motion_per_run                                                  \
    -regress_est_blur_epits                                                  \
    -regress_est_blur_errts                                                  \
    -regress_run_clustsim     yes                                            \
    -html_review_style        pythonic                                       \
    -execute
