#!/bin/tcsh

# DESC: run AP to fully process FMRI data (here, for the salmon scan)

# Process a single subj+ses pair. Run it from its partner run*.tcsh script.
# Run on a slurm/swarm system (like Biowulf) or on a desktop.

# ---------------------------------------------------------------------------

# use slurm? 1 = yes, 0 = no (def: use if available)
set use_slurm = $?SLURM_CLUSTER_NAME

# ----------------------------- biowulf-cmd ---------------------------------
if ( $use_slurm ) then
    # load modules: ***** add any other necessary ones
    source /etc/profile.d/modules.csh
    module load afni

    # set N_threads for OpenMP
    setenv OMP_NUM_THREADS $SLURM_CPUS_ON_NODE
endif
# ---------------------------------------------------------------------------

# initial exit code; we don't exit at fail, to copy partial results back
set ecode = 0

# set relevant environment variables
setenv AFNI_COMPRESSOR GZIP           # zip BRIK dsets

# ---------------------------------------------------------------------------
# top level definitions (constant across demo)
# ---------------------------------------------------------------------------

# labels
set subj           = $1
set ses            = $2

# for convenience, "full" subj ID and path
set subjid = ${subj}_${ses}
set subjpa = ${subj}/${ses}

# upper directories
set dir_inroot     = ${PWD:h}                        # one dir above scripts/
set dir_log        = ${dir_inroot}/logs
set dir_basic      = ${dir_inroot}/data_00_basic
set dir_ap         = ${dir_inroot}/data_21_ap

# subject directories
set sdir_basic     = ${dir_basic}/${subjpa}
set sdir_func      = ${sdir_basic}/func
set sdir_anat      = ${sdir_basic}/anat
set sdir_ap        = ${dir_ap}/${subjpa}

# supplementary directory (reference data, etc.)
###set dir_suppl      = ${dir_inroot}/supplements
###set template       = ${dir_suppl}/*****

# set output directory
set sdir_out = ${sdir_ap}
set lab_out  = 21_ap

# --------------------------------------------------------------------------
# data and control variables
# --------------------------------------------------------------------------

# dataset inputs

set dset_anat = ${sdir_anat}/${subjid}*T1w_ROT.nii.gz
set task_name = checkbrd
set all_epi   = ( ${sdir_func}/${subjid}*task-${task_name}_run*.nii.gz )

set epi_tr    = `3dinfo -tr ${all_epi[1]}`      # TR of EPI data 

# control variables
set nt_rm         = 3        # number of time points to remove at start
set blur_size     = 4.0      # blur size in mm (here, 2x min vox dim)
set final_dxyz    = 2.0      # final voxel size (isotropic dim)
set cen_motion    = 0.2      # censor threshold for motion (enorm)
set cen_outliers  = 0.05     # censor threshold for outlier frac

# calculate offset for stim timing, since removing pre-steady state TRs
set toffset       = `echo " -1.0 * ${epi_tr} * ${nt_rm} " | bc`
echo "++ Removing ${nt_rm} vols"
echo "   -> since TR=${epi_tr} s, we use stim time offset: ${toffset} s"


# check available N_threads and report what is being used
set nthr_avail = `afni_system_check.py -disp_num_cpu`
set nthr_using = `afni_check_omp`

echo "++ INFO: Using ${nthr_using} of available ${nthr_avail} threads"

# ----------------------------- biowulf-cmd --------------------------------
if ( $use_slurm ) then
    # try to use /lscratch for speed; store "real" output dir for later copy
    if ( -d /lscratch/$SLURM_JOBID ) then
        set usetemp  = 1
        set sdir_BW  = ${sdir_out}
        set sdir_out = /lscratch/$SLURM_JOBID/${subjid}

        # prep for group permission reset
        \mkdir -p ${sdir_BW}
        set grp_own  = `\ls -ld ${sdir_BW} | awk '{print $4}'`
    else
        set usetemp  = 0
    endif
endif
# ---------------------------------------------------------------------------

# ---------------------------------------------------------------------------
# run programs
# ---------------------------------------------------------------------------

# make output directory and go to it
\mkdir -p ${sdir_out}
cd ${sdir_out}

# ----- create command script with AP cmd
set run_script = ap.cmd.${subj}

cat << EOF >! ${run_script}

# AP: salmon processing
#
# NOTES
#
# + The anatomical was pre-rotated to have better alignment with FOV
#   axes, for viewing. Therefore, we apply that same rotation as a
#   pre-rotation to the EPI dsets during EPI-anatomical alignment.
# 
# + Because the EPI and anatomical have similar contrast here, we use
#   'lpa+ZZ' as the EPI-anatomical alignment cost function (typically,
#   it would be 'lpc+ZZ', since EPIs and anatomicals often have
#   inverse tissue contrasts)
#
# + We turned off skullstripping for this dset
#
# + Input vox are 2.0x2.0x2.5 mm
#   - chosen blur was 2x min voxel dim (so, 4 mm), on larger side of
#     typical single echo recommendation
#   - final voxel size chosen as 2 mm iso (no need to really upsample)
#
# + Not using '-radial_correlate_blocks tcat volreg'
# 
# + Not using a template (just subject anatomical)

afni_proc.py                                                                 \
    -subj_id                    ${subj}                                      \
    -dsets                      ${all_epi}                                   \
    -copy_anat                  ${dset_anat}                                 \
    -anat_has_skull             no                                           \
    -blocks                     despike tshift align volreg blur mask scale  \
                                regress                                      \
    -tcat_remove_first_trs      ${nt_rm}                                     \
    -align_opts_aea             -cost lpa+ZZ                                 \
                                -pre_matrix ${sdir_anat}/mat_rot_anat.1D     \
    -volreg_align_to            MIN_OUTLIER                                  \
    -volreg_align_e2a                                                        \
    -volreg_warp_dxyz           ${final_dxyz}                                \
    -volreg_compute_tsnr        yes                                          \
    -mask_epi_anat              yes                                          \
    -blur_size                  ${blur_size}                                 \
    -regress_stim_times         ${sdir_func}/stim_${task_name}.1D            \
    -regress_stim_labels        ${task_name}                                 \
    -regress_basis              'BLOCK(10,1)'                                \
    -regress_stim_times_offset  ${toffset}                                   \
    -regress_compute_fitts                                                   \
    -regress_make_ideal_sum     sum_ideal.1D                                 \
    -regress_motion_per_run                                                  \
    -regress_censor_motion      ${cen_motion}                                \
    -regress_censor_outliers    ${cen_outliers}                              \
    -regress_est_blur_epits                                                  \
    -regress_est_blur_errts                                                  \
    -regress_run_clustsim       no                                           \
    -html_review_style          pythonic                                     \
    -execute
EOF

if ( ${status} ) then
    set ecode = 1
    goto COPY_AND_EXIT
endif

# ----- execute AP command to make processing script

tcsh -xef ${run_script} |& tee output.ap.cmd.${subj}

if ( ${status} ) then
    set ecode = 2
    goto COPY_AND_EXIT
endif

# ----- execute the proc script, saving text info

time tcsh -xef proc.${subj} |& tee output.proc.${subj}

if ( ${status} ) then
    set ecode = 3
    goto COPY_AND_EXIT
endif

echo "++ FINISHED ${lab_out}"

# ---------------------------------------------------------------------------

COPY_AND_EXIT:

# ----------------------------- biowulf-cmd --------------------------------
if ( $use_slurm ) then
    # if using /lscratch, copy back to "real" location
    if( ${usetemp} && -d ${sdir_out} ) then
        echo "++ Used /lscratch"
        echo "++ Copy from: ${sdir_out}"
        echo "          to: ${sdir_BW}"
        \cp -pr   ${sdir_out}/* ${sdir_BW}/.

        # reset group permission
        chgrp -R ${grp_own} ${sdir_BW}
    endif
endif
# ---------------------------------------------------------------------------

if ( ${ecode} ) then
    echo "++ BAD FINISH: ${lab_out} (ecode = ${ecode})"
else
    echo "++ GOOD FINISH: ${lab_out}"
endif

exit ${ecode}

