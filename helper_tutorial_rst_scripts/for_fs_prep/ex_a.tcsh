# 1) Note what is off and fix it; also, record info in text file.
check_dset_for_fs.py                       \
    -input           FT_anat+orig          \
    -fix_all                               \
    -fix_out_prefix  FT_anat_fsprep.nii.gz \
    -fix_out_vox_dim 1                     \
    -verb          > check_fsprep.txt

# 2) Run FreeSurfer.
recon-all                                  \
    -all                                   \
    -sd      .                             \
    -subjid  FT                            \
    -i       FT_anat_fsprep.nii.gz

# 3) Import FS results into SUMA-land.
@SUMA_Make_Spec_FS                         \
    -fs_setup                              \
    -NIFTI                                 \
    -sid    FT                             \
    -fspath ./FT

