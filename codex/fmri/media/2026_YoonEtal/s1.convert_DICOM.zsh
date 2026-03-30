#!/bin/zsh

# run dcm2niix_afni to convert DICOMs to NIFTI volumes
# 
# This is an example of running dcm2niix_afni to convert raw DICOM
# files into NIfTI format and organize structural and functional data.
#
# Execution: 
# 
#     zsh s1.convert_DICOM.zsh -s TMN01
# 
##############################################################

## Process command line arguments
while (( $# )); do
   key="$1"
   case $key in
      -s | --subject)
         subj="$2"
         shift # Shift twice if the subject is given
      ;;
   esac
   shift ##takes one argument
done

# Check if subject is set
if [ -z "$subj" ]; then
    echo "Error: Subject is not set."
    echo "Use -s or --subject to specify the subject."
    exit 1
fi

##############################################################

dir_root="/mnt/ext4/TMN/fmri_data"
dir_raw="$dir_root/raw_data/$subj"

dir_output="$dir_raw/convert_data/$subj"
if [ ! -d "$dir_output" ]; then
   mkdir -p -m 755 "$dir_output"
fi

##############################################################

## T1
dname_T1=$(find "$dir_raw" -type d -name "T1")
dcm2niix_afni                                       \
   -a y -o "$dir_output" -f T1.$subj                \
   "$dname_T1"

## EPI1
for rr in {1..6}; do
   dname_E1=$(find "$dir_raw" -type d -name "Nomemory_RUN${rr}")
   run=$(printf "r%02d" "$rr")
   dcm2niix_afni                                    \
      -a y -o "$dir_output" -f func.NM.$run.$subj   \
      "$dname_E1"
done

##############################################################

## EPI1 reverse
dname_ER=$(find "$dir_raw" -type d -name "Reverse")
dcm2niix_afni                                       \
    -a y -o "$dir_output" -f func.REV.$subj         \
    "$dname_ER"

## EPI2
for rr in {1..6}; do
   dname_E2=$(find "$dir_raw" -type d -name "memory_RUN${rr}")
   run=$(printf "r%02d" "$rr")
   dcm2niix_afni                                    \
      -a y -o "$dir_output" -f func.M.$run.$subj    \
      "$dname_E2"
done
