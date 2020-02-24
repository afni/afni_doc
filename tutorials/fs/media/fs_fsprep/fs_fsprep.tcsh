#!/bin/tcsh


# How to use FS recon-all with AFNI


# ======= Surprising requirements for T1w input to FS's recon-all ========



# =============== Description: AFNI's check_dset_for_fs.py ===============



# ===================== Running check_dset_for_fs.py =====================


# Simple check
check_dset_for_fs.py -input FT_anat+orig.HEAD

# Verbose check. Redirect the text output to a file 
check_dset_for_fs.py -input FT_anat+orig.HEAD -verb > check_fs_prep.txt

# Verbose check AND fix the dset
check_dset_for_fs.py                                                  \
    -input           FT_anat+orig                                     \
    -fix_all                                                          \
    -fix_out_prefix  FT_anat_fsprep.nii.gz                            \
    -verb            > check_fix_fsprep.txt


# ============= How does check_dset_for_fs.py fix the data? ==============


set pref       = FT_anat
set input_dset = ${pref}+orig
set pref       = ${pref}

3dAllineate                                                           \
    -1Dmatrix_apply  IDENTITY                                         \
    -mast_dxyz       1                                                \
    -final           wsinc5                                           \
    -source          ${input_dset}                                    \
    -prefix          ${pref}_00_ISO.nii

3dZeropad                                                             \
    -pad2evens                                                        \
    -prefix          ${pref}_01_ZP.nii                                \
    ${input_dset}


# ====================== Start-to-finish FS example ======================



# ================== A note of filenames/paths with FS ===================



# ================= A note on @SUMA_Make_Spec_FS outputs =================


