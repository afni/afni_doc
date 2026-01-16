#!/bin/bash
#SBATCH --account=def-jgotman
#SBATCH --job-name=sub-ep0568_SSwarper.job
#SBATCH --output=/scratch/djangoc/EP_EEGfMRI_deconvolution/sub-ep0568_SSwarper.out
#SBATCH --error=/scratch/djangoc/EP_EEGfMRI_deconvolution/sub-ep0568_SSwarper.err
#SBATCH --time=3:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=4G
#SBATCH --mail-user=zhengchen.cai@gmail.com
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL

module load StdEnv/2020  gcc/9.3.0 afni/23.1.08

p2=/home/djangoc/projects/def-jgotman/djangoc/EP_EEGfMRI_deconvolution
p4=/scratch/djangoc/EP_EEGfMRI_deconvolution/sub-ep0568/anat

time @SSwarper                                                               \
    -tmp_name_nice                                                           \
    -base           ${p2}/derivatives/MNI152_2009_template_SSW.nii.gz        \
    -subid          sub-ep0568                                               \
    -input          ${p2}/sub-ep0568/anat/sub-ep0568_T1w.nii.gz              \
    -odir           ${p4}

