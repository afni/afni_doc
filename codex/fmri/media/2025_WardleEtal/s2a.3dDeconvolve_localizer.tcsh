#!/bin/tcsh 

# In this script, 3dDeconvolve is run for the functional localizer
# data (objects vs. scrambled objects, in a block design).
# 
# The contrast [objects - scrambled objects] is later used to
# functionally define the object-responsive regions of interest.
#
# LO and VTC in each participant's native brain space.

# Used in: 
#
#   Wardle, S. G., Rispoli, B., Roopchansingh, V. & Baker, C. (2024)
#   Brief encounters with real objects modulate medial parietal but
#   not occipitotemporal cortex. bioRxiv. 2024.08.05.606667
#   https://doi.org/10.1101/2024.08.05.606667

# To run, type:
#
#   tcsh s2a.3dDeconvolve_localizer.tcsh

# =============================================================================

# specify participant number
set pname = <ENTER SUBJECT NUMBER>

# specify project directory
set myroot = <INSERT PROJECT HOME DIRECTORY>

# define directories
set predir  = ${myroot}/preprocessed/${pname}        # preprocessed data
set timedir = ${myroot}/timestamps/afni/${pname}     # timestamps

# create output directory
set betadir = ${myroot}/betas_LOC/${pname}
\mkdir -pv ${betadir}

echo "++ Beta dir: ${betadir}"

# ========================================
# Run 3dDeconvolve for the functional localizer runs (block design)

set motion_file = dfileLOC_rall.1D

set epi_files = ( ${predir}/pb05.${pname}.r*.combineLOC+orig.HEAD )

echo "++ EPI files: ${epi_files}"

3dDeconvolve                                                                 \
    -overwrite                                                               \
    -input        ${epi_files}                                               \
    -polort       A                                                          \
    -local_times                                                             \
    -mask         ${predir}/full_mask.${pname}+orig.HEAD                     \
    -jobs         16                                                         \
    -xjpeg        designLOC                                                  \
    -x1D          ${pname}.LOC                                               \
    -ortvec       ${motion_file} motion                                      \
    -num_stimts   2                                                          \
    -stim_times   1 ${timedir}/${pname}_LOCtimestamps_objects.txt            \
                  'BLOCK(16,1)'                                              \
    -stim_label   1 Objects                                                  \
    -stim_times   2 ${timedir}/${pname}_LOCtimestamps_scrambled.txt          \
                  'BLOCK(16,1)'                                              \
    -stim_label   2 Scrambled                                                \
    -num_glt      1                                                          \
    -gltsym       'SYM: +Objects -Scrambled'                                 \
    -glt_label    1 Objects-Scrambled                                        \
    -full_first                                                              \
    -fout                                                                    \
    -tout                                                                    \
    -cbucket      ${betadir}/${pname}.LOCstats.cbucket                       \
    -bucket       ${betadir}/${pname}.LOCstats.bucket

tcsh ${betadir}/${pname}.REML_cmd

