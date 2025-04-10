#!/bin/tcsh

# Do some preprocesses on anatomical images: FreeSurfer parcellation,
# and AFNI skullstripping and nonlinear alignment to template.
#
# NB: Below, @SSwarper is used to perform both skullstripping (SS) of
# the subject anatomical and nonlinear alignment (warping) of it to
# template space. There is a newer version of this program now
# available: sswarper2. It is meant to be a direct replacement and
# update, and the I/O syntax is nearly identical.

# From:
# 
#  Yue Q, Newton AT, Marois R (2025). Ultrafast fMRI reveals serial
#  queuing of information processing during multitasking in the human
#  brain. Nat Commun 16(1):3057.
#  https://pmc.ncbi.nlm.nih.gov/articles/PMC11953464/

# ===============================================================================

# list of all subject IDs
set all_sub = ( s773 )

foreach sub ( ${all_sub} ) # 

    ## 1. run-Freesurfer

    cd /Volumes/Seagate/prp_data/${sub}/

    3dcopy ${sub}_anat+orig ${sub}_anat.nii

    recon-all                                                                    \
        -i    ${sub}_anat.nii                                                    \
        -s    ${sub}                                                             \
        -sd   /Volumes/Seagate/prp_data/freesurfer/                              \
        -all

    cd /Volumes/Seagate/prp_data/freesurfer/${sub}/
    @SUMA_Make_Spec_FS -NIFTI -sid ${sub}


    ## 2. get some masks from segmentation

    cd /Volumes/Seagate/prp_data/freesurfer/${sub}/SUMA

    # ventricle
    3dcalc                                                                       \
        -a       aseg.nii                                                        \
        -expr    'amongst(a,4,5,14,31,43,44,63)'                                 \
        -prefix  ${sub}_anat_Vent_mask

    # WM
    3dcalc                                                                       \
        -a       aseg.nii                                                        \
        -expr    'amongst(a,2,41,77,251,252,253,254,255)'                        \
        -prefix  ${sub}_anat_WM_mask

    3dcopy                                                                       \
        ${sub}_anat_Vent_mask+orig                                               \
        /Volumes/Seagate/prp_data/${sub}/${sub}_anat_Vent_mask
    3dcopy                                                                       \
        ${sub}_anat_WM_mask+orig                                                 \
        /Volumes/Seagate/prp_data/${sub}/${sub}_anat_WM_mask

    3dcopy ${sub}_SurfVol.nii /Volumes/Seagate/prp_data/${sub}/${sub}_SurfVol

    # get an anatomical parcellation mask, which is used to estimate
    # parameters for subject-specific HRF

    3dcalc                                                                       \
        -a       aparc.a2009s+aseg_REN_gm.nii                                    \
        -expr    'equals(a,116)'                                                 \
        -prefix  ${sub}_FS_lPreCS.inf_mask
    3dcopy                                                                       \
        ${sub}_FS_lPreCS.inf_mask+orig                                           \
        /Volumes/Seagate/prp_data/${sub}/${sub}_FS_lPreCS.inf_mask


    ## 3. preprocess anatomical image

    cd /Volumes/Seagate/prp_data/${sub}/

    @SSwarper                                                                    \
        -input     ${sub}_SurfVol+orig                                           \
        -subid     ${sub}                                                        \
        -odir      ${sub}_anat_warped                                            \
        -base      MNI152_2009_template_SSW.nii.gz                               \
        -skipwarp

    cd /Volumes/Seagate/prp_data/${sub}/${sub}_anat_warped/
    3dcopy anatSS.${sub}.nii ../${sub}_SurfVol_SS

end



