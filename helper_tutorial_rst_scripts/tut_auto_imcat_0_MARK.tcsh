#!/bin/tcsh

#:TITLE: Using imcat

cat << TEXTINTRO

``imcat`` is an "image concatenation" program.  This is a *very* useful
supplementary tool for glueing existing images together to make arrays
with separating lines, as well other features.  It combines quite
usefully with ``@chauffeur_afni``, for example to concatenate similar
images across a data set.

We present some examples of auto-image making with ``imcat`` using
data that should be available in (modern) AFNI binary distributions,
the ``*_SSW.nii.gz`` template targets for ``@SSwarper``.  Each of
these dsets has multiple bricks.  We provide examples: 

* combining multiple views and slices of the same dataset

* adjoining similar views across separate datasets

and more.

Each short script creates a subdirectory ("QC_imcat\*") for the both
the individual, intermediate images and the final concatenated matrix
of images.

TEXTINTRO

#:SECTION: **Ex. 0**: Combine images subject- and slice-wise

cat << TEXTBLOCK

Variables have been defined so that one should be able to adapt these
scripts by changing the just file name(s) in the uppermost input
section.

TEXTBLOCK

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


#:SUBSECTION: Use @chauffeur_afni to make individual images

cat <<TEXTBLOCK

Each ``@chauffeur_afni`` execution creates a set of sagittal, axial
and coronal images; each image output by chauffeur here is an 8x1
montage.  These will later be glued together.

TEXTBLOCK

set allbase = ()

foreach ff ( $ilist )

    set ibase   = `3dinfo -prefix_noext "${ff}"`  # base name of vol
    set allbase = ( $allbase $ibase )             # list of all base names

    # Make a montage of the zeroth brick of each dset
    @chauffeur_afni                                          \
        -ulay       "${ff}[0]"                                 \
        -prefix     ${odir}/img0_${ibase}                    \
        -set_dicom_xyz   5 18 18                             \
        -delta_slices   10 20 10                             \
        -set_xhairs     OFF                                  \
        -montx 8 -monty 1                                    \
        -label_mode 1 -label_size 3                          \
        -do_clean
end


#:SUBSECTION: Use imcat to concatenate sliceviews for each subj

cat <<TEXTBLOCK

First example of using ``imcat`` on a set of datasets: for each dset,
concatenate different slice views (sagittal, coronal and axial) of a
single volume.

This example requires having the ``*_SSW.nii.gz`` template targets
copied into the present working directory.  Alternatively, one could
just include the path to them in the glob at the top of the script
(e.g., ``set ivol  = `\ls ~/abin/*${istr}.nii.gz```)

TEXTBLOCK

# Just the "gap color" between glued-together images
set lcol  = ( 66 184 254 )

# For each volume, concatenate images across all 3 sliceviews.  The
# order of contanenation will be that of globbing; could be specified
# in different ways, too.
foreach ff ( $allbase )
    imcat                                                    \
        -gap     5                                            \
        -gap_col ${lcol}                                      \
        -nx 1                                                \
        -ny 3                                                \
        -prefix $odir/ALL_subj_${ff}.jpg                     \
        ${odir}/img0_*${ff}*
end

cat <<TEXTBLOCK

#:IMAGE: Combined sliceviews for each subject
    [[ HaskinsPeds_NL_template1.0_SSW: ]]
    QC_imcat_00/ALL_subj_HaskinsPeds_NL_template1.0_SSW.jpg
    [[ MNI152_2009_template_SSW: ]]
    QC_imcat_00/ALL_subj_MNI152_2009_template_SSW.jpg
    [[ TT_N27_SSW: ]]
    QC_imcat_00/ALL_subj_TT_N27_SSW.jpg

|

TEXTBLOCK


#:SUBSECTION: Use imcat to concatenate subjs for each sliceview

cat << TEXTBLOCK

Second example of using ``imcat`` on a set of datasets: for each slice
view, show the dset at the same (x, y, z) location.

TEXTBLOCK

# Just the "gap color" between glued-together images
set lcol  = ( 255 152 11 )

# For each sliceview, concatenate images across all vols
foreach ss ( "sag" "cor" "axi" )
    imcat                                                     \
        -gap     5                                             \
        -gap_col ${lcol}                                       \
        -nx 1                                                 \
        -ny ${Ndset}                                           \
        -prefix $odir/ALL_${istr}_sview_${ss}.jpg             \
        ${odir}/img0_*${ss}*
end

# ---------------------------------------------------------------------

echo "++ DONE!"

# All fine
exit 0


cat <<TEXTBLOCK

#:IMAGE: Combined subjects for each sliceview
    [[ sagittal views: ]]
    QC_imcat_00/ALL_SSW_sview_sag.jpg
    [[ coronal views: ]]
    QC_imcat_00/ALL_SSW_sview_cor.jpg
    [[ axial views: ]]
    QC_imcat_00/ALL_SSW_sview_axi.jpg

|

TEXTBLOCK



