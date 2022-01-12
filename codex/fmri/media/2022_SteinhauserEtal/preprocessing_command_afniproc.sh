#!/bin/bash

# Used for processing in: 
#    
#    Steinhauser JL, Teed AR, Al-Zoubi O, Hurlemann R, Chen G, Khalsa
#    SS (2022). Functional dissection of neural connectivity in
#    generalized anxiety disorder.
#    https://www.biorxiv.org/content/10.1101/2022.01.09.475543v1
#
# See also the project github page for further scripts and files:
#    https://github.com/Jonas-Ste/GAD_MBA_FC
#
# NB: This version contains minor changes to linespacing, from the
# github repository version (for aesthetic purposes).  No content
# word/command was changed.
#
##############################################################################

# these arguments are necessary to be provided when running the command
subj_id=$1
session=$2
epi_file=$3
output_dir=$4

session_id=$subj_id-$session

fs_dir=$output_dir/../prep_FS
sswarper_dir=$output_dir/../SSwarper

afni_proc.py                                                  \
    -subj_id $session_id                                      \
    -blocks despike ricor tshift align tlrc volreg blur mask  \
            scale regress                                     \
    -radial_correlate_blocks tcat volreg                      \
    -copy_anat $sswarper_dir/anatSS.${session_id}.nii         \
    -anat_has_skull no                                        \
    -anat_follower anat_w_skull anat $sswarper_dir/anatU.${session_id}.nii               \
    -anat_follower_ROI aaseg anat $fs_dir/${session_id}-FS/SUMA/aparc.a2009s+aseg.nii.gz \
    -anat_follower_ROI aeseg  epi $fs_dir/${session_id}-FS/SUMA/aparc.a2009s+aseg.nii.gz \
    -anat_follower_ROI FSvent epi $fs_dir/${session_id}-FS/SUMA/fs_ap_latvent.nii.gz     \
    -anat_follower_ROI FSWe   epi $fs_dir/${session_id}-FS/SUMA/fs_ap_wm.nii.gz          \
    -anat_follower_erode FSvent FSWe                                                     \
    -ricor_regs_nfirst 3                                                                 \
    -ricor_regs $output_dir/../RETROICOR/$session_id-physio.slibase.1D                   \
    -dsets      $output_dir/../RETROICOR/$epi_file                                       \
    -regress_polort 3                                         \
    -tcat_remove_first_trs 3                                  \
    -align_opts_aea -cost lpc+ZZ -giant_move -check_flip      \
    -tlrc_base MNI152_2009_template.nii.gz                    \
    -tlrc_NL_warp                                             \
    -tlrc_NL_warped_dsets                                     \
        $sswarper_dir/anatQQ.${session_id}.nii                \
        $sswarper_dir/anatQQ.${session_id}.aff12.1D           \
        $sswarper_dir/anatQQ.${session_id}_WARP.nii           \
    -volreg_align_to MIN_OUTLIER                              \
    -volreg_align_e2a                                         \
    -volreg_tlrc_warp                                         \
    -blur_size 4                                              \
    -mask_epi_anat yes                                        \
    -regress_motion_per_run                                   \
    -regress_ROI_PC FSvent 3                                  \
    -regress_ROI_PC_per_run FSvent                            \
    -regress_make_corr_vols aeseg FSvent                      \
    -regress_anaticor_fast                                    \
    -regress_anaticor_label FSWe                              \
    -regress_censor_motion 0.2                                \
    -regress_censor_outliers 0.1                              \
    -regress_apply_mot_types demean deriv                     \
    -regress_est_blur_epits                                   \
    -regress_est_blur_errts                                   \
    -html_review_style pythonic                               \
    -script $output_dir/proc.${session_id}                    \
    -out_dir $output_dir/${session_id}.results                \
    -execute

# interpolate residuals for censored data
3dTproject                                                                         \
    -polort  0                                                                     \
    -input   $output_dir/${session_id}.results/pb04.${session_id}.r01.volreg+tlrc. \
    -censor  $output_dir/${session_id}.results/censor_${session_id}_combined_2.1D  \
    -cenmode NTRP                                                                  \
    -dsort   $output_dir/${session_id}.results/Local_FSWe_rall+tlrc                \
    -ort     $output_dir/${session_id}.results/X.nocensor.xmat.1D                  \
    -prefix  $output_dir/${session_id}.results/errts.${session_id}.fanaticor-interp

exit
