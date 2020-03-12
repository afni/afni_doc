# 1) Run FreeSurfer.
recon-all                                  \
    -all                                   \
    -sd      .                             \
    -subjid  FT                            \
    -i       FT_anat_fsprep.nii.gz

# 2) Import FS results into SUMA-land.
@SUMA_Make_Spec_FS                         \
    -fs_setup                              \
    -NIFTI                                 \
    -sid    FT                             \
    -fspath ./FT

