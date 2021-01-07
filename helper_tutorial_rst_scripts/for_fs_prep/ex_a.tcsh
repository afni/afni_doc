# 0) Copy data to NIFTI format (if necessary):
3dcopy FT_anat+orig.HEAD FT_anat_cp.nii.gz

# 1) Run FreeSurfer.
recon-all                                  \
    -all                                   \
    -sd      .                             \
    -subjid  FT                            \
    -i       FT_anat_cp.nii.gz

# 2) Import FS results into SUMA-land.
@SUMA_Make_Spec_FS                         \
    -fs_setup                              \
    -NIFTI                                 \
    -sid    FT                             \
    -fspath ./FT

