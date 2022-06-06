#!/bin/tcsh 

# The @SSwarper command used to perform anatomical dataset
# skullstripping (SS) and nonlinear alignment (warp) estimation to a
# reference template.
#
# Used for processing in: 
#
#    Atlas LY, Dildine TC, Palacios-Barrios EE, Yu Q, Reynolds RC,
#    Banker LA, Grant SS, Pine DS (2022). Instructions and
#    experiential learning have similar impacts on pain and
#    pain-related brain responses but produce dissociations in
#    value-based reversal learning. (submitted)
#    https://www.biorxiv.org/content/10.1101/2021.08.25.457682v1
#
# To run for a single subject, type (while providing actual values for
# SUBJ_ID and DATA_DIR):
#
#    tcsh s1.2022_AtlasEtal_ssw.tcsh  SUBJ_ID  DATA_DIR
# 
# ===========================================================================

# user inputs 
set subj     = "$1"           # subject ID
set data_dir = "$2"           # path to datasets

set template = MNI152_2009_template_SSW.nii.gz

# set some environment variables
setenv AFNI_COMPRESSOR GZIP
setenv OMP_NUM_THREADS 16

cd ${data_dir}

# run skullstripping+warping
@SSwarper                                                                \
    -input  anat_${subj}.nii                                             \
    -base   ${template}                                                  \
    -subid  ${subj}                                                      \
    |& tee  log.ssw_${subj}.txt
