#!/bin/tcsh

# script to create SARM images for AFNI webpage
# make images of some of the NMT v2 sym fh ("standard") data
 
set data_dir = $1          # input dir, where the data is
                           # might be ~/subcortical/SARM_in_NMT_v2.0_sym_fh/
set img_dir  = $2          # output dir, for images to go

if ( "${img_dir}" == "" ) then
    echo "** Need to enter 2 directory names: "
    echo "   input dir  (where the data is)"
    echo "   output dir (where the images will go)"
    exit 1
endif

# -----------------------------------------------------------------------

# make output dir, if necessary
\mkdir -p ${img_dir}

# -----------------------------------------------------------------------

set ulay    = ${data_dir}/NMT_v2.0_sym_fh.nii.gz
set olay    = ${data_dir}/SARM_in_NMT_v2.0_sym_fh.nii.gz
set focus   = ${data_dir}/NMT_v2.0_sym_fh.nii.gz

set max_idx = `3dinfo -nvi ${olay}`

foreach ii ( `seq 0 1 ${max_idx}` ) 

    @ lev = ${ii} + 1

    # SARM on skull-stripped NMT, level ${ii}
    @chauffeur_afni                                                       \
        -ulay              ${ulay}                                        \
        -olay              ${olay}                                        \
        -box_focus_slices  ${olay}                                       \
        -set_subbricks     0 ${ii} 0                                      \
        -ulay_range        0% 110%                                        \
        -cbar              ROI_i256                                       \
        -func_range        256                                            \
        -pbar_posonly                                                     \
        -opacity           6                                              \
        -prefix            ${img_dir}/img_nmt2.0symss_sarmL${lev}        \
        -montx 6 -monty 1                                                 \
        -montgap           5                                              \
        -montcolor         black                                          \
        -set_xhairs OFF                                                   \
        -label_mode 1 -label_size 3                                       \
        -do_clean    

end
