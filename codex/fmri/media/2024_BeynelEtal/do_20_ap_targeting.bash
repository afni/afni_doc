#!/bin/bash

# ===========================================================================
# Name:       do_20_ap_targeting.bash
# Author:     LB
# Date:       7/12/22

# Syntax:     bash do_20_ap_targeting.bash SUBJ
# Arguments:  SUBJ: subject ID

# Desc:       This script will run all chosen scans through the 
#             afni_proc.py pipelining program
# Req:        1) AFNI
# Notes:       --
# ===========================================================================

# Biowulf loading
module load afni python/3.9

# ------------------------------ get inputs ---------------------------------

if [ "$#" -eq 1 ]; then
   subj=$1
else
   echo "** Please specify participant ID **"
   exit 1
fi

# ------------------------------ define paths ---------------------------------

pwd_dir=`pwd`
proj_dir=${pwd_dir%/*}

anatdir=${proj_dir}/Anat/${subj}           # dir with T1w anatomical
funcdir=${proj_dir}/Func/${subj}           # dir with FMRI/EPI
stimdir=${proj_dir}/Behav/${subj}          # dir with stim timing files
analysisdir=${proj_dir}/Analysis/${subj}   # dir with SSW results; output here

MNItemplate=${pwd_dir}/MNI152_2009_template_SSW.nii.gz
echo "++ Template: ${MNItemplate}"

cd ${analysisdir}

# --------------------------- check input dsets ------------------------------

# anat
if [ -f "${anatdir}/${subj}_T1.nii" ] ; then
cat <<EOF
++ Found T1w dset of ${subj} ++
EOF

else
cat <<EOF
** ERROR: This participant does not have T1w dset ... EXITING **
EOF
   exit 1
fi

# epi
if [ -f "${funcdir}/${subj}_Block1.nii" ] ; then
cat <<EOF
++ Found functional dset for participant ${subj}, moving to next step ++
EOF

else
cat <<EOF
** ERROR: Subject ${subj} does not have functional dset(s).
   Checked: ${funcdir}/${subj}_Block?.nii
   ... EXITING **
EOF
   exit 1
fi

# --------------------------- build pipeline ------------------------------

### Set up FMRI pipeline with AFNI's afni_proc.py
### (need to add fixation and ITI and incorrect as stim)

afni_proc.py                                                                 \
    -subj_id                  "${subj}"                                      \
    -blocks                   tshift align tlrc volreg blur mask scale       \
                              regress                                        \
    -copy_anat                "${analysisdir}/anatSS.${subj}.nii"            \
    -anat_has_skull           no                                             \
    -dsets                    "${funcdir}/${subj}"_Block?.nii                \
    -tcat_remove_first_trs    2                                              \
    -align_opts_aea           -cost lpc+ZZ                                   \
                              -giant_move                                    \
                              -check_flip                                    \
    -anat_uniform_method      unifize                                        \
    -align_unifize_epi        local                                          \
    -volreg_align_to          MIN_OUTLIER                                    \
    -volreg_align_e2a                                                        \
    -volreg_tlrc_warp                                                        \
    -tlrc_base                "${MNItemplate}"                               \
    -tlrc_NL_warp                                                            \
    -tlrc_NL_warped_dsets     "${analysisdir}/anatQQ.${subj}.nii"            \
                              "${analysisdir}/anatQQ.${subj}.aff12.1D"       \
                              "${analysisdir}/anatQQ.${subj}_WARP.nii"       \
    -volreg_compute_tsnr      yes                                            \
    -mask_epi_anat            yes                                            \
    -radial_correlate_blocks  tcat volreg                                    \
    -regress_est_blur_errts                                                  \
    -blur_size                4.0                                            \
    -regress_motion_per_run                                                  \
    -regress_censor_motion    0.3                                            \
    -regress_censor_outliers  0.05                                           \
    -regress_reml_exec                                                       \
    -regress_3dD_stop                                                        \
    -regress_stim_types       AM1                                            \
    -regress_stim_times       "${stimdir}/Congruent_Corr_${subj}.txt"        \
                              "${stimdir}/Incongruent_Corr_${subj}.txt"      \
                              "${stimdir}/Incorrect_${subj}.txt"             \
    -regress_stim_labels      Congruent Incongruent Incorrect                \
    -regress_basis            'dmBLOCK'                                      \
    -regress_opts_3dD         -jobs 16                                       \
                              -gltsym 'SYM: +Incongruent -Congruent'         \
                              -glt_label 1 Incongruent-Congruent             \
    -html_review_style        pythonic                                       \
    -execute


exit 0
