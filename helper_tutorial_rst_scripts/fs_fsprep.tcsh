#!/bin/tcsh


# How to use FS recon-all with AFNI


# ====================== Start-to-finish FS example ======================


# 0) Copy data to NIFTI format (if necessary):
3dcopy FT_anat+orig.HEAD FT_anat_cp.nii.gz

# 1) Run FreeSurfer.
recon-all                                                             \
    -all                                                              \
    -sd      .                                                        \
    -subjid  FT                                                       \
    -i       FT_anat_cp.nii.gz

# 2) Import FS results into SUMA-land (and standardize surfaces).
@SUMA_Make_Spec_FS                                                    \
    -fs_setup                                                         \
    -NIFTI                                                            \
    -sid    FT                                                        \
    -fspath ./FT


# ================== A note of filenames/paths with FS ===================



# ================= A note on @SUMA_Make_Spec_FS outputs =================

