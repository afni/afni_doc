#!/bin/bash
#SBATCH --account=def-jgotman
#SBATCH --job-name=sub-ep0568_FSSUMA.job
#SBATCH --output=/scratch/djangoc/EP_EEGfMRI_deconvolution/sub-ep0568_FSSUMA.out
#SBATCH --error=/scratch/djangoc/EP_EEGfMRI_deconvolution/sub-ep0568_FSSUMA.err
#SBATCH --time=5:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=4G
#SBATCH --mail-user=zhengchen.cai@gmail.com
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL

export FREESURFER_HOME=$HOME/freesurfer

source $FREESURFER_HOME/SetUpFreeSurfer.sh

module load StdEnv/2020  gcc/9.3.0 afni/23.1.08

p1=/scratch/djangoc/EP_EEGfMRI_deconvolution/derivatives/freesurfer_AFNIUAC
p2=/home/djangoc/projects/def-jgotman/djangoc/EP_EEGfMRI_deconvolution
p3=${p2}/derivatives/afni/sub-ep0568/anat

recon-all                                     \
    -all                                      \
    -3T                                       \
    -sd        ${p1}                          \
    -subjid    sub-ep0568                     \
    -i         ${p3}/anatUAC.sub-ep0568.nii   \
    -parallel

@SUMA_Make_Spec_FS                            \
    -fs_setup                                 \
    -NIFTI                                    \
    -sid       sub-ep0568                     \
    -fspath    ${p1}/sub-ep0568

