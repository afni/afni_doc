#!/bin/tcsh

set subj    = ${1}
set session = ${2}
set cohort  = ${3}

set stimdir =          # location of subj timing files
set epidir  =          # location of subj EPI volumes
set anatdir =          # location of subj anatomical volumes
set outdir  =          # directory for output
set motion_max =       # motion censoring limit

# ----------------------------------------------------------------------------
setenv MPLBACKEND agg

mkdir ${outdir}

# ----------------------------------------------------------------------------

# Comment: this AP command didn't use @SSwarper for nonlinear
# alignment (it uses 3dQwarp still, just through auto_warper.py), but
# that could directly be swapped in.

afni_proc.py                                                                 \
    -subj_id                  ${subj}                                        \
    -script                   $outdir/proc.script.${subj}                    \
    -out_dir                  $outdir/${subj}.results                        \
    -scr_overwrite                                                           \
    -copy_anat                $anatdir/${subj}_anat${session}+orig.HEAD      \
    -dsets                    $epidir/OutBrick_visit${session}_r?+orig.HEAD  \
    -blocks                   despike tshift align tlrc volreg mask blur     \
                              scale regress                                  \
    -radial_correlate_blocks  tcat volreg                                    \
    -tcat_remove_first_trs    4                                              \
    -align_opts_aea           -check_flip -cost lpc+ZZ                       \
                              -giant_move                                    \
                              -AddEdge                                       \
    -tlrc_base                MNI152_2009_template_SSW.nii.gz                \
    -tlrc_NL_warp                                                            \
    -volreg_align_to          MIN_OUTLIER                                    \
    -volreg_align_e2a                                                        \
    -volreg_tlrc_warp                                                        \
    -mask_epi_anat            yes                                            \
    -blur_size                6.5                                            \
    -blur_to_fwhm                                                            \
    -regress_stim_times       $stimdir/Con_corr_${subj}-${session}.1D        \
                              $stimdir/Con_com_${subj}-${session}.1D         \
                              $stimdir/Con_omission_${subj}-${session}.1D    \
                              $stimdir/Incon_corr_${subj}-${session}.1D      \
                              $stimdir/Incon_com_${subj}-${session}.1D       \
                              $stimdir/Incon_omission_${subj}-${session}.1D  \
    -regress_stim_labels      Cong_cor Cong_com Cong_omi Incong_cor          \
                              Incong_com Incong_omi                          \
    -regress_basis            GAM                                            \
    -regress_local_times                                                     \
    -regress_motion_per_run                                                  \
    -regress_censor_motion    ${motion_max}                                  \
    -regress_censor_outliers  0.1                                            \
    -regress_compute_fitts                                                   \
    -regress_make_ideal_sum   sum_ideal.1D                                   \
    -regress_est_blur_epits                                                  \
    -regress_est_blur_errts                                                  \
    -regress_reml_exec                                                       \
    -regress_opts_reml        -GOFORIT 99                                    \
    -regress_compute_fitts                                                   \
    -regress_opts_3dD         -bout -jobs 6                                  \
                              -allzero_OK                                    \
                              -GOFORIT 99                                    \
                              -num_glt 13                                    \
                              -gltsym                                        \
                              'SYM: +Incong_com +Incong_omi +Incong_cor'     \
                              -glt_label 1 Incong__all                       \
                              -gltsym 'SYM: +Cong_com +Cong_omi +Cong_cor'   \
                              -glt_label 2 Cong__all                         \
                              -gltsym 'SYM: +0.5*Incong_com +0.5*Incong_omi' \
                              -glt_label 3 Incong_Error                      \
                              -gltsym 'SYM: +0.5*Cong_com +0.5*Cong_omi'     \
                              -glt_label 4 Cong_Error                        \
                              -gltsym                                        \
                              'SYM: +0.25*Cong_com +0.25*Cong_omi +0.25*Incong_com +0.25*Incong_omi' \
                              -glt_label 5 TOTAL_Error                       \
                              -gltsym 'SYM: +Incong_cor -Cong_cor'           \
                              -glt_label 6 Incong_cor_VS_Cong_cor            \
                              -gltsym 'SYM: +0.5*Cong_cor +0.5*Incong_cor'   \
                              -glt_label 7 TOTAL_Correct                     \
                              -gltsym                                        \
                              'SYM: +0.5*Incong_com +0.5*Incong_omi -1.0*Incong_cor' \
                              -glt_label 8 Incong_err_VS_Incong_cor          \
                              -gltsym                                        \
                              'SYM: +0.5*Cong_com +0.5*Cong_omi -1.0*Cong_cor' \
                              -glt_label 9 Cong_err_VS_Cong_cor              \
                              -gltsym 'SYM: +Incong_com -Incong_cor'         \
                              -glt_label 10 Incong_com_VS_Incong_cor         \
                              -gltsym 'SYM: +Incong_com -Cong_com'           \
                              -glt_label 11 Incong_com_VS_Cong_com           \
                              -gltsym                                        \
                              'SYM: +0.5*Incong_com +0.5*Incong_omi -0.5*Cong_com -0.5*Cong_omi' \
                              -glt_label 12 Incong_err_VS_Cong_err           \
                              -gltsym                                        \
                              'SYM: +Incong_com +Incong_omi +Incong_cor +Cong_com +Cong_omi +Cong_cor' \
                              -glt_label 13 Task_VS_Fixation                 \
    -html_review_style        pythonic                                       \
    -execute
