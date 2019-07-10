#!/bin/tcsh


# **Ex. 1**: Combine subbrick images of a 4D dset

# AFNI tutorial: auto-image-making example using imcat (and
#                @chauffeur_afni)
#
# + last update: July 10, 2019
#
##########################################################################
#
# Here, the program imcat concatenates (= glue together) images made
# with @chauffeur_afni.
#
# Another example using one of the "*_SSW.nii.gz" reference templates
# distributed in AFNI.  Here, we view multiple subbricks of the dset.
#
# By changing the volume specified with "$ivol", this script can be
# directly adapted to other cases.
#
# =====================================================================

set here  = $PWD                            # for path; could be changed

set ivol  = MNI152_2009_template_SSW.nii.gz         # volume de choix
set ibase = `3dinfo -prefix_noext "${ivol}"`        # base name of vol
set nv    = `3dinfo -nv "${ivol}"`                  # number of vols
set imax  = `3dinfo -nvi "${ivol}"`                 # max index

set lcol  = ( 0 204 0 )                 # RGB line color bt image panels
set odir  = ${here}/QC_imcat_01         # output dir for images

\mkdir -p ${odir}


# ------------ Use @chauffeur_afni to make individual images -------------


foreach ii ( `seq 0 1 ${imax}` )

    # zeropadded numbers, nicer to use in case we have a lot of images
    set iii = `printf "%03d" ${ii}`

    # This if-condition is a sidestep: we have two categories of data
    # in the input volume, masks and dsets, with very different
    # pertinent ranges, so we account for that here.
    if ( ${ii} > 2 ) then
        set UMIN = "0"
        set UMAX = "1"
    else
        set UMIN = "2%"
        set UMAX = "98%"
    endif

    @chauffeur_afni                                                   \
        -ulay       "${ivol}[$ii]"                                    \
        -ulay_range "$UMIN" "$UMAX"                                   \
        -prefix     ${odir}/${ibase}_${iii}                           \
        -set_dicom_xyz   2 18 18                                      \
        -delta_slices   25 25 25                                      \
        -set_xhairs     OFF                                           \
        -montx 1 -monty 1                                             \
        -label_mode 1 -label_size 3                                   \
        -do_clean
end


# ------------------- Use imcat to concatenate images --------------------


# concatenate 3 sliceviews, for as many volumes as are in the dset
imcat                                                                 \
    -echo_edu                                                         \
    -gap 5                                                            \
    -gap_col ${lcol}                                                  \
    -nx ${nv}                                                         \
    -ny 3                                                             \
    -prefix $odir/ALL_vol_${ibase}.jpg                                \
    $odir/${ibase}*sag* $odir/${ibase}*cor* $odir/${ibase}*axi*

# ---------------------------------------------------------------------

echo "++ DONE!"

# All fine
exit 0

