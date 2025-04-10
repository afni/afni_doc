#!/bin/tcsh

# Generate script for preprocessing functional images (including
# GLM1), via afni_proc.py

# From:
# 
#  Yue Q, Newton AT, Marois R (2025). Ultrafast fMRI reveals serial
#  queuing of information processing during multitasking in the human
#  brain. Nat Commun 16(1):3057.
#  https://pmc.ncbi.nlm.nih.gov/articles/PMC11953464/

# ===========================================================================

# set paths 
set topdir = /Volumes/Seagate/prp_data

# list of all subject IDs
set all_sub = ( s773 )

foreach sub ( ${all_sub} ) # loop over all subject IDs

    # per subject directory with timing info
    set sdir_timing = ${topdir}/timing/${sub}

    cd ${topdir}/${sub}

    # Comments on processing
    #
    # a. Use anatomical skullstrip results from @SSwarper (also now sswarper2
    #    is available);
    # b. No tshift here as all slices are obtained simultaneously;
    # c. No blur to preserve the spatial variances across neighboring voxels;
    # d. Include 6 PCs from ventricles and 6 PCs from eroded WM in the 
    #    regression model to account for physiological noises;
    # e. Include both demeaned and derivatives of motion parameters in the
    #    regression model;
    # f. Not only censor motion, but also TRs when more than 10% of the voxels
    #    are detected as outliers;
    # g. Run regression model via 3dREMLfit to address the temporal 
    #    autocorrelation issue for the fast fMRI data.
    # h. In this special dataset case, the final processing of all
    #    runs together had 16,000 time points, so HTML creation was
    #    turned off by adding '-html_review_style none', relying on
    #    early QC checks and additional ones after the full run.

    afni_proc.py                                                             \
        -subj_id                  ${sub}                                     \
        -script                   proc.task.${sub}.correct_noblur_REML       \
        -out_dir                  results.task.${sub}.correct_noblur_REML    \
        -dsets                    ${sub}_task01+orig ${sub}_task02+orig      \
                                  ${sub}_task03+orig ${sub}_task04+orig      \
                                  ${sub}_task05+orig ${sub}_task06+orig      \
                                  ${sub}_task07+orig ${sub}_task08+orig      \
                                  ${sub}_task09+orig ${sub}_task10+orig      \
        -copy_anat                ${sub}_SurfVol_SS+orig                     \
        -anat_has_skull           no                                         \
        -anat_follower_ROI        anat_WM epi ${sub}_anat_WM_mask+orig       \
        -anat_follower_ROI        anat_Vent epi ${sub}_anat_Vent_mask+orig   \
        -anat_follower_erode      anat_WM                                    \
        -blocks                   align volreg mask scale regress            \
        -tcat_remove_first_trs    0                                          \
        -volreg_align_to          MIN_OUTLIER                                \
        -align_opts_aea           -cost lpc+ZZ                               \
                                  -giant_move                                \
                                  -cmass cmass                               \
        -volreg_align_e2a                                                    \
        -volreg_warp_master       ${sub}_task01+orig                         \
        -mask_apply               anat                                       \
        -regress_stim_times       ${sdir_timing}/AO_correct.1D               \
                                  ${sdir_timing}/AO_response_correct.1D      \
                                  ${sdir_timing}/VM_correct.1D               \
                                  ${sdir_timing}/VM_response_correct_left.1D \
                                  ${sdir_timing}/VM_response_correct_right.1D \
                                  ${sdir_timing}/S_AOVM_correct.1D           \
                                  ${sdir_timing}/S_VMAO_correct.1D           \
                                  ${sdir_timing}/L_AOVM_correct.1D           \
                                  ${sdir_timing}/L_VMAO_correct.1D           \
                                  ${sdir_timing}/AO_incorrect.1D             \
                                  ${sdir_timing}/AO_response_incorrect.1D    \
                                  ${sdir_timing}/VM_incorrect.1D             \
                                  ${sdir_timing}/VM_response_incorrect.1D    \
                                  ${sdir_timing}/S_AOVM_incorrect.1D         \
                                  ${sdir_timing}/S_VMAO_incorrect.1D         \
                                  ${sdir_timing}/L_AOVM_incorrect.1D         \
                                  ${sdir_timing}/L_VMAO_incorrect.1D         \
        -regress_local_times                                                 \
        -regress_stim_labels      AO_c AO_resp_c VM_c VM_resp_c_left         \
                                  VM_resp_c_right S_AOVM_c S_VMAO_c L_AOVM_c \
                                  L_VMAO_c AO_inc AO_resp_inc VM_inc         \
                                  VM_resp_inc S_AOVM_inc S_VMAO_inc          \
                                  L_AOVM_inc L_VMAO_inc                      \
        -regress_basis_multi      'TWOGAMpw(4,3,0.2,7.5,3)'                  \
                                  'TWOGAMpw(4,3,0.2,7.5,3)'                  \
                                  'TWOGAMpw(4,3,0.2,7.5,3)'                  \
                                  'TWOGAMpw(4,3,0.2,7.5,3)'                  \
                                  'TWOGAMpw(4,3,0.2,7.5,3)'                  \
                                  'TWOGAMpw(4,3,0.2,7.5,3)'                  \
                                  'TWOGAMpw(4,3,0.2,7.5,3)'                  \
                                  'TWOGAMpw(4,3,0.2,7.5,3)'                  \
                                  'TWOGAMpw(4,3,0.2,7.5,3)'                  \
                                  'TWOGAMpw(4,3,0.2,7.5,3)'                  \
                                  'TWOGAMpw(4,3,0.2,7.5,3)'                  \
                                  'TWOGAMpw(4,3,0.2,7.5,3)'                  \
                                  'TWOGAMpw(4,3,0.2,7.5,3)'                  \
                                  'TWOGAMpw(4,3,0.2,7.5,3)'                  \
                                  'TWOGAMpw(4,3,0.2,7.5,3)'                  \
                                  'TWOGAMpw(4,3,0.2,7.5,3)'                  \
                                  'TWOGAMpw(4,3,0.2,7.5,3)'                  \
        -regress_ROI_PC           anat_Vent 6                                \
        -regress_ROI_PC           anat_WM 6                                  \
        -regress_censor_motion    0.3                                        \
        -regress_censor_outliers  0.1                                        \
        -regress_apply_mot_types  demean deriv                               \
        -regress_opts_3dD         -jobs 6                                    \
                                  -num_glt 15                                \
                                  -gltsym                                    \
                                  'SYM: S_AOVM_c -AO_c -AO_resp_c -VM_c -VM_resp_c_left -VM_resp_c_right' \
                                  -glt_label 1 S_AOVM.vs.single              \
                                  -gltsym                                    \
                                  'SYM: S_VMAO_c -AO_c -AO_resp_c -VM_c -VM_resp_c_left -VM_resp_c_right' \
                                  -glt_label 2 S_VMAO.vs.single              \
                                  -gltsym                                    \
                                  'SYM: L_AOVM_c -AO_c -AO_resp_c -VM_c -VM_resp_c_left -VM_resp_c_right' \
                                  -glt_label 3 L_AOVM.vs.single              \
                                  -gltsym                                    \
                                  'SYM: L_VMAO_c -AO_c -AO_resp_c -VM_c -VM_resp_c_left -VM_resp_c_right' \
                                  -glt_label 4 L_VMAO.vs.single              \
                                  -gltsym                                    \
                                  'SYM: 0.5*S_AOVM_c 0.5*S_VMAO_c -AO_c -AO_resp_c -VM_c -VM_resp_c_left -VM_resp_c_right' \
                                  -glt_label 5 S_dual.vs.single              \
                                  -gltsym                                    \
                                  'SYM: 0.5*L_AOVM_c 0.5*L_VMAO_c -AO_c -AO_resp_c -VM_c -VM_resp_c_left -VM_resp_c_right' \
                                  -glt_label 6 L_dual.vs.single              \
                                  -gltsym 'SYM: S_AOVM_c -L_AOVM_c'          \
                                  -glt_label 7 S.vs.L_AOVM                   \
                                  -gltsym 'SYM: S_VMAO_c -L_VMAO_c'          \
                                  -glt_label 8 S.vs.L_VMAO                   \
                                  -gltsym                                    \
                                  'SYM: S_AOVM_c S_VMAO_c -L_AOVM_c -L_VMAO_c' \
                                  -glt_label 9 S.vs.L_dual                   \
                                  -gltsym 'SYM: AO_c -VM_c'                  \
                                  -glt_label 10 AO.vs.VM                     \
                                  -gltsym 'SYM: AO_resp_c -VM_resp_c_left'   \
                                  -glt_label 11 AO_resp.vs.VM_resp_left      \
                                  -gltsym 'SYM: AO_resp_c -VM_resp_c_right'  \
                                  -glt_label 12 AO_resp.vs.VM_resp_right     \
                                  -gltsym                                    \
                                  'SYM: AO_resp_c -VM_resp_c_left -VM_resp_c_right' \
                                  -glt_label 13 AO_resp.vs.VM_resp           \
                                  -gltsym                                    \
                                  'SYM: VM_resp_c_left VM_resp_c_right'      \
                                  -glt_label 14 VM_resp                      \
                                  -gltsym                                    \
                                  'SYM: VM_resp_c_left -VM_resp_c_right'     \
                                  -glt_label 15 VM_resp_left.vs.right        \
        -regress_3dD_stop                                                    \
        -regress_reml_exec                                                   \
        -regress_run_clustsim     no

    # run the generated script for preprocessing and GLM1 (with REML
    # approach), with log file generated
    tcsh -xef proc.task.${sub}.correct_noblur_REML                           \
        |& tee output.proc.task.${sub}.correct_noblur_REML

end


