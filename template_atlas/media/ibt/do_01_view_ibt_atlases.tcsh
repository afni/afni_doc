#!/bin/tcsh

# make images of some of the IBT data

set data_dir = $1          # input dir, where the data is
set img_dir  = $2          # output dir, for images to go

if ( "${img_dir}" == "" ) then
    echo "** Need to enter 2 directory names: "
    echo "   input dir  (where the data is)"
    echo "   output dir (where the images will go)"
    exit 1
endif

# -----------------------------------------------------------------------

set cc = C3

# make output dir, if necessary
\mkdir -p ${img_dir}

# -----------------------------------------------------------------------

# use exact same focus region for all
set focus   = ${data_dir}/ibt_${cc}_template_mean.nii.gz

foreach ttt ( mean typ )

    if ( "${ttt}" == "mean" ) then
        set aaa = mpm
    else if ( "${ttt}" == "typ" ) then
        set aaa = typ
    endif

    set ulay    = ${data_dir}/ibt_${cc}_template_${ttt}.nii.gz

    foreach over ( 2000 2009 )

        set olay = ${data_dir}/ibt_${cc}_atlas_${aaa}_fs${over}.nii.gz

        @chauffeur_afni                                                       \
            -ulay              ${ulay}                                        \
            -olay              ${olay}                                        \
            -box_focus_slices  ${focus}                                       \
            -ulay_range        0% 110%                                        \
            -cbar              ROI_i256                                       \
            -func_range        256                                            \
            -pbar_posonly                                                     \
            -opacity           4                                              \
            -prefix      ${img_dir}/img_01_${cc}_${ttt}_${aaa}_atl_fs${over} \
            -montx 6 -monty 1                                                 \
            -montgap           5                                              \
            -montcolor         black                                          \
            -set_xhairs OFF                                                   \
            -label_mode 1 -label_size 3                                       \
            -do_clean    

    end

    # some in supplementary_C?/ subdir
    foreach over ( 2000 )

        set olay = ${data_dir}/supplementary_${cc}
        set olay = ${olay}/ibt_${cc}_seg_${aaa}_fs${over}.nii.gz

        @chauffeur_afni                                                       \
            -ulay              ${ulay}                                        \
            -olay              ${olay}                                        \
            -box_focus_slices  ${focus}                                       \
            -ulay_range        0% 110%                                        \
            -cbar              ROI_i256                                       \
            -func_range        256                                            \
            -pbar_posonly                                                     \
            -opacity           9                                              \
            -prefix      ${img_dir}/img_01_${cc}_${ttt}_${aaa}_seg_fs${over} \
            -montx 6 -monty 1                                                 \
            -montgap           5                                              \
            -montcolor         black                                          \
            -set_xhairs OFF                                                   \
            -label_mode 1 -label_size 3                                       \
            -do_clean    

        set olay = ${data_dir}/supplementary_${cc}
        set olay = ${olay}/ibt_${cc}_atlas_${aaa}_fs${over}_gmrois.nii.gz

        @chauffeur_afni                                                       \
            -ulay              ${ulay}                                        \
            -olay              ${olay}                                        \
            -box_focus_slices  ${focus}                                       \
            -ulay_range        0% 110%                                        \
            -cbar              ROI_i256                                       \
            -func_range        256                                            \
            -pbar_posonly                                                     \
            -opacity           9                                              \
          -prefix ${img_dir}/img_01_${cc}_${ttt}_${aaa}_atl_fs${over}_gmrois \
            -montx 6 -monty 1                                                 \
            -montgap           5                                              \
            -montcolor         black                                          \
            -set_xhairs OFF                                                   \
            -label_mode 1 -label_size 3                                       \
            -do_clean    

    end
end


