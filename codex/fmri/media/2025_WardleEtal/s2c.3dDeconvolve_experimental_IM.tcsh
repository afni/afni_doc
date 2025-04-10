#!/bin/tcsh

# Run 3dDeconvolve for the experimental runs (event-related design, 48
# conditions).  This version is individually modulated (for use in
# multivariate analyses, e.g. decoding) = 1 beta per condition PER RUN.

# Used in: 
# 
#   Wardle, S. G., Rispoli, B., Roopchansingh, V. & Baker, C. (2024)
#   Brief encounters with real objects modulate medial parietal but
#   not occipitotemporal cortex. bioRxiv. 2024.08.05.606667
#   https://doi.org/10.1101/2024.08.05.606667

# To run, type:
#
#   tcsh s2c.3dDeconvolve_experimental_IM.tcsh

# ==============================================================================

# specify participant number
set pname = <ENTER SUBJECT NUMBER>

# specify project directory
set myroot = <INSERT PROJECT HOME DIRECTORY>

# define directories
set predir  = ${myroot}/preprocessed/${pname}        # preprocessed data
set timedir = ${myroot}/timestamps/afni/${pname}     # timestamps

# create output directory
set betadir = ${myroot}/betas_EXP_IM/${pname}
\mkdir -pv ${betadir}

echo "++ Beta dir: ${betadir}"

set motion_file = dfileEXP_rall.1D

# for 3T (MULTIband Multiecho) data, combine is the last step == take
# only the EXP files here (no LOC in filename).
set epi_files = ( ${predir}/pb05.${pname}.r*.combine+orig.HEAD )

echo "++ EPI files: ${epi_files}"


3dDeconvolve                                                                 \
    -overwrite                                                               \
    -input        $epi_files                                                 \
    -polort       A                                                          \
    -local_times                                                             \
    -mask         ${predir}/full_mask.${pname}+orig.HEAD                     \
    -jobs         16                                                         \
    -xjpeg        designEXP                                                  \
    -x1D          ${pname}.EXP                                               \
    -ortvec       ${motion_file} motion                                      \
    -num_stimts   48                                                         \
    -stim_times_IM  1 ${timedir}/${pname}_Aind01.txt 'GAM' -stim_label  1 Aind01 \
    -stim_times_IM  2 ${timedir}/${pname}_Aind02.txt 'GAM' -stim_label  2 Aind02 \
    -stim_times_IM  3 ${timedir}/${pname}_Aind03.txt 'GAM' -stim_label  3 Aind03 \
    -stim_times_IM  4 ${timedir}/${pname}_Aind04.txt 'GAM' -stim_label  4 Aind04 \
    -stim_times_IM  5 ${timedir}/${pname}_Aind05.txt 'GAM' -stim_label  5 Aind05 \
    -stim_times_IM  6 ${timedir}/${pname}_Aind06.txt 'GAM' -stim_label  6 Aind06 \
    -stim_times_IM  7 ${timedir}/${pname}_Aind07.txt 'GAM' -stim_label  7 Aind07 \
    -stim_times_IM  8 ${timedir}/${pname}_Aind08.txt 'GAM' -stim_label  8 Aind08 \
    -stim_times_IM  9 ${timedir}/${pname}_Aind09.txt 'GAM' -stim_label  9 Aind09 \
    -stim_times_IM 10 ${timedir}/${pname}_Aind10.txt 'GAM' -stim_label 10 Aind10 \
    -stim_times_IM 11 ${timedir}/${pname}_Aind11.txt 'GAM' -stim_label 11 Aind11 \
    -stim_times_IM 12 ${timedir}/${pname}_Aind12.txt 'GAM' -stim_label 12 Aind12 \
    -stim_times_IM 13 ${timedir}/${pname}_Aout01.txt 'GAM' -stim_label 13 Aout01 \
    -stim_times_IM 14 ${timedir}/${pname}_Aout02.txt 'GAM' -stim_label 14 Aout02 \
    -stim_times_IM 15 ${timedir}/${pname}_Aout03.txt 'GAM' -stim_label 15 Aout03 \
    -stim_times_IM 16 ${timedir}/${pname}_Aout04.txt 'GAM' -stim_label 16 Aout04 \
    -stim_times_IM 17 ${timedir}/${pname}_Aout05.txt 'GAM' -stim_label 17 Aout05 \
    -stim_times_IM 18 ${timedir}/${pname}_Aout06.txt 'GAM' -stim_label 18 Aout06 \
    -stim_times_IM 19 ${timedir}/${pname}_Aout07.txt 'GAM' -stim_label 19 Aout07 \
    -stim_times_IM 20 ${timedir}/${pname}_Aout08.txt 'GAM' -stim_label 20 Aout08 \
    -stim_times_IM 21 ${timedir}/${pname}_Aout09.txt 'GAM' -stim_label 21 Aout09 \
    -stim_times_IM 22 ${timedir}/${pname}_Aout10.txt 'GAM' -stim_label 22 Aout10 \
    -stim_times_IM 23 ${timedir}/${pname}_Aout11.txt 'GAM' -stim_label 23 Aout11 \
    -stim_times_IM 24 ${timedir}/${pname}_Aout12.txt 'GAM' -stim_label 24 Aout12 \
    -stim_times_IM 25 ${timedir}/${pname}_Bind13.txt 'GAM' -stim_label 25 Bind13 \
    -stim_times_IM 26 ${timedir}/${pname}_Bind14.txt 'GAM' -stim_label 26 Bind14 \
    -stim_times_IM 27 ${timedir}/${pname}_Bind15.txt 'GAM' -stim_label 27 Bind15 \
    -stim_times_IM 28 ${timedir}/${pname}_Bind16.txt 'GAM' -stim_label 28 Bind16 \
    -stim_times_IM 29 ${timedir}/${pname}_Bind17.txt 'GAM' -stim_label 29 Bind17 \
    -stim_times_IM 30 ${timedir}/${pname}_Bind18.txt 'GAM' -stim_label 30 Bind18 \
    -stim_times_IM 31 ${timedir}/${pname}_Bind19.txt 'GAM' -stim_label 31 Bind19 \
    -stim_times_IM 32 ${timedir}/${pname}_Bind20.txt 'GAM' -stim_label 32 Bind20 \
    -stim_times_IM 33 ${timedir}/${pname}_Bind21.txt 'GAM' -stim_label 33 Bind21 \
    -stim_times_IM 34 ${timedir}/${pname}_Bind22.txt 'GAM' -stim_label 34 Bind22 \
    -stim_times_IM 35 ${timedir}/${pname}_Bind23.txt 'GAM' -stim_label 35 Bind23 \
    -stim_times_IM 36 ${timedir}/${pname}_Bind24.txt 'GAM' -stim_label 36 Bind24 \
    -stim_times_IM 37 ${timedir}/${pname}_Bout13.txt 'GAM' -stim_label 37 Bout13 \
    -stim_times_IM 38 ${timedir}/${pname}_Bout14.txt 'GAM' -stim_label 38 Bout14 \
    -stim_times_IM 39 ${timedir}/${pname}_Bout15.txt 'GAM' -stim_label 39 Bout15 \
    -stim_times_IM 40 ${timedir}/${pname}_Bout16.txt 'GAM' -stim_label 40 Bout16 \
    -stim_times_IM 41 ${timedir}/${pname}_Bout17.txt 'GAM' -stim_label 41 Bout17 \
    -stim_times_IM 42 ${timedir}/${pname}_Bout18.txt 'GAM' -stim_label 42 Bout18 \
    -stim_times_IM 43 ${timedir}/${pname}_Bout19.txt 'GAM' -stim_label 43 Bout19 \
    -stim_times_IM 44 ${timedir}/${pname}_Bout20.txt 'GAM' -stim_label 44 Bout20 \
    -stim_times_IM 45 ${timedir}/${pname}_Bout21.txt 'GAM' -stim_label 45 Bout21 \
    -stim_times_IM 46 ${timedir}/${pname}_Bout22.txt 'GAM' -stim_label 46 Bout22 \
    -stim_times_IM 47 ${timedir}/${pname}_Bout23.txt 'GAM' -stim_label 47 Bout23 \
    -stim_times_IM 48 ${timedir}/${pname}_Bout24.txt 'GAM' -stim_label 48 Bout24 \
    -full_first                                                              \
    -fout                                                                    \
    -tout                                                                    \
    -cbucket      ${betadir}/${pname}.EXPstatsIM.cbucket                     \
    -bucket       ${betadir}/${pname}.EXPstatsIM.bucket


source ${betadir}/${pname}.REML_cmd


