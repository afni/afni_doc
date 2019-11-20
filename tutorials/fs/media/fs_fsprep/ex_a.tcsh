# note what is off, just to be aware
check_dset_for_fs.py -input FT_anat+orig -verb

# resample to 1 mm^3 voxels, then pad to even numbers of voxels
3dAllineate -1Dmatrix_apply IDENTITY -mast_dxyz 1 -final wsinc5       \
    -source FT_anat+orig -prefix FT_1mm.nii
3dZeropad -pad2evens -prefix FT_anat_FSprep.nii FT_1mm.nii

# run FreeSurfer...
recon-all -all -subject FT -i FT_anat_FSprep.nii
# ... and import into SUMA-land
@SUMA_Make_Spec_FS -sid FT -NIFTI -fspath ./FT