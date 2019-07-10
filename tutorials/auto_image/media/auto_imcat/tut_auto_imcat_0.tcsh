#!/bin/tcsh


# Using imcat


# ========== **Ex. 0**: Combine images subject- and slice-wise ===========


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
# This script is meant to be run in a directory containing the
# "*_SSW.nii.gz" reference dsets (e.g., copied from "abin/" directory). 
#
# We use the "*_SSW.nii.gz" reference templates distributed in AFNI.
# These dsets are used as reference volumes for @SSwarper (the
# combo-tool for performing nonlinear registration and skull stripping
# insieme).  Each of these dsets has multiple volumes (5).
#
# By changing the list of files given to "$istr", this script can be
# directly adapted to other cases.
#
# =====================================================================

set here  = $PWD                        # for path; trivial, could be changed

set istr  = "SSW"                       # string for choosing NIFTI files
set ilist = `\ls *${istr}.nii.gz`       # get list of NIFTIs to imagize
set Ndset = $#ilist                     # number of dsets in list

set lcol  = ( 255 255 255 )             # RGB line color bt image panels
set odir  = ${here}/QC_imcat_00         # output dir for images

\mkdir -p ${odir}                       # make output dir



# ------------ Use @chauffeur_afni to make individual images -------------


set allbase = ()

foreach ff ( $ilist )

    set ibase   = `3dinfo -prefix_noext "${ff}"`  # base name of vol
    set allbase = ( $allbase $ibase )             # list of all base names

    # Make a montage of the zeroth brick of each dset
    @chauffeur_afni                                                   \
        -ulay       "${ff}[0]"                                        \
        -prefix     ${odir}/img0_${ibase}                             \
        -set_dicom_xyz   5 18 18                                      \
        -delta_slices   10 20 10                                      \
        -set_xhairs     OFF                                           \
        -montx 8 -monty 1                                             \
        -label_mode 1 -label_size 3                                   \
        -do_clean
end



# ---------- Use imcat to concatenate sliceviews for each subj -----------


# Just the "gap color" between glued-together images
set lcol  = ( 66 184 254 )

# For each volume, concatenate images across all 3 sliceviews.  The
# order of contanenation will be that of globbing; could be specified
# in different ways, too.
foreach ff ( $allbase )
    imcat                                                             \
        -gap     5                                                    \
        -gap_col ${lcol}                                              \
        -nx 1                                                         \
        -ny 3                                                         \
        -prefix $odir/ALL_subj_${ff}.jpg                              \
        ${odir}/img0_*${ff}*
end


# ---------- Use imcat to concatenate subjs for each sliceview -----------


# Just the "gap color" between glued-together images
set lcol  = ( 255 152 11 )

# For each sliceview, concatenate images across all vols
foreach ss ( "sag" "cor" "axi" )
    imcat                                                             \
        -gap     5                                                    \
        -gap_col ${lcol}                                              \
        -nx 1                                                         \
        -ny ${Ndset}                                                  \
        -prefix $odir/ALL_${istr}_sview_${ss}.jpg                     \
        ${odir}/img0_*${ss}*
end

# ---------------------------------------------------------------------

echo "++ DONE!"

# All fine
exit 0


