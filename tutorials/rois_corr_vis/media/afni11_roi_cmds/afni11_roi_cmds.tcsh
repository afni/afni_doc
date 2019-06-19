#!/bin/tcsh


# Examples of things with ROIs: resampling and clusterizing

# AFNI demo: part of afni11*pdf talk about ROIs
#
# + last update: May 19, 2019
#
##########################################################################

# This script is meant to be run in the following directory of the
# AFNI Bootcamp demo data:
#     AFNI_data6/roi_demo


# ===================== Resampling (regridding) ROIs =====================


# Change grid/resolution of data set from (high res) anat to 
# (low res) EPI
3dresample                                                            \
    -overwrite                                                        \
    -master rall_vr+orig                                              \
    -prefix anat_roi_resam                                            \
    -inset anat_roi+orig                                              \
    -rmode NN


# image before resampling
set cent_of_mass = `3dCM anat_roi+orig`
 
@chauffeur_afni                                                       \
    -ulay  anat+orig                                                  \
    -olay  anat_roi+orig                                              \
    -ulay_range 0% 120%                                               \
    -cbar ROI_i64                                                     \
    -set_dicom_xyz ${cent_of_mass}                                    \
    -opacity 9                                                        \
    -prefix   IMG_roi_orig                                            \
    -montx 1 -monty 1                                                 \
    -set_xhairs OFF                                                   \
    -label_mode 1 -label_size 3                                       \
    -do_clean

@chauffeur_afni                                                       \
    -ulay  rall_vr+orig                                               \
    -olay  anat_roi_resam+orig                                        \
    -ulay_range 0% 110%                                               \
    -cbar ROI_i64                                                     \
    -set_dicom_xyz ${cent_of_mass}                                    \
    -set_subbricks 0 0 0                                              \
    -opacity 9                                                        \
    -blowup 4                                                         \
    -prefix   IMG_roi_resam                                           \
    -montx 1 -monty 1                                                 \
    -set_xhairs OFF                                                   \
    -label_mode 1 -label_size 3                                       \
    -do_clean


# ================== Averaging quantities within a mask ==================


# Average within ROI mask, per volume
3dmaskave                                                             \
    -mask anat_roi_resam+orig                                         \
    -quiet                                                            \
    rall_vr+orig > epi_avg.1D

# ... and view dumped text file results, just a column of numbers
cat epi_avg.1D

# Plot the time series (without the "-jpg ...", a GUI opens with the plot).
1dplot -jpg IMG_epi_avg -yaxis 1000:1200:2:1 epi_avg.1D

# ... and, if you have Python + matplotlib
1dplot.py -prefix IMG_epi_avg_py.jpg -yaxis 1000:1200 -infiles epi_avg.1D



# =========== Extracting individual voxel values within a mask ===========


# Save values of individual voxels within the ROI
3dmaskdump                                                            \
    -noijk                                                            \
    -mask anat_roi_resam+orig                                         \
    func_slim+orig'[2]' > Vrel-tstats.txt

# ... and view dumped text file results
cat Vrel-tstats.txt



# ================= Calculating stats from separate ROIs =================


# Compute separate statistics for each ROI in a volume
3dROIstats                                                            \
    -mask 3rois+orig                                                  \
    func_slim+orig'[0]'                                               \
    > stats_3rois.txt

# ... and view dumped text file results
cat stats_3rois.txt



# ======= Clusterizing, visualizing and extracting info about ROIs =======


# Note the use of labels to specify relevant subbricks and the p-value
# to specify the voxelwise threshold.
3dClusterize                                                          \
    -overwrite                                                        \
    -1Dformat                                                         \
    -inset func_slim+orig                                             \
    -idat 'Vrel#0_Coef'                                               \
    -ithr 'Vrel#0_Tstat'                                              \
    -NN 2                                                             \
    -clust_nvox 200                                                   \
    -bisided p=0.0001                                                 \
    -pref_map Clust_map.nii.gz                                        \
    -pref_dat Clust_dat.nii.gz                                        \
    > Clust_report.1D


@chauffeur_afni                                                       \
    -ulay  anat+orig                                                  \
    -olay  Clust_dat.nii.gz                                           \
    -box_focus_slices AMASK_FOCUS_OLAY                                \
    -cbar Reds_and_Blues_Inv                                          \
    -ulay_range 0% 110%                                               \
    -func_range 3                                                     \
    -opacity 6                                                        \
    -prefix   IMG_clust_dat                                           \
    -montx 7 -monty 1                                                 \
    -set_xhairs OFF                                                   \
    -label_mode 1 -label_size 3                                       \
    -do_clean

@chauffeur_afni                                                       \
    -ulay  anat+orig                                                  \
    -olay  Clust_map.nii.gz                                           \
    -box_focus_slices AMASK_FOCUS_OLAY                                \
    -cbar ROI_glasbey_256                                             \
    -ulay_range 0% 110%                                               \
    -pbar_posonly                                                     \
    -opacity 7                                                        \
    -prefix   IMG_clust_map                                           \
    -montx 7 -monty 1                                                 \
    -set_xhairs OFF                                                   \
    -label_mode 1 -label_size 3                                       \
    -do_clean


# =========== Finding ROI locations in atlases with "whereami" ===========


# ... and use the center of mass (CM) locations of clusters, as
# determined using the '[..]' selectors, for identification in loaded
# atlases with 'whereami'
whereami                                                              \
   -tab                                                               \
   -coord_file Clust_report.1D'[1,2,3]'                               \
   > Clust_whereami_CM.1D

# ... AND we could use the map of ROIs to find out locations, based on
# overlaps in loaded atlases, also with whereami
whereami                                                              \
   -omask Clust_map.nii.gz                                            \
   > Clust_whereami_olap.1D

