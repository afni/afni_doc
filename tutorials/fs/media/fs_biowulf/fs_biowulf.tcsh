#!/bin/tcsh


# Run FS *on a cluster* (NIH's Biowulf) with AFNI


# =============================== Overview ===============================



# =========== Module loading FS (and other things) in a script ===========



# ============= Using scratch disks as temporary directories =============



# ======================= A general biowulf script =======================


###  Run this comand with something like
#
#   sbatch                                                            \
#      --partition=norm                                               \
#      --cpus-per-task=4                                              \
#      --mem=4g                                                       \
#      --time=12:00:00                                                \
#      --gres=lscratch:10                                             \
#      do_*.tcsh
#
# ===================================================================

source /etc/profile.d/modules.csh
module load afni freesurfer
source $FREESURFER_HOME/SetUpFreeSurfer.csh

set dset     = anat_02_anon.reface.nii.gz
set subj     = sub_02
set dir_fs   = group_fs
set dir_echo = .

# ---------------- Biowulf slurm check and initializing ----------------

# Set thread count if we are running SLURM
if ( $?SLURM_CPUS_PER_TASK ) then
  setenv OMP_NUM_THREADS $SLURM_CPUS_PER_TASK
endif

# Set temporary output directory; then requires using something like
# this on the swarm command line: --sbatch '--gres=lscratch:50'.
# These variables used again *after* the main commands, if running
# on Biowulf.
if( $?SLURM_JOBID ) then
  set tempdir = /lscratch/$SLURM_JOBID/${subj}
  set usetemp = 1
else
  set tempdir = ${dir_fs}
  set usetemp = 0
endif

\mkdir -p ${tempdir}

# record any failures; def: no errors
set EXIT_CODE = 0

# ---------------------- Run programs of interest ----------------------

set nomp   = `afni_check_omp`
echo "++ Should be using this many threads: ${nomp}"                  \
     > ${dir_echo}/o.00_fs_${subj}.txt


time recon-all                                                        \
    -all                                                              \
    -sd      ${tempdir}                                               \
    -subjid  ${subj}                                                  \
    -i       ${dset}                                                  \
    -parallel                                                         \
    |& tee -a ${dir_echo}/o.00_fs_${subj}.txt

if ( $status ) then
    echo "** ERROR running FS recon-all"                              \
        |& tee -a ${dir_echo}/o.00_fs_${subj}.txt
    set EXIT_CODE = 1
    goto JUMP_EXIT
else
    echo "++ GOOD run of FS recon-all"                                \
        |& tee -a ${dir_echo}/o.00_fs_${subj}.txt
endif


@SUMA_Make_Spec_FS                                                    \
    -fs_setup                                                         \
    -NIFTI                                                            \
    -sid    ${subj}                                                   \
    -fspath ${tempdir}/${subj}                                        \
    |& tee  ${dir_echo}/o.01_suma_makespec_${subj}.txt

if ( $status ) then
    echo "** ERROR running @SUMA_Make_Spec_FS"                        \
        |& tee -a ${dir_echo}/o.01_suma_makespec_${subj}.txt
    set EXIT_CODE = 2
    goto JUMP_EXIT
else
    echo "++ GOOD run of @SUMA_Make_Spec_FS"                          \
        |& tee -a ${dir_echo}/o.01_suma_makespec_${subj}.txt
endif

# ===================================================================

JUMP_EXIT:

# ---------------- Biowulf slurm finish and copying ----------------

# Again, Biowulf-running considerations: if processing went fine and
# we were using a temporary directory, copy data back.
if( $usetemp && -d ${tempdir} ) then
    echo "++ Copy from: ${tempdir}" 
    echo "          to: ${dir_fs}"
    \mkdir -p ${dir_fs}
    \cp -pr ${tempdir}/* ${dir_fs}/.
endif

# ----------------------------------------------------------------------

if ( $EXIT_CODE ) then
    echo "** Something failed in Step ${EXIT_CODE} for subj: ${subj}"
else
    echo "++ Copy complete for subj: ${subj}" 
endif

# ===================================================================


# =================== Looping over a group of subjects ===================


