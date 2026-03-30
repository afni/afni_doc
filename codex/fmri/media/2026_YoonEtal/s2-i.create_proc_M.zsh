#!/bin/zsh

# run afni_proc.py to perform full single subject regression
# 
# This script demonstrates how to construct a single subject
# afni_proc.py pipeline for the memory condition including EPI
# distortion correction and nonlinear standard space
# registration. Running this script automatically creates an
# afni_proc.py directory and generates the proc.TMN01 execution script
# inside it.
# 
# Execution: 
#    
#    zsh s2-i.create_proc_M.zsh -s TMN01
# 
# The above command creates proc.TMN01. This is the generated
# execution script running the full preprocessing steps for one
# subject.  It is then executed, for example, with:
#
#    tcsh -xef proc.TMN01 |& tee output.proc.TMN01
#
#
## ==================================================== ##

## $# = the number of arguments
while (( $# )); do
   key="$1"
   case $key in
      -s | --subject)
         subj="$2"
      ;;
   esac
   shift ##takes one argument
done

## ==================================================== ##

dir_root="/mnt/ext4/TMN/fmri_data"
dir_raw="$dir_root/raw_data/$subj"
dir_nifti="$dir_raw/convert_data/$subj"
dir_preproc="$dir_root/preproc_data/M/$subj"

dir_script="/home/harry/TM_pj/Experiment/afni_proc.py"
if [ ! -d "$dir_script" ]; then
   mkdir -p -m 755 "$dir_script"
fi

dir_output="$dir_preproc"

## ==================================================== ##

dsets=($(find "$dir_nifti" -type f -name "func.M.r??.$subj.nii" | sort))

## ==================================================== ##

cd "$dir_script"  # Only if needed; otherwise, remove this line

# Notes on options, for resting state FMRI processing
#
# + blip up/down (=reverse phase-encoded) datasets are used to reduce 
#   distortion due to B0 inhomogeneity
# + LFF-based bandpassing is _not_ used, to preserve degrees of freedom
# + while typically the lpc+ZZ cost function is used to align the EPI and 
#   anatomical datasets, in this case the lpa cost function performed well
# + nonlinear alignment and anatomical skullstripping are both
#   performed within this command, but these could be done beforehand
#   with sswarper2, passing the results to afni_proc.py

afni_proc.py                                                                 \
    -subj_id                  "$subj"                                        \
    -out_dir                  "$dir_output"                                  \
    -blocks                   despike tshift align tlrc volreg blur mask     \
                              scale regress                                  \
    -copy_anat                "$dir_nifti/T1.$subj.nii"                      \
    -anat_has_skull           yes                                            \
    -anat_uniform_method      unifize                                        \
    -anat_unif_GM             yes                                            \
    -dsets                    $dsets                                         \
    -radial_correlate_blocks  tcat volreg                                    \
    -tcat_remove_first_trs    0                                              \
    -blip_forward_dset        "$dir_nifti/func.M.r01.$subj.nii"              \
    -blip_reverse_dset        "$dir_nifti/func.REV.$subj.nii"                \
    -align_opts_aea           -cost lpa                                      \
                              -giant_move                                    \
                              -check_flip                                    \
    -tlrc_NL_warp                                                            \
    -tlrc_base                MNI152_2009_template_SSW.nii.gz                \
    -volreg_align_to          MIN_OUTLIER                                    \
    -volreg_align_e2a                                                        \
    -volreg_tlrc_warp                                                        \
    -blur_size                4.0                                            \
    -mask_epi_anat            yes                                            \
    -regress_motion_per_run                                                  \
    -regress_censor_motion    0.4                                            \
    -regress_censor_outliers  0.05                                           \
    -regress_apply_mot_types  demean deriv                                   \
    -html_review_style        pythonic
#   -execute  # Uncomment if you want to run it immediately

#echo $dsets
#echo "Directory NIFTI: $dir_nifti"
#echo "Datasets: $dsets"
