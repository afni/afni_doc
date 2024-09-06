#!/bin/tcsh

# AP simple: run afni_proc.py for full FMRI processing (for initial QC)
# -> run the ME-FMRI simple command here

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
set ap_label       = 20_ap_simple


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
set dset_epi_e2   = ( ${epi_radix}_${task_label}_echo-2_bold.nii* )
set dsets_epi_me  = ( ${epi_radix}_${task_label}_echo-?_bold.nii* )
set me_times      = ( 12.5 27.6 42.7 )

set dset_anat_00  = ${sdir_anat}/${subj}_${ses}_mprage_run-1_T1w.nii.gz

# control variables
set nt_rm         = 4       # number of time points to remove at start
#set blur_size     = 6       # blur size to apply 
#set final_dxyz    = 3       # final voxel size (isotropic dim)
#set cen_motion    = 0.2     # censor threshold for motion (enorm) 
#set cen_outliers  = 0.05    # censor threshold for outlier frac


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

# AP, run simple
#
# multi-echo FMRI, simple processing for initial QC
# anatomical has skull on

ap_run_simple_rest_me.tcsh                                             \
    -run_ap                                                            \
    -subjid      ${subj}                                               \
    -nt_rm       ${nt_rm}                                              \
    -anat        ${dset_anat_00}                                       \
    -epi_me_run  ${dsets_epi_me}                                       \
    -echo_times  ${me_times}                                           \
    -template    ${template}

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

