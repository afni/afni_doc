#!/bin/tcsh


# Using @chauffeur_afni


# ==================== Examples, and how to run them =====================


# AFNI tutorial: series of examples of automatic image-making in AFNI.
#
# + last update: July 8, 2019
#
##########################################################################

# This tcsh script is meant to be run in the following directory of
# the AFNI Bootcamp demo data:
#     AFNI_data6/afni
#
# ----------------------------------------------------------------------

# anatomical volumes: some present already, and some derived here
set vol_anat     = anat+orig                              # anatomical vol
set pre_anat     = `3dinfo -prefix_noext "${vol_anat}"`   # vol prefix
set pre_tut      = _tut                                   # new dset prefix
set vol_anat_s   = strip+orig                             # anat. no skull
set pre_anat_s   = `3dinfo -prefix_noext "${vol_anat_s}"` # vol prefix
set pre_anat_m   = anat_mask                              # vol prefix
set vol_anat_m   = ${pre_tut}_${pre_anat_m}.nii.gz        # anat. ss + msk
set pre_anat_su  = anat_ss_uni                            # vol prefix
set vol_anat_su  = ${pre_tut}_${pre_anat_su}.nii.gz       # anat. unifized
set pre_anat_sub = anat_ss_uni_box                        # vol prefix
set vol_anat_sub = ${pre_tut}_${pre_anat_sub}.nii.gz      # anat. uni + box

# stat/model output vol
set vol_stat     = func_slim+orig                         # model results
set pre_stat     = `3dinfo -prefix_noext "${vol_stat}"`   # vol prefix

# EPI volumes: some present already, others derived here
set vol_epi      = epi_r1+orig                            # EPI vol, 4D
set pre_epi      = `3dinfo -prefix_noext "${vol_epi}"`    # vol prefix
set pre_epi_e    = epi_edge0                              # vol prefix
set vol_epi_e    = ${pre_tut}_${pre_epi_e}.nii.gz         # EPI edgey [0]
set pre_epi_p    = epi_part                               # vol prefix
set vol_epi_p    = ${pre_tut}_${pre_epi_p}.nii.gz         # part of EPI

# selecting coef/stat bricks and labels
set ind_coef   = 3                                        # effect estimate
set ind_stat   = 4                                        # stat of ee
set lab_coef   = `3dinfo -label "${vol_stat}[${ind_coef}]"` # str label of ee
set lab_stat   = `3dinfo -label "${vol_stat}[${ind_stat}]"` # str label of stat
set lab_statf  = "${lab_stat:gas/#/_/}"                   # str: no '#'
set lab_coeff  = "${lab_coef:gas/#/_/}"                   # str: no '#'

set stat_map   = ${pre_tut}_${pre_stat}_map.nii.gz        # cluster map 
set stat_ee    = ${pre_tut}_${pre_stat}_EE.nii.gz         # effect est, clust
set stat_rep   = ${pre_tut}_${pre_stat}_report.txt        # cluster text rep

# info for thresholding/clustering
set pthr       = 0.001                                    # voxelwise thresh
set tail_type  = "bisided"                                # {1,2,bi}sided

# --------------------------------------------------------------------------


# make output dir for all images
\mkdir -p QC



# ------------------- **Ex. 0**: 3D anatomical volume --------------------


set opref = QC/ca000_${pre_anat}

@chauffeur_afni                                                       \
    -ulay    ${vol_anat}                                              \
    -prefix  ${opref}                                                 \
    -montx 3 -monty 3                                                 \
    -set_xhairs MULTI                                                 \
    -label_mode 1 -label_size 3                                       \
    -do_clean


# ------------------- **Ex. 1**: 3D anatomical volume --------------------


set opref = QC/ca001_${pre_anat}

@chauffeur_afni                                                       \
    -ulay    ${vol_anat}                                              \
    -prefix  ${opref}                                                 \
    -montx 3 -monty 3                                                 \
    -set_dicom_xyz 0 0 0                                              \
    -delta_slices  5 15 10                                            \
    -set_xhairs MULTI                                                 \
    -label_mode 1 -label_size 3                                       \
    -do_clean


# -------------- **Ex. 2**: 3D anatomical volume, olay mask --------------


# binarize the skullstripped anatomical, if not already done
if ( ! -e ${vol_anat_m} ) then
    3dcalc                                                            \
        -a ${vol_anat_s}                                              \
        -expr 'step(a)'                                               \
        -prefix ${vol_anat_m}
endif

set opref = QC/ca002_${pre_anat_m}

@chauffeur_afni                                                       \
    -ulay    ${vol_anat}                                              \
    -olay    ${vol_anat_m}                                            \
    -opacity 4                                                        \
    -prefix  ${opref}                                                 \
    -montx 3 -monty 3                                                 \
    -set_xhairs OFF                                                   \
    -label_mode 1 -label_size 3                                       \
    -do_clean



# ---------- **Ex. 3**: threshold stats voxelwise, view effects ----------


# determine voxelwise stat threshold, using p-to-statistic
# calculation
set sthr = `p2dsetstat                                                \
                -inset "${vol_stat}[${ind_stat}]"                     \
                -pval $pthr                                           \
                -$tail_type                                           \
                -quiet`

echo "++ The p-value ${pthr} was convert to a stat value of: ${sthr}."

set opref = QC/ca003_${pre_stat}_${lab_coeff}

@chauffeur_afni                                                       \
    -ulay  ${vol_anat_s}                                              \
    -olay  ${vol_stat}                                                \
    -func_range 3                                                     \
    -cbar Spectrum:red_to_blue                                        \
    -thr_olay ${sthr}                                                 \
    -set_subbricks -1 ${ind_coef} ${ind_stat}                         \
    -opacity 5                                                        \
    -prefix  ${opref}                                                 \
    -montx 3 -monty 3                                                 \
    -set_xhairs OFF                                                   \
    -label_mode 1 -label_size 3                                       \
    -do_clean


# -------- **Ex. 4**: threshold stats voxelwise, view effects, II --------


# Make a nicer looking underlay: unifized and skullstripped
# anatomical
if ( ! -e $vol_anat_su ) then
    3dUnifize -GM -prefix $vol_anat_su -input $vol_anat_s
endif

set opref = QC/ca004_${pre_stat}_${lab_coeff}

@chauffeur_afni                                                       \
    -ulay  ${vol_anat_su}                                             \
    -olay  ${vol_stat}                                                \
    -cbar Reds_and_Blues_Inv                                          \
    -ulay_range 0% 150%                                               \
    -func_range 3                                                     \
    -thr_olay ${sthr}                                                 \
    -set_subbricks -1 ${ind_coef} ${ind_stat}                         \
    -opacity 5                                                        \
    -prefix  ${opref}                                                 \
    -montx 3 -monty 3                                                 \
    -set_xhairs OFF                                                   \
    -label_mode 1 -label_size 3                                       \
    -do_clean


# ------- **Ex. 5**: threshold stats voxelwise, view effects, III --------


set opref = QC/ca005_${pre_stat}_${lab_coeff}_alpha

@chauffeur_afni                                                       \
    -ulay  ${vol_anat_su}                                             \
    -olay  ${vol_stat}                                                \
    -cbar Reds_and_Blues_Inv                                          \
    -ulay_range 0% 150%                                               \
    -func_range 3                                                     \
    -thr_olay   ${sthr}                                               \
    -olay_alpha Yes                                                   \
    -olay_boxed Yes                                                   \
    -set_subbricks -1 ${ind_coef} ${ind_stat}                         \
    -opacity 5                                                        \
    -prefix  ${opref}                                                 \
    -montx 3 -monty 3                                                 \
    -set_xhairs OFF                                                   \
    -label_mode 1 -label_size 3                                       \
    -do_clean


# --- **Ex. 6**: threshold stats voxelwise + clusterize, view effects ----


3dClusterize                                                          \
    -overwrite                                                        \
    -echo_edu                                                         \
    -inset   ${vol_stat}                                              \
    -ithr    ${ind_stat}                                              \
    -idat    ${ind_coef}                                              \
    -${tail_type}  "p=$pthr"                                          \
    -NN             1                                                 \
    -clust_nvox     200                                               \
    -pref_map       ${stat_map}                                       \
    -pref_dat       ${stat_ee}                                        \
  > ${stat_rep}

set opref = QC/ca006_${pre_stat}

@chauffeur_afni                                                       \
    -ulay  ${vol_anat_su}                                             \
    -olay  ${stat_ee}                                                 \
    -cbar Reds_and_Blues_Inv                                          \
    -ulay_range 0% 150%                                               \
    -func_range 3                                                     \
    -opacity    5                                                     \
    -prefix     ${opref}                                              \
    -montx 3 -monty 3                                                 \
    -set_xhairs OFF                                                   \
    -label_mode 1 -label_size 3                                       \
    -do_clean


# - **Ex. 7**: threshold stats voxelwise + clusterize, view effects, II --


# Save space: autobox
if ( ! -e ${vol_anat_sub} ) then
    3dAutobox -prefix ${vol_anat_sub} -npad 7 -input ${vol_anat_su}
endif

3dClusterize                                                          \
    -overwrite                                                        \
    -echo_edu                                                         \
    -inset   ${vol_stat}                                              \
    -ithr    ${ind_stat}                                              \
    -idat    ${ind_coef}                                              \
    -${tail_type}  "p=$pthr"                                          \
    -NN             1                                                 \
    -clust_nvox     200                                               \
    -pref_map       ${stat_map}                                       \
    -pref_dat       ${stat_ee}                                        \
  > ${stat_rep}

set opref = QC/ca007_${pre_stat}

@chauffeur_afni                                                       \
    -ulay  ${vol_anat_sub}                                            \
    -olay  ${stat_ee}                                                 \
    -cbar Reds_and_Blues_Inv                                          \
    -ulay_range 0% 150%                                               \
    -func_range 3                                                     \
    -opacity    5                                                     \
    -prefix     ${opref}                                              \
    -montx 3 -monty 3                                                 \
    -set_xhairs OFF                                                   \
    -label_mode 1 -label_size 3                                       \
    -do_clean


# -------------- **Ex. 8**: view ROIs (here, cluster maps) ---------------


set opref = QC/ca008_${pre_stat}

@chauffeur_afni                                                       \
    -ulay  ${vol_anat_sub}                                            \
    -olay  ${stat_map}                                                \
    -ulay_range 0% 150%                                               \
    -cbar ROI_i64                                                     \
    -pbar_posonly                                                     \
    -opacity     6                                                    \
    -zerocolor   white                                                \
    -label_color "blue"                                               \
    -blowup      1                                                    \
    -prefix      ${opref}                                             \
    -montx 3 -monty 3                                                 \
    -set_xhairs OFF                                                   \
    -label_mode 1 -label_size 3                                       \
    -do_clean


# -------------- **Ex. 9**: check alignment with edge view ---------------


if ( ! -e ${vol_epi_e} ) then
     3dedge3 -prefix ${vol_epi_e} -input ${vol_epi}'[0]'
endif

set opref = QC/ca009_${pre_stat}

@chauffeur_afni                                                       \
    -ulay  ${vol_anat_sub}                                            \
    -olay  ${vol_epi_e}                                               \
    -ulay_range 0% 150%                                               \
    -func_range_perc 25                                               \
    -cbar     "red_monochrome"                                        \
    -opacity  6                                                       \
    -prefix   ${opref}                                                \
    -montx 3 -monty 3                                                 \
    -set_xhairs OFF                                                   \
    -label_mode 1 -label_size 3                                       \
    -do_clean


# ------------------------- **Ex. 10**: 4D mode --------------------------


# just taking a subset of the time series for this example
if ( ! -e ${vol_epi_p} ) then
     3dcalc -a ${vol_epi}'[0..16]' -expr 'a' -prefix ${vol_epi_p}
endif

set opref = QC/ca010_${pre_epi_p}

@chauffeur_afni                                                       \
    -ulay  ${vol_epi_p}                                               \
    -mode_4D                                                          \
    -image_label_ijk                                                  \
    -prefix  ${opref}                                                 \
    -blowup  4                                                        \
    -set_xhairs OFF                                                   \
    -label_mode 1 -label_size 3                                       \
    -do_clean

