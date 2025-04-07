#!/bin/tcsh

# For this study, all analyses are conducted in each participant's
# native brain space (i.e. aligned to in-session anatomical MPRAGE)
# and displayed on the common mesh in SUMA for any group analyses

# This script contains the afni_proc.py command used to process
# task-based multi-echo multiband fMRI data in the below study. A
# dummy 'regress' block is included to generate AFNI QC files, however
# 3dDecolvolve is run separately in later scripts as the betas are
# analyzed differently depending on the analysis and run type
# (i.e. block design of localizer runs vs. event related design of
# experimental runs, single beta estimate per condition for univariate
# analyses vs. one beta estimate per condition per run for
# multivariate analyses).  Here the raw data is preprocessed in the
# order collected for motion correction and alignment to the
# in-session anatomical.

# Used for processing in: 
#
#   Wardle, S. G., Rispoli, B., Roopchansingh, V. & Baker, C. (2024)
#   Brief encounters with real objects modulate medial parietal but
#   not occipitotemporal cortex. bioRxiv. 2024.08.05.606667
#   https://doi.org/10.1101/2024.08.05.606667

# To run for a single participant, type (while providing an actual
# value for P_ID):
#
#   tcsh s1.afni_proc.tcsh P_ID

# =============================================================================

# collect user input
if ( $#argv > 0 ) then
    set pname = $argv[1]
else
    echo 'WARNING: NO PARTICIPANT IS ENTERED'
endif

# specify project directory 
set myroot = <INSERT PROJECT HOME DIRECTORY>

# define directories
set input_root  = ${myroot}/rawdata/rawMRI
set subdir      = ${input_root}/${pname}
set output_root = ${myroot}/preprocessed
set suboutdir   = ${output_root}/${pname}

# print into terminal
echo ${subdir}
echo ${pname}
echo ${input_root}

# create the output root directory if it doesn't exist
# nb: don't create the subject directory here because afni_proc.py will
\mkdir -pv $output_root
echo $output_root

cd $subdir

# generate the afni_proc.py script for this participant, for multiecho
# FMRI processing

# Notes
#
# + This command includes reverse phase encoding for EPI distortion
#   correction (`-blip_* ..` options)
#
# + AFNI's formulation for the optimal combination (OC; Posse et al.,
#   1999) of multiple echos is used (`-combine_method OC`)
#
# + The 'regress' block is included to enable the QC HTML to be made,
#   but the actual regression commands are run later/separately, so no
#   `-regress_* ..` options were used here
#

afni_proc.py                                                                 \
    -subj_id                ${pname}                                         \
    -script                 ${subdir}proc.${pname}                           \
    -out_dir                ${suboutdir}                                     \
    -dsets_me_echo          ${pname}*tSeries*e01*orig.HEAD                   \
    -dsets_me_echo          ${pname}*tSeries*e02*orig.HEAD                   \
    -dsets_me_echo          ${pname}*tSeries*e03*orig.HEAD                   \
    -echo_times             12.9 32.228 51.556                               \
    -reg_echo               2                                                \
    -copy_anat              ${subdir}/*anat.nii                              \
    -blocks                 tshift align volreg blur mask combine regress    \
    -tcat_remove_first_trs  8 8 8 8 8 8 8 8 8 8                              \
    -blip_forward_dset      ${pname}blip_forward-e02*orig.HEAD               \
    -blip_reverse_dset      ${pname}blip_reverse-e02*orig.HEAD               \
    -volreg_align_to        MIN_OUTLIER                                      \
    -volreg_align_e2a                                                        \
    -blur_size              4                                                \
    -combine_method         OC                                               \

# run the afni_proc.py script for this participant
tcsh -xef ${subdir}proc.${pname} |& tee ${subdir}output.proc.${pname}
