#!/bin/tcsh

# AP-3: run afni_proc.py for full FMRI processing (Example 3)

# Process a single subj+ses pair.

# This is a Desktop script.  Run it via swarm (see partner run*.tcsh).


# initial exit code; we don't exit at fail, to copy partial results back
set ecode = 0

# ---------------------------------------------------------------------------
# top level definitions (constant across demo)
# ---------------------------------------------------------------------------

# labels
set subj           = $1
set ses            = $2
set ap_label       = 23_ap_ex3_vol


# upper directories
set dir_inroot     = ${PWD:h}                        # one dir above scripts/
set dir_log        = ${dir_inroot}/logs
set dir_basic      = ${dir_inroot}/data_00_basic
set dir_fs         = ${dir_inroot}/data_12_fs
set dir_ssw        = ${dir_inroot}/data_13_ssw
set dir_physio     = ${dir_inroot}/data_14_physio
set dir_ap         = ${dir_inroot}/data_${ap_label}

# subject directories
set sdir_basic     = ${dir_basic}/${subj}/${ses}
set sdir_func      = ${sdir_basic}/func
set sdir_anat      = ${sdir_basic}/anat
set sdir_fs        = ${dir_fs}/${subj}/${ses}
set sdir_suma      = ${sdir_fs}/SUMA
set sdir_ssw       = ${dir_ssw}/${subj}/${ses}
set sdir_physio    = ${dir_physio}/${subj}/${ses}
set sdir_ap        = ${dir_ap}/${subj}/${ses}

# supplementary directories and info
set dir_suppl      = ${dir_inroot}/supplements
set template       = ${dir_suppl}/MNI152_2009_template_SSW.nii.gz

# set output directory
set sdir_out = ${sdir_ap}
set lab_out  = AP

# --------------------------------------------------------------------------
# data and control variables
# --------------------------------------------------------------------------

setenv AFNI_COMPRESSOR GZIP

# dataset inputs
set task_label    = task-rest_run-1

set epi_radix     = ${sdir_func}/${subj}_${ses}
set dset_epi      = ( ${epi_radix}_${task_label}_echo-2_bold.nii* ) # 2nd echo
set dsets_epi_me  = ( ${epi_radix}_${task_label}_echo-?_bold.nii* )
set me_times      = ( 12.5 27.6 42.7 )

set blip_radix    = ${sdir_func}/${subj}_${ses}_acq-blip
set epi_forward   = "${blip_radix}_dir-match_run-1_bold.nii.gz[0]"
set epi_reverse   = "${blip_radix}_dir-opp_run-1_bold.nii.gz[0]"

set physio_radix  = ${sdir_physio}/${subj}_${ses}
set physio_regs   = ${physio_radix}_${task_label}_physio_slibase.1D

set anat_cp       = ( ${sdir_ssw}/anatSS.${subj}.nii* )
set anat_skull    = ( ${sdir_ssw}/anatU.${subj}.nii* )

set dsets_NL_warp = ( ${sdir_ssw}/anatQQ.${subj}.nii*         \
                      ${sdir_ssw}/anatQQ.${subj}.aff12.1D     \
                      ${sdir_ssw}/anatQQ.${subj}_WARP.nii*  )

set roi_all_2009  = ${sdir_suma}/aparc.a2009s+aseg_REN_all.nii.gz
set roi_gmr_2009  = ${sdir_suma}/aparc.a2009s+aseg_REN_gmrois.nii.gz
set roi_gmr_2000  = ${sdir_suma}/aparc+aseg_REN_gmrois.nii.gz
set roi_FSvent    = ${sdir_suma}/fs_ap_latvent.nii.gz
set roi_FSWe      = ${sdir_suma}/fs_ap_wm.nii.gz

# control variables
set nt_rm         = 4        # number of time points to remove at start
set blur_size     = 5        # blur size in mm, usually based of voxel size
set final_dxyz    = 3        # final voxel size (isotropic dim)
set cen_motion    = 0.2      # censor threshold for motion (enorm)
set cen_outliers  = 0.05     # censor threshold for outlier frac


# check available N_threads and report what is being used
set nthr_avail = `afni_system_check.py -disp_num_cpu`
set nthr_using = `afni_check_omp`

echo "++ INFO: Using ${nthr_using} of available ${nthr_avail} threads"


# ---------------------------------------------------------------------------
# run programs
# ---------------------------------------------------------------------------

# make output directory and go to it
\mkdir -p ${sdir_out}
cd ${sdir_out}

# create command script
set run_script = ap.cmd.${subj}

cat << EOF >! ${run_script}

# AP, Example 3: for voxelwise analysis
#
# single echo FMRI
# volumetric, voxelwise analysis, warped to standard space
# include physio regressors
# include follower GM-ROIs from FS 2009 parc

# we do NOT include bandpassing here (see comments in text)

afni_proc.py                                                                \
    -subj_id                  ${subj}                                       \
    -dsets                    ${dset_epi}                                   \
    -copy_anat                ${anat_cp}                                    \
    -anat_has_skull           no                                            \
    -anat_follower            anat_w_skull anat ${anat_skull}               \
    -anat_follower_ROI        aagm09 anat ${roi_gmr_2009}                   \
    -anat_follower_ROI        aegm09 epi  ${roi_gmr_2009}                   \
    -blocks                   ricor tshift align tlrc volreg mask blur      \
                              scale regress                                 \
    -radial_correlate_blocks  tcat volreg regress                           \
    -tcat_remove_first_trs    ${nt_rm}                                      \
    -ricor_regs               ${physio_regs}                                \
    -ricor_regs_nfirst        ${nt_rm}                                      \
    -ricor_regress_method     per-run                                       \
    -align_unifize_epi        local                                         \
    -align_opts_aea           -cost lpc+ZZ -giant_move -check_flip          \
    -tlrc_base                ${template}                                   \
    -tlrc_NL_warp                                                           \
    -tlrc_NL_warped_dsets     ${dsets_NL_warp}                              \
    -volreg_align_to          MIN_OUTLIER                                   \
    -volreg_align_e2a                                                       \
    -volreg_tlrc_warp                                                       \
    -volreg_warp_dxyz         ${final_dxyz}                                 \
    -volreg_compute_tsnr      yes                                           \
    -mask_epi_anat            yes                                           \
    -blur_size                ${blur_size}                                  \
    -regress_motion_per_run                                                 \
    -regress_make_corr_vols   aegm09                                        \
    -regress_censor_motion    ${cen_motion}                                 \
    -regress_censor_outliers  ${cen_outliers}                               \
    -regress_apply_mot_types  demean deriv                                  \
    -regress_est_blur_epits                                                 \
    -regress_est_blur_errts                                                 \
    -html_review_style        pythonic

EOF

if ( ${status} ) then
    set ecode = 1
    goto COPY_AND_EXIT
endif


# execute AP command to make processing script
tcsh -xef ${run_script} |& tee output.ap.cmd.${subj}

if ( ${status} ) then
    set ecode = 2
    goto COPY_AND_EXIT
endif


# execute the proc script, saving text info
time tcsh -xef proc.${subj} |& tee output.proc.${subj}

if ( ${status} ) then
    set ecode = 3
    goto COPY_AND_EXIT
endif

echo "++ FINISHED ${lab_out}"

# ---------------------------------------------------------------------------

COPY_AND_EXIT:


if ( ${ecode} ) then
    echo "++ BAD FINISH: ${lab_out} (ecode = ${ecode})"
else
    echo "++ GOOD FINISH: ${lab_out}"
endif

exit ${ecode}

