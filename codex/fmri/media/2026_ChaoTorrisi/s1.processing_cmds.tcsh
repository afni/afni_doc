#!/bin/tcsh

# Main commands and code blocks used in:

#   Chao LL, Torrisi S. Effects of predicted Khamisiyah exposure on
#   default mode network resting state functional connectivity in Gulf War
#   Veterans. Front Toxicol. 2026 Mar 5;8:1772515.
#   doi:10.3389/ftox.2026.1772515. PMID: 41858729; PMCID: PMC12999065.
#
# Most of the sections are here independent code snippets for both
# per-subject and group-level steps. As such, most paths are left out
# of commands, for brevity and readability.
#
# Note: although the paper does not refer to the acronym "VAS", the
# code does; it is just internal shorthand for "VA Sarin".
#
# A couple of the variables used throughout
# 
#    subj     : subject ID
#    ssw_dir  : directory storing outputs of sswarper2
#
# ============================================================================

# convert to DICOM format files to NIFTI format files

dcm2niix_afni -z y -f "${subj}_rs" VAS*fmri*/*.IMA
dcm2niix_afni -z y -f "${subj}_t1" VAS*t1_mpr*/*.IMA

# ============================================================================

# execute sswarper2 (SSW): skullstrip the T1w anatomical and estimate
# nonlinear warp to MNI template space

sswarper2                                                                    \
    -input      VAS*mpr*/VAS*_t1_crop.nii.gz                                 \
    -base       MNI152_2009_template_SSW.nii.gz                              \
    -aniso_off                                                               \
    -odir       ${ssw_dir}                                                   \
    -subid      ${subj}

# ============================================================================

# Run afni_proc.py (AP) for full single subject processing. 
# 
# Notes: 
# + "-ShowMeClassicFWHM" is used to see directional smoothness
#   estimates provided by the older ("classic") Gaussian method. These
#   smoothness values are not used for clustering, but instead for
#   separate, directional checks.

afni_proc.py                                                                 \
    -subj_id                  ${subj}                                        \
    -script                   proc.${subj}                                   \
    -out_dir                  ${subj}.results                                \
    -blocks                   despike tshift align tlrc volreg mask blur     \
                              scale regress                                  \
    -radial_correlate_blocks  tcat volreg                                    \
    -copy_anat                ${ssw_dir}/aanatSS.VAS???-?.nii                \
    -anat_has_skull           no                                             \
    -anat_follower            anat_w_skull anat VAS*/VAS*_t1.nii.gz          \
    -dsets                    VAS*/VAS*_rs.nii.gz                            \
    -tcat_remove_first_trs    2                                              \
    -align_unifize_epi        local                                          \
    -align_opts_aea           -cost lpc+ZZ                                   \
                              -check_flip                                    \
    -tlrc_base                MNI152_2009_template_SSW.nii.gz                \
    -tlrc_NL_warp                                                            \
    -tlrc_NL_warped_dsets     ${ssw_dir}/anatQQ.VAS???-?.nii                 \
                              ${ssw_dir}/anatQQ.VAS???-?.aff12.1D            \
                              ${ssw_dir}/anatQQ.VAS???-?_WARP.nii            \
    -volreg_align_to          MIN_OUTLIER                                    \
    -volreg_align_e2a                                                        \
    -volreg_tlrc_warp                                                        \
    -volreg_compute_tsnr      yes                                            \
    -mask_epi_anat            yes                                            \
    -blur_size                5                                              \
    -regress_censor_motion    0.5                                            \
    -regress_censor_outliers  0.05                                           \
    -regress_anaticor_fast                                                   \
    -regress_apply_mot_types  demean deriv                                   \
    -regress_est_blur_errts                                                  \
    -regress_run_clustsim     yes                                            \
    -regress_opts_fwhmx       -ShowMeClassicFWHM                             \
    -html_review_style        pythonic                                       \
    -execute

# ============================================================================

# After spherical seed in the PCC was "undumped", calculate average
# time series and make a whole-brain correlation map of Fisher
# Z-values (run per subject, in the AP results dir)

3dmaskave                                                                    \
    -quiet                                                                   \
    -mask   vas_pcc_sphere6.nii                                              \
    errts.${subj}.fanaticor+tlrc.                                            \
    > ${subj}_r6_pcc_fa.1D

3dTcorr1D                                                                    \
    -prefix  ${subj}_pcc_6mm_seed_fa.nii.gz                                  \
    -Fisher                                                                  \
    errts.${subj}.fanaticor+tlrc.                                            \
    ${subj}_r6_pcc_fa.1D

# ============================================================================

# Intermediate code to get thresholded mask mean intersected with GM
# to use for group stats and cluster correction:

# After afni_proc.py finishes, get an averaged and then thresholded
# mask from all subjs.

# The mask is thresholded because we do not wish to perform stats on
# regions with high signal dropout.
3dMean                                                                       \
    -prefix  vas_avg_mask.nii.gz                                             \
    subjects*.results/mask_epi_anat.*.HEAD

3dcalc                                                                       \
    -a       vas_avg_mask.nii.gz                                             \
    -expr    'step(a-0.75)'                                                  \
    -prefix  vas_avg_mask_75p.nii.gz

# Get a template GM mask, resampled to EPI grid and then intersected
# with vas_avg_mask_75p.nii.gz.
3dresample                                                                   \
    -input   '~/abin/MNI152_2009_template_SSW.nii.gz[4]'                     \
    -master  vas_avg_mask_75p.nii.gz                                         \
    -prefix  MNI152_2009_template_gm_rs.nii.gz

3dcalc                                                                       \
    -a       MNI152_2009_template_gm_rs.nii.gz                               \
    -b       vas_avg_mask_75p.nii.gz                                         \
    -expr    'a*b'                                                           \
    -prefix  vas_ave_mask_75p_gm.nii.gz

# Extract ACF coeficients:
gen_ss_review_table.py                                                       \
    -write_table  vas_review_table.xls                                       \
    -infiles      subjects*.results/out.ss_rev*.txt
# ... and vas_review_table.xls was simply brought into Excel to
# average ACF coefficients.

# And 3dClustSim used the final group GM mask and those averaged ACFs:
3dClustSim                                                                   \
    -prefix  VAS_group_75p_gm                                                \
    -mask    vas_avg_mask_75p_gm.nii.gz                                      \
    -LOTS                                                                    \
    -iter    50000                                                           \
    -acf     0.70094065 3.69261775 12.65456525

# Finally, the output "VAS_group_75p_gm.NN2_bisided.1D" was used to
# cluster-correct group stats obtained thusly:

# =================================

3dttest++                                                                    \
    -prefix      vas_pcc_sarin_compare.nii.gz                                \
    -setA        sarinYes                                                    \
                 014-2 "pcc_corr_maps/VAS014-2_pcc_6mm_seed_fa.nii.gz"       \
                 028-2 "pcc_corr_maps/VAS028-2_pcc_6mm_seed_fa.nii.gz"       \
                 030-2 "pcc_corr_maps/VAS030-2_pcc_6mm_seed_fa.nii.gz"       \
                 034-2 "pcc_corr_maps/VAS034-2_pcc_6mm_seed_fa.nii.gz"       \
                 047-2 "pcc_corr_maps/VAS047-2_pcc_6mm_seed_fa.nii.gz"       \
                 054-2 "pcc_corr_maps/VAS054-2_pcc_6mm_seed_fa.nii.gz"       \
                 060-2 "pcc_corr_maps/VAS060-2_pcc_6mm_seed_fa.nii.gz"       \
                 061-2 "pcc_corr_maps/VAS061-2_pcc_6mm_seed_fa.nii.gz"       \
                 062-2 "pcc_corr_maps/VAS062-2_pcc_6mm_seed_fa.nii.gz"       \
                 063-2 "pcc_corr_maps/VAS063-2_pcc_6mm_seed_fa.nii.gz"       \
                 070-2 "pcc_corr_maps/VAS070-2_pcc_6mm_seed_fa.nii.gz"       \
                 090-2 "pcc_corr_maps/VAS090-2_pcc_6mm_seed_fa.nii.gz"       \
                 096-2 "pcc_corr_maps/VAS096-2_pcc_6mm_seed_fa.nii.gz"       \
                 107-2 "pcc_corr_maps/VAS107-2_pcc_6mm_seed_fa.nii.gz"       \
                 114-2 "pcc_corr_maps/VAS114-2_pcc_6mm_seed_fa.nii.gz"       \
                 115-2 "pcc_corr_maps/VAS115-2_pcc_6mm_seed_fa.nii.gz"       \
                 149-2 "pcc_corr_maps/VAS149-2_pcc_6mm_seed_fa.nii.gz"       \
                 262-1 "pcc_corr_maps/VAS262-1_pcc_6mm_seed_fa.nii.gz"       \
                 283-1 "pcc_corr_maps/VAS283-1_pcc_6mm_seed_fa.nii.gz"       \
    -setB        sarinNo                                                     \
                 065-2 "pcc_corr_maps/VAS065-2_pcc_6mm_seed_fa.nii.gz"       \
                 071-2 "pcc_corr_maps/VAS071-2_pcc_6mm_seed_fa.nii.gz"       \
                 116-2 "pcc_corr_maps/VAS116-2_pcc_6mm_seed_fa.nii.gz"       \
                 118-2 "pcc_corr_maps/VAS118-2_pcc_6mm_seed_fa.nii.gz"       \
                 121-2 "pcc_corr_maps/VAS121-2_pcc_6mm_seed_fa.nii.gz"       \
                 124-2 "pcc_corr_maps/VAS124-2_pcc_6mm_seed_fa.nii.gz"       \
                 157-2 "pcc_corr_maps/VAS157-2_pcc_6mm_seed_fa.nii.gz"       \
                 182-2 "pcc_corr_maps/VAS182-2_pcc_6mm_seed_fa.nii.gz"       \
                 243-1 "pcc_corr_maps/VAS243-1_pcc_6mm_seed_fa.nii.gz"       \
                 248-1 "pcc_corr_maps/VAS248-1_pcc_6mm_seed_fa.nii.gz"       \
                 259-1 "pcc_corr_maps/VAS259-1_pcc_6mm_seed_fa.nii.gz"       \
                 263-1 "pcc_corr_maps/VAS263-1_pcc_6mm_seed_fa.nii.gz"       \
                 265-1 "pcc_corr_maps/VAS265-1_pcc_6mm_seed_fa.nii.gz"       \
                 266-1 "pcc_corr_maps/VAS266-1_pcc_6mm_seed_fa.nii.gz"       \
                 269-1 "pcc_corr_maps/VAS269-1_pcc_6mm_seed_fa.nii.gz"       \
                 270-1 "pcc_corr_maps/VAS270-1_pcc_6mm_seed_fa.nii.gz"       \
                 274-1 "pcc_corr_maps/VAS274-1_pcc_6mm_seed_fa.nii.gz"       \
                 275-1 "pcc_corr_maps/VAS275-1_pcc_6mm_seed_fa.nii.gz"       \
                 276-1 "pcc_corr_maps/VAS276-1_pcc_6mm_seed_fa.nii.gz"       \
                 278-1 "pcc_corr_maps/VAS278-1_pcc_6mm_seed_fa.nii.gz"       \
                 279-1 "pcc_corr_maps/VAS279-1_pcc_6mm_seed_fa.nii.gz"       \
    -covariates  covariate.txt'[1]'                                          \
    -center      SAME                                                        \
    -mask        vas_avg_mask_75p_gm.nii.gz

# =================================

# Create anatomical underlay for viewing final results:
3dMean -prefix vas_avg_anat.nii.gz subjects*.results./anat_final.*HEAD

# =================================
# Following these steps other miscellaneous smallish scripts were written
# in tcsh to pull betas (3dROIstats), or in R to correlate w/ behavior
# or self-reports or to address reviewer comments. 
# For example, vas_review_table.xls above was also used to demonstrate that
# there were no between-group differences in 3 head motion parameters.
