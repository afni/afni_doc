#!/bin/tcsh

# AP: script to run FMRI pipeline with afni_proc.py

# --------------------------- env vars and init ----------------------------

# compress BRIK files
setenv AFNI_COMPRESSOR GZIP

# initial exit code
set ecode = 0

# -------------------------- subject and path info -------------------------

# subject ID
set subj  = sub-002

# script label, mainly for logs
set label = 20_ap

# supplementary datasets (here, in known directory via environment var)
set dset_ref       = MNI152_2009_template_SSW.nii.gz 

# upper (group-level) directories
set dir_inroot     = ${PWD:h}                   # one dir above scripts/
set dir_log        = ${dir_inroot}/logs         # store tee'ed info
set dir_basic      = ${dir_inroot}              # here, same dir as inroot

# subject input directories
set sdir_basic     = ${dir_basic}/${subj}
set sdir_func      = ${sdir_basic}/func
set sdir_anat      = ${sdir_basic}/anat
set sdir_events    = ${sdir_basic}/timing

# subject derivative directories
set sdir_deriv     = ${sdir_basic}/derivatives  # for all derived outputs
set sdir_ssw       = ${sdir_deriv}/ssw
set sdir_ap        = ${sdir_deriv}/ap

\mkdir -p ${dir_log}

# ----------------------- data and control variables -----------------------

# dataset inputs
set dsets_epi       = ( ${sdir_func}/sub-002_task-avrel_run-*nii.gz )

set dset_anat_cp    = ${sdir_ssw}/anatSS.${subj}.nii
set dset_anat_skull = ${sdir_ssw}/anatU.${subj}.nii
set dsets_NL_warp   = ( ${sdir_ssw}/anatQQ.${subj}.nii       \
                        ${sdir_ssw}/anatQQ.${subj}.aff12.1D  \
                        ${sdir_ssw}/anatQQ.${subj}_WARP.nii  )

set timing_files  = ( ${sdir_events}/times.{vis,aud}.txt )
set stim_classes  = ( vis aud )

# could add separate section here for control variables in the AP
# command, like blur size, censor thresholds, etc.

# check available N_threads and report what is being used
set nthr_avail = `afni_system_check.py -disp_num_cpu`
set nthr_using = `afni_check_omp`

echo "++ INFO: Using ${nthr_using} of available ${nthr_avail} threads"

# ----------------------------- main commands ------------------------------

# 'tis convenient to run from this dir, for the supplementary outputs
\mkdir -p ${sdir_ap}
cd ${sdir_ap}

# run the FMRI pipeline creation+execution
afni_proc.py                                                                 \
    -subj_id                  ${subj}                                        \
    -dsets                    ${dsets_epi}                                   \
    -copy_anat                ${dset_anat_cp}                                \
    -anat_has_skull           no                                             \
    -anat_follower            anat_w_skull anat ${dset_anat_skull}           \
    -blocks                   tshift align tlrc volreg blur mask scale       \
                              regress                                        \
    -radial_correlate_blocks  tcat volreg regress                            \
    -tcat_remove_first_trs    2                                              \
    -align_opts_aea           -cost lpc+ZZ                                   \
                              -giant_move                                    \
                              -check_flip                                    \
    -tlrc_base                ${dset_ref}                                    \
    -tlrc_NL_warp                                                            \
    -tlrc_NL_warped_dsets     ${dsets_NL_warp}                               \
    -volreg_align_to          MIN_OUTLIER                                    \
    -volreg_align_e2a                                                        \
    -volreg_tlrc_warp                                                        \
    -volreg_compute_tsnr      yes                                            \
    -blur_size                4.0                                            \
    -mask_epi_anat            yes                                            \
    -regress_stim_times       ${timing_files}                                \
    -regress_stim_labels      ${stim_classes}                                \
    -regress_basis            'BLOCK(20,1)'                                  \
    -regress_censor_motion    0.3                                            \
    -regress_censor_outliers  0.05                                           \
    -regress_motion_per_run                                                  \
    -regress_opts_3dD         -jobs 2                                        \
                              -gltsym 'SYM: vis -aud'                        \
                              -glt_label 1 V-A                               \
                              -gltsym 'SYM: 0.5*vis +0.5*aud'                \
                              -glt_label 2 mean.VA                           \
    -regress_compute_fitts                                                   \
    -regress_make_ideal_sum   sum_ideal.1D                                   \
    -regress_est_blur_epits                                                  \
    -regress_est_blur_errts                                                  \
    -regress_run_clustsim     no                                             \
    -html_review_style        pythonic                                       \
    -execute                                                                 \
    |& tee                    ${dir_log}/log_${subj}_${label}.txt

if ( ${status} ) then
    set ecode = 2
    goto COPY_AND_EXIT
endif

echo "++ done proc ok"

# -------------------------- finish and exit -------------------------------

COPY_AND_EXIT:

if ( ${ecode} ) then
    echo "++ BAD FINISH: ${label} (ecode = ${ecode})"
else
    echo "++ GOOD FINISH: ${label}"
endif

exit ${ecode}
