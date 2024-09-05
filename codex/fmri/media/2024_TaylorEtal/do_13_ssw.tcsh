#!/bin/tcsh

# SSW: script to run skullstripping and nonlinear alignment for a subject

# --------------------------- env vars and init ----------------------------

# compress BRIK files
setenv AFNI_COMPRESSOR GZIP

# initial exit code
set ecode = 0

# -------------------------- subject and path info -------------------------

# subject ID
set subj  = sub-002

# script label, mainly for logs
set label = 13_ssw

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
set dset_anat_00 = ${sdir_anat}/${subj}_T1w.nii.gz

# control variables

# check available N_threads and report what is being used
set nthr_avail = `afni_system_check.py -disp_num_cpu`
set nthr_using = `afni_check_omp`

echo "++ INFO: Using ${nthr_using} of available ${nthr_avail} threads"

# ----------------------------- main commands ------------------------------

# run the skullstripping+warping
sswarper2                                                                    \
    -input  ${dset_anat_00}                                                  \
    -base   ${dset_ref}                                                      \
    -subid  ${subj}                                                          \
    -odir   ${sdir_ssw}                                                      \
    |&  tee ${dir_log}/log_${subj}_${label}.txt

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
