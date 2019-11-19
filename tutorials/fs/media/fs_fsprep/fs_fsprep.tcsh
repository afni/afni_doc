#!/bin/tcsh


# Using imcat


# ===================== Input T1w dataset properties =====================


# Input T1w anatomical volume
set anat_orig = FT_anat+orig.HEAD

# "Verbose" mode of checking all properties: for detailed output.
# Dump output to a file...
check_dset_for_fs.py -input ${anat_orig} -verb > check_fs.txt
# ... and display it
\cat check_fs.txt


# "Scripty" mode of checking all properties: single-number output
# stored in variable
set fs_check = `check_dset_for_fs.py -input ${anat_orig}`

# Check the output
if ( $fs_check ) then
    # Dset passes check
    echo "++ Good to go with FreeSurfer"
    set anat_for_fs = ${anat_orig}
else
    # Dset fails check
    echo "** Shouldn't do FreeSurfer on this dset"
    echo "   Will check among properties for what has gone wrong and"
    echo "   fix each badness appropriately (hopefully)"

    # get the prefix for naming
    set pref = `3dinfo -prefix_noext ${anat_orig}`

    # Sub-check of voxelsize properties: do we need to resample?
    set input_dset   = ${anat_orig} 
    set fs_check_vox = `check_dset_for_fs.py -input ${input_dset}     \
                            -is_vox_05mm_min -is_vox_1mm_max -is_vox_iso`

    # use results of voxelsize check to resample, if necessary
    if ( $fs_check_vox ) then
        3dAllineate                                                   \
            -1Dmatrix_apply  IDENTITY                                 \
            -mast_dxyz       1                                        \
            -final           wsinc5                                   \
            -source          ${input_dset}                            \
            -prefix          ${pref}_00_ISO.nii

        # pass along this dset as the new "input" dset for next step
        set input_dset = ${pref}_00_ISO.nii
    endif

    # use results of matrix check zeropad, if necessary
    set fs_check_mat = `check_dset_for_fs.py -input ${input_dset}     \
                            -is_mat_even`

    # use results of matrix check zeropad, if necessary
    if ( $fs_check_mat ) then
        3dZeropad                                                     \
            -pad2evens                                                \
            -prefix          ${pref}_01_ZP.nii                        \
            ${input_dset}

        # pass along this dset as the new "input" dset for next step
        set input_dset = ${pref}_01_ZP.nii
    endif

    set anat_for_fs = ${input_dset}
endif

@chauffeur_afni                                                       \
    -ulay    ${anat_for_fs}                                           \
    -olay_off                                                         \
    -prefix  ${pref}_image                                            \
    -montx 7 -monty 1                                                 \
    -blowup 4                                                         \
    -set_xhairs OFF                                                   \
    -label_mode 1 -label_size 3                                       \
    -do_clean


# ======================== Running FS's recon-all ========================


echo "++ Ready to start FS"

# NB: this command will take a long time-- typically somewhere between
# 10-20 hours for a standard anatomical brain.
recon-all                                                             \
    -all                                                              \
    -sd       ./                                                      \
    -subjid   FT                                                      \
    -i        ${anat_for_fs}


# ================== Running AFNI's @SUMA_Make_Spec_FS ===================



# Convert FS recon-all output to AFNI/SUMA formats
@SUMA_Make_Spec_FS                                                    \
    -NIFTI                                                            \
    -sid     FT                                                       \
    -fspath  ./FT

