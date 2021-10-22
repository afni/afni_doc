#!/bin/tcsh


# Using @chauffeur_afni


# ==================== Examples, and how to run them =====================


# AFNI tutorial: series of examples of automatic image-making in AFNI.
#
# + last update: Oct 21, 2021
#
##########################################################################

# This tcsh script is meant to be run in the following directory of
# the AFNI Bootcamp demo data:
#     AFNI_data6/afni
#
# ----------------------------------------------------------------------

# make output dir for all images
\mkdir -p QC








# ================== **Ex. 0**: Simple underlay viewing ==================


set opref = QC/ca000_anat_def

@chauffeur_afni                                                       \
    -ulay         anat+orig.HEAD                                      \
    -prefix       ${opref}                                            \
    -set_xhairs   MULTI                                               \
    -montx 3 -monty 3                                                 \
    -label_mode 1 -label_size 4  


# =============== **Ex. 1**: Moving/selecting view slices ================


set opref = QC/ca001_anat_mv_slices

@chauffeur_afni                                                       \
    -ulay           anat+orig.HEAD                                    \
    -prefix         ${opref}                                          \
    -set_dicom_xyz  -20 4 3                                           \
    -delta_slices   5 15 10                                           \
    -set_xhairs     MULTI                                             \
    -montx 3 -monty 3                                                 \
    -label_mode 1 -label_size 4 


# ======== **Ex. 2**: Underlay and overlay viewing (mask example) ========


# binarize the skullstripped anatomical, if not already done
if ( ! -e anat_mask.nii.gz ) then
    3dcalc                                                            \
        -a       strip+orig.HEAD                                      \
        -expr    'step(a)'                                            \
        -prefix  anat_mask.nii.gz
endif

set opref = QC/ca002_anat_w_mask

@chauffeur_afni                                                       \
    -ulay         anat+orig.HEAD                                      \
    -olay         anat_mask.nii.gz                                    \
    -opacity      4                                                   \
    -prefix       ${opref}                                            \
    -set_xhairs   OFF                                                 \
    -montx 3 -monty 3                                                 \
    -label_mode 1 -label_size 4    


# ============== **Ex. 3**: Focus box to select view slices ==============


set opref = QC/ca003a_anat_w_space

@chauffeur_afni                                                       \
    -ulay         strip+orig.HEAD                                     \
    -prefix       ${opref}                                            \
    -set_xhairs   MULTI                                               \
    -montx 3 -monty 3                                                 \
    -label_mode 1 -label_size 4 

set opref = QC/ca003b_anat_w_space

@chauffeur_afni                                                       \
    -ulay              strip+orig.HEAD                                \
    -box_focus_slices  AMASK_FOCUS_ULAY                               \
    -prefix            ${opref}                                       \
    -set_xhairs        MULTI                                          \
    -montx 3 -monty 3                                                 \
    -label_mode 1 -label_size 4


# ======== **Ex. 4**: Overlay beta coefs and threshold with stats ========


# determine voxelwise stat threshold, using p-to-statistic
# calculation
set sthr = `p2dsetstat                                                \
                -inset   "func_slim+orig.HEAD [2]"                    \
                -pval    0.001                                        \
                -bisided                                              \
                -quiet`

echo "++ The p-value 0.001 was convert to a stat value of: ${sthr}."

set opref = QC/ca004a_Vrel_coef_stat

@chauffeur_afni                                                       \
    -ulay             strip+orig.HEAD                                 \
    -olay             func_slim+orig.HEAD                             \
    -box_focus_slices AMASK_FOCUS_ULAY                                \
    -func_range       3                                               \
    -cbar             Spectrum:red_to_blue                            \
    -thr_olay         ${sthr}                                         \
    -set_subbricks    -1 1 2                                          \
    -opacity          5                                               \
    -prefix           ${opref}                                        \
    -set_xhairs       OFF                                             \
    -montx 3 -monty 3                                                 \
    -label_mode 1 -label_size 4  

set opref = QC/ca004b_Vrel_coef_stat

@chauffeur_afni                                                       \
    -ulay             strip+orig.HEAD                                 \
    -olay             func_slim+orig.HEAD                             \
    -box_focus_slices AMASK_FOCUS_ULAY                                \
    -func_range       3                                               \
    -cbar             Spectrum:red_to_blue                            \
    -thr_olay_p2stat  0.001                                           \
    -thr_olay_pside   bisided                                         \
    -set_subbricks    -1 "Vrel#0_Coef" "Vrel#0_Tstat"                 \
    -opacity          5                                               \
    -prefix           ${opref}                                        \
    -set_xhairs       OFF                                             \
    -montx 3 -monty 3                                                 \
    -label_mode 1 -label_size 4    

set opref = QC/ca004c_Vrel_coef_stat

@chauffeur_afni                                                       \
    -ulay             strip+orig.HEAD                                 \
    -ulay_range       0% 130%                                         \
    -olay             func_slim+orig.HEAD                             \
    -box_focus_slices AMASK_FOCUS_ULAY                                \
    -func_range       3                                               \
    -cbar             Reds_and_Blues_Inv                              \
    -thr_olay_p2stat  0.001                                           \
    -thr_olay_pside   bisided                                         \
    -set_subbricks    -1 "Vrel#0_Coef" "Vrel#0_Tstat"                 \
    -opacity          5                                               \
    -prefix           ${opref}                                        \
    -set_xhairs       OFF                                             \
    -montx 3 -monty 3                                                 \
    -label_mode 1 -label_size 4  


#  **Ex. 5**: Overlay beta coefs and threshold *translucently* with stats 


set opref = QC/ca005a_Vrel_coef_stat

@chauffeur_afni                                                       \
    -ulay             strip+orig.HEAD                                 \
    -ulay_range       0% 130%                                         \
    -olay             func_slim+orig.HEAD                             \
    -box_focus_slices AMASK_FOCUS_ULAY                                \
    -func_range       3                                               \
    -cbar             Reds_and_Blues_Inv                              \
    -thr_olay_p2stat  0.001                                           \
    -thr_olay_pside   bisided                                         \
    -olay_alpha       Yes                                             \
    -olay_boxed       Yes                                             \
    -set_subbricks    -1 "Vrel#0_Coef" "Vrel#0_Tstat"                 \
    -opacity          5                                               \
    -prefix           ${opref}                                        \
    -set_xhairs       OFF                                             \
    -montx 3 -monty 3                                                 \
    -label_mode 1 -label_size 4   


# == **Ex. 6**: Overlay beta coefs, threshold with stats and clusterize ==


3dClusterize                                                          \
    -overwrite                                                        \
    -echo_edu                                                         \
    -inset          func_slim+orig.HEAD                               \
    -ithr           "Vrel#0_Tstat"                                    \
    -idat           "Vrel#0_Coef"                                     \
    -bisided        "p=0.001"                                         \
    -NN             1                                                 \
    -clust_nvox     200                                               \
    -pref_map       clust_Vrel_map.nii.gz                             \
    -pref_dat       clust_Vrel_coef.nii.gz                            \
  >  clust_Vrel_report.1D

set opref = QC/ca006a_Vrel

@chauffeur_afni                                                       \
    -ulay              strip+orig.HEAD                                \
    -box_focus_slices  AMASK_FOCUS_ULAY                               \
    -olay              clust_Vrel_coef.nii.gz                         \
    -cbar              Reds_and_Blues_Inv                             \
    -ulay_range        0% 130%                                        \
    -func_range        3                                              \
    -opacity           5                                              \
    -prefix            ${opref}                                       \
    -set_xhairs        OFF                                            \
    -montx 3 -monty 3                                                 \
    -label_mode 1 -label_size 4       

set opref = QC/ca006b_Vrel

@chauffeur_afni                                                       \
    -ulay              strip+orig.HEAD                                \
    -box_focus_slices  AMASK_FOCUS_ULAY                               \
    -olay              clust_Vrel_map.nii.gz                          \
    -ulay_range        0% 130%                                        \
    -cbar              ROI_i64                                        \
    -func_range        64                                             \
    -pbar_posonly                                                     \
    -opacity           6                                              \
    -prefix            ${opref}                                       \
    -set_xhairs        OFF                                            \
    -montx 3 -monty 3                                                 \
    -label_mode 1 -label_size 4   


# = **Ex. 7**: Overlay beta coefs, threshold+clusterize *translucently* ==


set opref = QC/ca007a_Vrel

@chauffeur_afni                                                       \
    -ulay              strip+orig.HEAD                                \
    -box_focus_slices  AMASK_FOCUS_ULAY                               \
    -olay              func_slim+orig.HEAD                            \
    -cbar              Reds_and_Blues_Inv                             \
    -ulay_range        0% 130%                                        \
    -func_range        3                                              \
    -set_subbricks     -1 "Vrel#0_Coef"  "Vrel#0_Tstat"               \
    -clusterize        "-NN 1 -clust_nvox 200"                        \
    -thr_olay_p2stat   0.001                                          \
    -thr_olay_pside    bisided                                        \
    -olay_alpha        Yes                                            \
    -olay_boxed        Yes                                            \
    -opacity           5                                              \
    -prefix            ${opref}                                       \
    -set_xhairs        OFF                                            \
    -montx 3 -monty 3                                                 \
    -label_mode 1 -label_size 4       

set opref = QC/ca007b_Vrel_mskd

@chauffeur_afni                                                       \
    -ulay              strip+orig.HEAD                                \
    -box_focus_slices  AMASK_FOCUS_ULAY                               \
    -olay              func_slim+orig.HEAD                            \
    -cbar              Reds_and_Blues_Inv                             \
    -ulay_range        0% 130%                                        \
    -func_range        3                                              \
    -set_subbricks     -1 "Vrel#0_Coef"  "Vrel#0_Tstat"               \
    -clusterize        "-NN 1 -clust_nvox 200 -mask mask.auto.nii.gz" \
    -thr_olay_p2stat   0.001                                          \
    -thr_olay_pside    bisided                                        \
    -olay_alpha        Yes                                            \
    -olay_boxed        Yes                                            \
    -opacity           5                                              \
    -prefix            ${opref}                                       \
    -set_xhairs        OFF                                            \
    -montx 3 -monty 3                                                 \
    -label_mode 1 -label_size 4       


# ============== **Ex. 8**: Check alignment with edge view ===============


set opref = QC/ca008_edgy

@djunct_edgy_align_check                                              \
    -ulay              epi_r1+orig.HEAD"[0]"                          \
    -box_focus_slices  strip+orig.HEAD                                \
    -olay              strip+orig.HEAD                                \
    -use_olay_grid     NN                                             \
    -ulay_range_nz     "2%" "98%"                                     \
    -prefix            ${opref}                                       \
    -montx 3 -monty 3                                                 \
    -label_mode 1 




# ========================= **Ex. 10**: 4D mode ==========================


set opref = QC/ca010_epi_4D

@chauffeur_afni                                                       \
    -mode_4D                                                          \
    -image_label_ijk                                                  \
    -ulay          epi_r1+orig.HEAD'[0..16]'                          \
    -prefix        ${opref}                                           \
    -blowup        4                                                  \
    -set_xhairs    OFF                                                \
    -label_mode 1 -label_size 4     


# ============= **Ex. 11**: Other examples of functionality ==============


set opref = QC/ca011a_Vrel_coef_stat

@chauffeur_afni                                                       \
    -ulay             strip+orig.HEAD                                 \
    -olay             func_slim+orig.HEAD                             \
    -ulay_range       0% 130%                                         \
    -box_focus_slices AMASK_FOCUS_ULAY                                \
    -func_range       3                                               \
    -cbar             GoogleTurbo                                     \
    -thr_olay_p2stat  0.001                                           \
    -thr_olay_pside   bisided                                         \
    -set_subbricks    -1 "Vrel#0_Coef" "Vrel#0_Tstat"                 \
    -opacity          7                                               \
    -prefix           ${opref}                                        \
    -pbar_saveim      ${opref}                                        \
    -zerocolor        white                                           \
    -label_color      blue                                            \
    -set_xhairs       OFF                                             \
    -montx 3 -monty 3                                                 \
    -label_mode 1 -label_size 4    

set opref = QC/ca011b_Vrel_coef_stat

@chauffeur_afni                                                       \
    -ulay             anat+orig.HEAD                                  \
    -olay             anat+orig.HEAD                                  \
    -box_focus_slices AMASK_FOCUS_ULAY                                \
    -pbar_posonly                                                     \
    -ulay_range       0% 130%                                         \
    -edgy_ulay                                                        \
    -func_range       1000                                            \
    -cbar_ncolors 6                                                   \
    -cbar_topval ""                                                   \
    -cbar "1000=yellow 800=cyan 600=rbgyr20_10 400=rbgyr20_08 200=rbgyr20_05 100=hotpink 0=none" \
    -opacity          9                                               \
    -prefix           ${opref}                                        \
    -pbar_saveim      ${opref}                                        \
    -zerocolor        white                                           \
    -label_color      blue                                            \
    -set_xhairs       OFF                                             \
    -montx 3 -monty 3                                                 \
    -label_mode 1 -label_size 4    


# =========================== Troubleshooting ============================


