#!/bin/bash
#SBATCH --account=def-jgotman
#SBATCH --job-name=sub-ep0568_afniproc_TENT_orig_dm.job
#SBATCH --output=/scratch/djangoc/EP_EEGfMRI_deconvolution/derivatives/afni/sub-ep0568_TENT_orig_dm.out
#SBATCH --error=/scratch/djangoc/EP_EEGfMRI_deconvolution/derivatives/afni/sub-ep0568_TENT_orig_dm.err
#SBATCH --time=5:00:00
#SBATCH --cpus-per-task=16
#SBATCH --mem-per-cpu=4G
#SBATCH --mail-user=zhengchen.cai@gmail.com
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL

module load StdEnv/2020  gcc/9.3.0 afni/23.1.08

p1=/scratch/djangoc/EP_EEGfMRI_deconvolution/derivatives/freesurfer_AFNIUAC
p2=/home/djangoc/projects/def-jgotman/djangoc/EP_EEGfMRI_deconvolution
p3=${p2}/derivatives/afni/sub-ep0568/anat
p5=${p2}/derivatives/afni/sub-ep0568/cavity
p6=${p2}/derivatives/afni/sub-ep0568/events
p7=${p2}/sub-ep0568/func
p8=/scratch/djangoc/EP_EEGfMRI_deconvolution/derivatives/afni/sub-ep0568

afni_proc.py                                                                 \
    -subj_id                    sub-ep0568                                   \
    -out_dir                    ${p8}/TENT_orig_dm                           \
    -script                     ${p8}/script/proc.sub-ep0568_TENT_orig_dm    \
    -blocks                     despike tshift align volreg mask blur scale  \
                                regress                                      \
    -dsets                      ${p7}/sub-ep0568_task-spike_run-1_bold.nii.gz \
                                ${p7}/sub-ep0568_task-spike_run-2_bold.nii.gz \
                                ${p7}/sub-ep0568_task-spike_run-3_bold.nii.gz \
                                ${p7}/sub-ep0568_task-spike_run-4_bold.nii.gz \
                                ${p7}/sub-ep0568_task-spike_run-5_bold.nii.gz \
                                ${p7}/sub-ep0568_task-spike_run-6_bold.nii.gz \
                                ${p7}/sub-ep0568_task-spike_run-7_bold.nii.gz \
                                ${p7}/sub-ep0568_task-spike_run-8_bold.nii.gz \
                                ${p7}/sub-ep0568_task-spike_run-9_bold.nii.gz \
                                ${p7}/sub-ep0568_task-spike_run-10_bold.nii.gz \
    -copy_anat                  ${p3}/anatSS.sub-ep0568.nii                  \
    -anat_has_skull             no                                           \
    -anat_follower              anat_w_skull anat                            \
                                ${p2}/sub-ep0568/anat/sub-ep0568_T1w.nii.gz  \
    -anat_follower_ROI          FS_REN_epi epi                               \
                                ${p1}/sub-ep0568/SUMA/aparc.a2009s+aseg_REN_all.nii.gz \
    -anat_follower_ROI          resection_25_01_2018_epi epi                 \
                                ${p5}/sub-ep0568_postsurgical_resection_25_01_2018_space-AFNISS.nii \
    -anat_follower_ROI          resection_23_01_2010_epi epi                 \
                                ${p5}/sub-ep0568_postsurgical_resection_23_01_2010_space-AFNISS.nii \
    -tcat_remove_first_trs      3                                            \
    -radial_correlate_blocks    tcat volreg                                  \
    -volreg_align_to            MIN_OUTLIER                                  \
    -volreg_align_e2a                                                        \
    -align_opts_aea             -check_flip -cost lpc+ZZ                     \
                                -giant_move -AddEdge                         \
    -align_unifize_epi          local                                        \
    -mask_epi_anat              yes                                          \
    -mask_opts_automask         -clfrac 0.1                                  \
                                -dilate 1                                    \
    -blur_in_mask               yes                                          \
    -blur_size                  6.5                                          \
    -blur_to_fwhm                                                            \
    -regress_stim_times         ${p6}/sub-ep0568_type1_dm.1D                 \
                                ${p6}/sub-ep0568_type2_dm.1D                 \
    -regress_stim_labels        type1 type2                                  \
    -regress_stim_times_offset  -5.25                                        \
    -regress_basis              'TENT(0,25.5,18)'                            \
    -regress_stim_types         AM1 AM1                                      \
    -regress_local_times                                                     \
    -regress_motion_per_run                                                  \
    -regress_censor_motion      0.5                                          \
    -regress_censor_outliers    0.05                                         \
    -regress_compute_fitts                                                   \
    -regress_make_ideal_sum     sum_ideal.1D                                 \
    -regress_est_blur_epits                                                  \
    -regress_est_blur_errts                                                  \
    -regress_run_clustsim       yes                                          \
    -regress_reml_exec                                                       \
    -regress_opts_reml          -GOFORIT 99                                  \
    -regress_opts_3dD           -bout -jobs 16                               \
                                -allzero_OK                                  \
                                -GOFORIT 99                                  \
    -regress_3dD_stop                                                        \
    -html_review_style          pythonic

time tcsh -xef  ${p8}/script/proc.sub-ep0568_TENT_orig_dm                    \
     2>&1 | tee ${p8}/script/output.sub-ep0568_TENT_orig_dm

