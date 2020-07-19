#!/bin/tcsh

# make images of some of the NMT v1.3 data

set nmt_dir = ./          # input dir, where the data is
set img_dir = ./          # output dir, for images to go

# -----------------------------------------------------------------------

# make output dir, if necessary
\mkdir -p ${img_dir}

# make sure ${img_dir} is defined with full path, for later use
cd ${img_dir}
set img_dir = ${PWD} 
cd -                     

# -----------------------------------------------------------------------

# brainmask on full NMT
@chauffeur_afni                                                       \
    -ulay              NMT.nii.gz                                     \
    -olay              NMT_brainmask.nii.gz                           \
    -box_focus_slices  NMT_brainmask.nii.gz                           \
    -ulay_range        0% 110%                                        \
    -cbar              RedBlueGreen                                   \
    -func_range        1                                              \
    -pbar_posonly                                                     \
    -opacity           4                                              \
    -prefix            ${img_dir}/img_nmt1.3_brainmask                \
    -montx 6 -monty 1                                                 \
    -set_xhairs OFF                                                   \
    -montgap           5                                              \
    -montcolor         black                                          \
    -label_mode 1 -label_size 3                                       \
    -do_clean    

# tissue segmentation on skull-stripped NMT
@chauffeur_afni                                                       \
    -ulay              NMT_SS.nii.gz                                  \
    -olay              NMT_segmentation_4class.nii.gz                 \
    -box_focus_slices  NMT_brainmask.nii.gz                           \
    -ulay_range        0% 110%                                        \
    -cbar              ROI_i32                                        \
    -func_range        32                                             \
    -pbar_posonly                                                     \
    -opacity           5                                              \
    -prefix            ${img_dir}/img_nmt1.3ss_segmentation           \
    -montx 6 -monty 1                                                 \
    -montgap           5                                              \
    -montcolor         black                                          \
    -set_xhairs OFF                                                   \
    -label_mode 1 -label_size 3                                       \
    -do_clean    

# D99atlas on skull-stripped NMT
@chauffeur_afni                                                       \
    -ulay              NMT_SS.nii.gz                                  \
    -olay              D99_atlas_1.2a_al2NMT.nii.gz                   \
    -box_focus_slices  NMT_brainmask.nii.gz                           \
    -ulay_range        0% 110%                                        \
    -cbar              ROI_i256                                       \
    -func_range        256                                            \
    -pbar_posonly                                                     \
    -opacity           6                                              \
    -prefix            ${img_dir}/img_nmt1.3ss_d99atlas               \
    -montx 6 -monty 1                                                 \
    -montgap           5                                              \
    -montcolor         black                                          \
    -set_xhairs OFF                                                   \
    -label_mode 1 -label_size 3                                       \
    -do_clean    



