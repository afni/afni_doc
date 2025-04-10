#!/bin/tcsh 

# Run 3dDeconvolve for the experimental runs (event-related design, 48
# conditions).  This version produces 1 beta per condition (for use in
# univariate analyses).

# Used in: 

#   Wardle, S. G., Rispoli, B., Roopchansingh, V. & Baker, C. (2024)
#   Brief encounters with real objects modulate medial parietal but
#   not occipitotemporal cortex. bioRxiv. 2024.08.05.606667
#   https://doi.org/10.1101/2024.08.05.606667

# To run, type:
#
#   tcsh s2b.3dDeconvolve_experimental.tcsh

# ===============================================================================

# specify participant number
set pname = <ENTER SUBJECT NUMBER>

# specify project directory
set myroot = <INSERT PROJECT HOME DIRECTORY>

# define directories
set predir  = ${myroot}/preprocessed/${pname}        # preprocessed data
set timedir = ${myroot}/timestamps/afni/${pname}     # timestamps

# create output directory
set betadir=${myroot}/betas_EXP/$pname/
\mkdir -pv ${betadir}

echo "++ Beta dir: ${betadir}"

set motion_file = dfileEXP_rall.1D

set epi_files = ( ${predir}/pb05.$pname.r*.combine+orig.HEAD )

echo "++ EPI files: ${epi_files}"

3dDeconvolve                                                                  \
    -overwrite                                                                \
    -input        ${EXP_epi_files}                                            \
    -polort       A                                                           \
    -local_times                                                              \
    -mask         ${predir}/full_mask.${pname}+orig.HEAD                      \
    -jobs         16                                                          \
    -xjpeg        designEXP                                                   \
    -x1D          ${pname}.EXP                                                \
    -ortvec       ${EXP_motion_file} motion                                   \
    -num_stimts   48                                                          \
    -stim_times  1 ${timedir}/${pname}_Aind01.txt 'GAM' -stim_label  1 Aind01 \
    -stim_times  2 ${timedir}/${pname}_Aind02.txt 'GAM' -stim_label  2 Aind02 \
    -stim_times  3 ${timedir}/${pname}_Aind03.txt 'GAM' -stim_label  3 Aind03 \
    -stim_times  4 ${timedir}/${pname}_Aind04.txt 'GAM' -stim_label  4 Aind04 \
    -stim_times  5 ${timedir}/${pname}_Aind05.txt 'GAM' -stim_label  5 Aind05 \
    -stim_times  6 ${timedir}/${pname}_Aind06.txt 'GAM' -stim_label  6 Aind06 \
    -stim_times  7 ${timedir}/${pname}_Aind07.txt 'GAM' -stim_label  7 Aind07 \
    -stim_times  8 ${timedir}/${pname}_Aind08.txt 'GAM' -stim_label  8 Aind08 \
    -stim_times  9 ${timedir}/${pname}_Aind09.txt 'GAM' -stim_label  9 Aind09 \
    -stim_times 10 ${timedir}/${pname}_Aind10.txt 'GAM' -stim_label 10 Aind10 \
    -stim_times 11 ${timedir}/${pname}_Aind11.txt 'GAM' -stim_label 11 Aind11 \
    -stim_times 12 ${timedir}/${pname}_Aind12.txt 'GAM' -stim_label 12 Aind12 \
    -stim_times 13 ${timedir}/${pname}_Aout01.txt 'GAM' -stim_label 13 Aout01 \
    -stim_times 14 ${timedir}/${pname}_Aout02.txt 'GAM' -stim_label 14 Aout02 \
    -stim_times 15 ${timedir}/${pname}_Aout03.txt 'GAM' -stim_label 15 Aout03 \
    -stim_times 16 ${timedir}/${pname}_Aout04.txt 'GAM' -stim_label 16 Aout04 \
    -stim_times 17 ${timedir}/${pname}_Aout05.txt 'GAM' -stim_label 17 Aout05 \
    -stim_times 18 ${timedir}/${pname}_Aout06.txt 'GAM' -stim_label 18 Aout06 \
    -stim_times 19 ${timedir}/${pname}_Aout07.txt 'GAM' -stim_label 19 Aout07 \
    -stim_times 20 ${timedir}/${pname}_Aout08.txt 'GAM' -stim_label 20 Aout08 \
    -stim_times 21 ${timedir}/${pname}_Aout09.txt 'GAM' -stim_label 21 Aout09 \
    -stim_times 22 ${timedir}/${pname}_Aout10.txt 'GAM' -stim_label 22 Aout10 \
    -stim_times 23 ${timedir}/${pname}_Aout11.txt 'GAM' -stim_label 23 Aout11 \
    -stim_times 24 ${timedir}/${pname}_Aout12.txt 'GAM' -stim_label 24 Aout12 \
    -stim_times 25 ${timedir}/${pname}_Bind13.txt 'GAM' -stim_label 25 Bind13 \
    -stim_times 26 ${timedir}/${pname}_Bind14.txt 'GAM' -stim_label 26 Bind14 \
    -stim_times 27 ${timedir}/${pname}_Bind15.txt 'GAM' -stim_label 27 Bind15 \
    -stim_times 28 ${timedir}/${pname}_Bind16.txt 'GAM' -stim_label 28 Bind16 \
    -stim_times 29 ${timedir}/${pname}_Bind17.txt 'GAM' -stim_label 29 Bind17 \
    -stim_times 30 ${timedir}/${pname}_Bind18.txt 'GAM' -stim_label 30 Bind18 \
    -stim_times 31 ${timedir}/${pname}_Bind19.txt 'GAM' -stim_label 31 Bind19 \
    -stim_times 32 ${timedir}/${pname}_Bind20.txt 'GAM' -stim_label 32 Bind20 \
    -stim_times 33 ${timedir}/${pname}_Bind21.txt 'GAM' -stim_label 33 Bind21 \
    -stim_times 34 ${timedir}/${pname}_Bind22.txt 'GAM' -stim_label 34 Bind22 \
    -stim_times 35 ${timedir}/${pname}_Bind23.txt 'GAM' -stim_label 35 Bind23 \
    -stim_times 36 ${timedir}/${pname}_Bind24.txt 'GAM' -stim_label 36 Bind24 \
    -stim_times 37 ${timedir}/${pname}_Bout13.txt 'GAM' -stim_label 37 Bout13 \
    -stim_times 38 ${timedir}/${pname}_Bout14.txt 'GAM' -stim_label 38 Bout14 \
    -stim_times 39 ${timedir}/${pname}_Bout15.txt 'GAM' -stim_label 39 Bout15 \
    -stim_times 40 ${timedir}/${pname}_Bout16.txt 'GAM' -stim_label 40 Bout16 \
    -stim_times 41 ${timedir}/${pname}_Bout17.txt 'GAM' -stim_label 41 Bout17 \
    -stim_times 42 ${timedir}/${pname}_Bout18.txt 'GAM' -stim_label 42 Bout18 \
    -stim_times 43 ${timedir}/${pname}_Bout19.txt 'GAM' -stim_label 43 Bout19 \
    -stim_times 44 ${timedir}/${pname}_Bout20.txt 'GAM' -stim_label 44 Bout20 \
    -stim_times 45 ${timedir}/${pname}_Bout21.txt 'GAM' -stim_label 45 Bout21 \
    -stim_times 46 ${timedir}/${pname}_Bout22.txt 'GAM' -stim_label 46 Bout22 \
    -stim_times 47 ${timedir}/${pname}_Bout23.txt 'GAM' -stim_label 47 Bout23 \
    -stim_times 48 ${timedir}/${pname}_Bout24.txt 'GAM' -stim_label 48 Bout24 \
    -num_glt      1                                                           \
    -gltsym       'SYM: Aind01 Aind02 Aind03 Aind04 Aind05 Aind06             \
                        Aind07 Aind08 Aind09 Aind10 Aind11 Aind12             \
                        Aout01 Aout02 Aout03 Aout04 Aout05 Aout06             \
                        Aout07 Aout08 Aout09 Aout10 Aout11 Aout12             \
                        -Bind13 -Bind14 -Bind15 -Bind16 -Bind17 -Bind18       \
                        -Bind19 -Bind20 -Bind21 -Bind22 -Bind23 -Bind24       \
                        -Bout13 -Bout14 -Bout15 -Bout16 -Bout17 -Bout18       \
                        -Bout19 -Bout20 -Bout21 -Bout22 -Bout23 -Bout24'      \
    -glt_label    1 SetA-SetB                                                 \
    -full_first                                                               \
    -fout                                                                     \
    -tout                                                                     \
    -cbucket      ${betadir}/${pname}.EXPstats.cbucket                        \
    -bucket       ${betadir}/${pname}.EXPstats.bucket


source ${betadir}/${pname}.REML_cmd

