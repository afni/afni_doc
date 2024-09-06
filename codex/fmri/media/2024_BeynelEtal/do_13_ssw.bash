#!/bin/bash

# ===========================================================================
# Name:       do_13_ssw.bash
# Author:     LB
# Date:       7/12/22

# Syntax:     bash do_13_ssw.bash SUBJ
# Arguments:  SUBJ: subject ID

# Desc:       This script will run all chosen scans through the 
#             @SSwarper program for skullstripping (SS) and nonlinear
#             alignment (warping) of T1w anatomical to a template
# Req:        1) AFNI
# Notes:      Run this before afni_proc.py, and provide its outputs there.
# ===========================================================================

# Biowulf loading
module load afni

# ------------------------------ get inputs ---------------------------------

if [ "$#" -eq 1 ]; then
   subj=$1
else
   echo "Specify participant ID Please"
   exit 1
fi

# ------------------------------ define paths ---------------------------------

pwd_dir=`pwd`
proj_dir=${pwd_dir%/*}

anatdir=${proj_dir}/Anat/${subj}           # dir with T1w anatomical
funcdir=${proj_dir}/Func/${subj}           # dir with FMRI/EPI
stimdir=${proj_dir}/Behav/${subj}          # dir with stim timing files
analysisdir=${proj_dir}/Analysis/${subj}   # dir with SSW results; output here

MNItemplate=${pwd_dir}/MNI152_2009_template_SSW.nii.gz
echo "++ Template: ${MNItemplate}"

# --------------------------- check input dsets ------------------------------

# anat
if [ -f "${anatdir}/${subj}_T1.nii" ] ; then
cat <<EOF
++ Found T1 of ${subj}... 
EOF

else
cat <<EOF
++ ** ERROR: This participant does not have T1 scan .. EXITING ++
EOF
   exit 1
fi

# --------------------------- run SSW program ------------------------------

cd ${analysisdir}

@SSwarper                                                                    \
    -input  ${anatdir}/${subj}_T1.nii                                        \
    -base   ${MNItemplate}                                                   \
    -subid  ${subj}                                                          \
    -odir   ${analysisdir}

exit 0
