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

set cc = 3

# make output dir, if necessary
\mkdir -p ${img_dir}

# -----------------------------------------------------------------------

# use exact same focus region for all
set focus   = ${data_dir}/ibt_C${cc}_template_mean.nii.gz

foreach ttt ( mean typ )

    set ulay    = ${data_dir}/ibt_C${cc}_template_${ttt}.nii.gz

    @chauffeur_afni                                                       \
        -ulay              ${ulay}                                        \
        -olay_off                                                         \
        -box_focus_slices  ${focus}                                       \
        -prefix            ${img_dir}/img_00_C${cc}_${ttt}                \
        -montx 6 -monty 1                                                 \
        -montgap           5                                              \
        -montcolor         black                                          \
        -set_xhairs OFF                                                   \
        -label_mode 1 -label_size 3                                       \
        -do_clean    

end

# ------------------------------------------------------------------------

# overlay edges of mean template on typical template

set ulay    = ${data_dir}/ibt_C${cc}_template_typ.nii.gz
set olay    = ${data_dir}/ibt_C${cc}_template_mean.nii.gz

@djunct_edgy_align_check                                              \
    -ulay              ${ulay}                                        \
    -olay              ${olay}                                        \
    -box_focus_slices  ${focus}                                       \
    -montx 6 -monty 1                                                 \
    -montgap           5                                              \
    -montcolor         black                                          \
    -prefix            ${img_dir}/img_00_C${cc}_edges_typ_mean        \
    -label_mode 1

# ------------------------------------------------------------------------

# clean up-- just keep axi images
\rm ${img_dir}/img_00_C${cc}_*{cor,sag}*.{png,jpg}
