#!/bin/tcsh

# [PT: Oct 20, 2021] This script is used to generate the images (both
# colorbars themselves and dset-like ones) for the "all colorbar"
# educational page in the AFNI docs.

# **Requires ImageMagick to rotate the pbar image**

# This script can be run anywhere that the MNI*SS*nii.gz dset exists,
# and the output cbars/ and cbar_refs/ directories copied to
# afni_doc/educational/media/.


set dset_00   = MNI152_2009_template_SSW.nii.gz
set dset_01_p = new_rois_for_cbar
set dset_01   = ${dset_01_p}_GMI.nii.gz

\mkdir -p cbar_refs
\mkdir -p cbars/IMGS 
\mkdir -p cbars/IMGS_MULTI
\mkdir -p cbars/IMGS_XXXnpane 
\mkdir -p cbars/CBARS_XXXnpane 

# -----------------------------------------------------------------------
# make dset_01, the ROI-ish one

# magic params to end up with 256 quasi-evenly spaced points on
# diagonals, no gaps
set xoff = 0.0
set yoff = 0.4
set per = 12.2
set dil = 2

set fac = `echo "scale=5; ${per}/(2*3.14159)" | bc`
set sep = `echo "scale=5; 0.8*${per}/sqrt(2)" | bc`
echo "++ per is: ${per}"
echo "++ fac is: ${fac}"
echo "++ sep is: ${sep}"

set tpref = _tmp_ZXC

3dmask_tool \
    -overwrite \
    -inputs "${dset_00}[3]" \
    -dilate_inputs -${dil} \
    -prefix ${tpref}_mask.nii.gz

3dcalc \
    -overwrite \
    -a ${tpref}_mask.nii.gz \
    -expr "step(a)*step(z+0.5)*step(0.5-z)*(sin(x/${fac}-${xoff})+cos(y/${fac}-${yoff}))**2" \
    -prefix ${tpref}_bumps.nii.gz \
    -datum float

3dcalc \
    -overwrite \
    -a ${tpref}_bumps.nii.gz \
    -expr "step(a-3.7)*a" \
    -prefix ${tpref}_bumps2.nii.gz \
    -datum float

3dExtrema \
    -overwrite \
    -sep_dist ${sep} \
    -prefix ${tpref}_pts.nii.gz \
    -maxima \
    -volume \
    ${tpref}_bumps2.nii.gz 

3dROIMaker \
    -overwrite \
    -nifti \
    -inflate 7 \
    -inset ${tpref}_pts.nii.gz \
    -prefix ${dset_01_p}

if ( ${status} ) then
    echo "** ERROR: something bad has happened along the way."
    exit 1
endif

# clean 
if ( 1 ) then
    \rm ${tpref}*
endif

# -----------------------------------------------------------------------
# initial images of template-like and ROI-like data

# the lengths of these next two arrays must match: one output prefix per dset.
set all_dsets = (   "${dset_00}[1]" \
                    "${dset_01}"    )
set all_opref = (   cbar_refs/FIG_ref_anat \
                    cbar_refs/FIG_ref_rois )
set all_oimgp = (   cbars/IMGS/tt_cbar \
                    cbars/IMGS_MULTI/mm_cbar )
set all_frang = (   "-func_range_perc 98" \
                    "-func_range 256" )
set all_opac  = (   9 \
                    5 )

set Ndset     = ${#all_dsets}
               
foreach ii ( `seq 1 1 ${Ndset}` ) 

    set ulay  = "${all_dsets[$ii]}"
    set opref = "${all_opref[$ii]}"

    @chauffeur_afni                                                 \
        -olay_off                                                   \
        -ulay    "${ulay}"                                          \
        -prefix  "${opref}"                                         \
        -montx 1 -monty 1                                           \
        -no_cor                                                     \
        -no_sag                                                     \
        -set_dicom_xyz     0 0 0                                    \
        -set_subbricks     0 0 0                                    \
        -set_xhairs        OFF                                      \
        -label_mode 0
end

# ------------------------------------------------------------------------
# cbars for ROIs with Nroi > 256

set all_cbar_gt256 = (  ROI_glasbey_512  \
                        ROI_glasbey_1024 \
                        ROI_glasbey_2048 )
set all_nroi_gt256 = (  512  \
                        1024 \
                        2048 )
set all_dims       = (  16 32 \
                        32 32 \
                        32 64 )

set Nnroi_gt256    = ${#all_cbar_gt256}

set tpref2         = _tmp_ASD

foreach nn ( `seq 1 1 ${Nnroi_gt256}` ) 
    set cbar = ${all_cbar_gt256[$nn]}
    set nroi = ${all_nroi_gt256[$nn]}
    set dset = ${tpref2}_nroi_${nroi}.nii.gz

    @ m2  = ${nn} * 2
    @ m1  = ${m2} - 1
    @ d1  = ${all_dims[${m1}]}
    @ d2  = ${all_dims[${m2}]}
    @ tot = ${d1} * ${d2}

    3dcalc \
        -overwrite \
        -a jRandomDataset:${d1},${d2},3,1 \
        -expr "${tot}-(${d1}*j+i)" \
        -prefix ${dset}


    set ulay  = ${dset}
    set olay  = ${dset}
    set oimgp = xx_cbar
    set frang = "-func_range ${nroi}"
    set opac  = 9

    set oname = "cbars/IMGS_XXXnpane/${oimgp}_${cbar}"
    set obar  = "cbars/CBARS_XXXnpane/${cbar}"

    @chauffeur_afni                                            \
        -pbar_posonly                                          \
        -ulay           "${ulay}"                              \
        -olay           "${olay}"                              \
        -prefix         "${oname}"                             \
        ${frang}                                               \
        -XXXnpane       "${nroi}"                              \
        -opacity        "${opac}"                              \
        -cbar           "${cbar}"                              \
        -pbar_saveim    "${obar}"                              \
        -blowup         8                                      \
        -montx 1 -monty 1                                      \
        -no_cor                                                \
        -no_sag                                                \
        -set_subbricks     0 0 0                               \
        -set_xhairs        OFF                                 \
        -label_mode 0

    # use imagemagick to scale image up, so hopefully Sphinx doesn't
    # make it blurry (ugh)
    convert "${oname}.axi.png" -scale 400% "${oname}.axi.png"

    # to have vertical cbar, and convert to png: uses ImageMagick
    convert "${obar}.jpg" -rotate -90 -quality 100 "${obar}.png"

    # ... and clean up jpg+txt
    \rm ${obar}.jpg ${obar}.txt
end

# clean 
if ( 1 ) then
    \rm ${tpref2}*
endif

# ------------------------------------------------------------------------
# "normal" cbars for ROIs with Nroi <= 256 (and templates/continuous dsets)

set all_cbar256 = ( Viridis \
                    Spectrum:yellow_to_red \
                    Spectrum:yellow_to_cyan \
                    Spectrum:yellow_to_cyan+gap \
                    Spectrum:red_to_blue \
                    Spectrum:red_to_blue+gap \
                    ROI_i64 \
                    ROI_i32 \
                    ROI_i256 \
                    ROI_i128 \
                    ROI_glasbey_256 \
                    Reds_and_Blues_w_Green \
                    Reds_and_Blues_Inv \
                    Reds_and_Blues \
                    RedBlueGreen \
                    red_monochrome \
                    Plasma \
                    Magma \
                    inverted_gray_circle \
                    inverted_amber_circle  \
                    green_monochrome \
                    gray_scale \
                    gray_circle \
                    FreeSurfer_Seg_i255 \
                    CytoArch_ROI_i256 \
                    Color_circle_ZSS \
                    Color_circle_AJJ \
                    cb_spiral35 \
                    cb_spiral \
                    blue_monochrome \
                    amber_redtop_bluebot \
                    amber_monochrome \
                    amber_circle \
                    Add_Edge \
                    GoogleTurbo \
                    )

set Ncbar256 = ${#all_cbar256}

foreach nn ( `seq 1 1 ${Ncbar256}` ) 
    set cbar = ${all_cbar256[$nn]}

    foreach ii ( `seq 1 1 ${Ndset}` ) 
        set ulay  = "${dset_00}[1]"
        set olay  = "${all_dsets[$ii]}"
        set oimgp = "${all_oimgp[$ii]}"
        set frang = "${all_frang[$ii]}"
        set opac  = "${all_opac[$ii]}"

        set oname = "${oimgp}_${cbar}"
        set obar  = "cbars/${cbar}"

        @chauffeur_afni                                            \
            -pbar_posonly                                          \
            -ulay           "${ulay}"                              \
            -olay           "${olay}"                              \
            -prefix         "${oname}"                             \
            ${frang}                                               \
            -opacity        "${opac}"                              \
            -cbar           "${cbar}"                              \
            -pbar_saveim    "${obar}"                              \
            -montx 1 -monty 1                                      \
            -no_cor                                                \
            -no_sag                                                \
            -set_dicom_xyz     0 0 0                               \
            -set_subbricks     0 0 0                               \
            -set_xhairs        OFF                                 \
            -label_mode 0

    # to have vertical cbar, and convert to png: uses ImageMagick
    convert "${obar}.jpg" -rotate -90 -quality 100 "${obar}.png"

    # ... and clean up jpg+txt
    \rm ${obar}.jpg ${obar}.txt

    end
end

exit 0
