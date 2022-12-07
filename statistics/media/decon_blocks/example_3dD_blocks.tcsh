#!/bin/tcsh

# A demo for convolution options, expanding an example from
# 3dDeconvolve's help.
#
# Here we investigate distinctions between dmBLOCK (dm), dmUBLOCK
# (dmU) with positive args, and dmUBLOCK with negative args (dmUn).
# For the sake of comparisons, we do include cases of no parentheses and
# of param=0 for each case.
#
# Abbrevs
# -------
# 'dm'   -> dmBLOCK, which only has pos param (x>=0)
# 'dmU'  -> dmBLOCK, with pos param (x>=0)
# 'dmUn' -> dmBLOCK, with neg param (x<=0)
#
# ============================================================================

# define a set blocks with progressive durations
set blocks = "0:1 30:2 60:3 90:4 120:5.5 150:6 180:10 210:20 240:40"

echo "${blocks}" > p.1D

# perform the convolution for each case: dm, dmU, dmUn
3dDeconvolve                                                                 \
    -nodata          300 1                                                   \
    -polort          -1                                                      \
    -num_stimts      8                                                       \
    -stim_times_AM1  1 p.1D "dmBLOCK"                                        \
    -stim_times_AM1  2 p.1D "dmBLOCK(0)"                                     \
    -stim_times_AM1  3 p.1D "dmBLOCK(1)"                                     \
    -stim_times_AM1  4 p.1D "dmBLOCK(2)"                                     \
    -stim_times_AM1  5 p.1D "dmBLOCK(3)"                                     \
    -stim_times_AM1  6 p.1D "dmBLOCK(5.5)"                                   \
    -stim_times_AM1  7 p.1D "dmBLOCK(10)"                                    \
    -stim_times_AM1  8 p.1D "dmBLOCK(20)"                                    \
    -x1D             q_dm.1D                                                 

3dDeconvolve                                                                 \
    -nodata          300 1                                                   \
    -polort          -1                                                      \
    -num_stimts      8                                                       \
    -stim_times_AM1  1 p.1D "dmUBLOCK"                                       \
    -stim_times_AM1  2 p.1D "dmUBLOCK(0)"                                    \
    -stim_times_AM1  3 p.1D "dmUBLOCK(1)"                                    \
    -stim_times_AM1  4 p.1D "dmUBLOCK(2)"                                    \
    -stim_times_AM1  5 p.1D "dmUBLOCK(3)"                                    \
    -stim_times_AM1  6 p.1D "dmUBLOCK(5.5)"                                  \
    -stim_times_AM1  7 p.1D "dmUBLOCK(10)"                                   \
    -stim_times_AM1  8 p.1D "dmUBLOCK(20)"                                   \
    -x1D             q_dmU.1D                                                

3dDeconvolve                                                                 \
    -nodata          300 1                                                   \
    -polort          -1                                                      \
    -num_stimts      8                                                       \
    -stim_times_AM1  1 p.1D "dmUBLOCK"                                       \
    -stim_times_AM1  2 p.1D "dmUBLOCK(0)"                                    \
    -stim_times_AM1  3 p.1D "dmUBLOCK(-1)"                                   \
    -stim_times_AM1  4 p.1D "dmUBLOCK(-2)"                                   \
    -stim_times_AM1  5 p.1D "dmUBLOCK(-3)"                                   \
    -stim_times_AM1  6 p.1D "dmUBLOCK(-5.5)"                                 \
    -stim_times_AM1  7 p.1D "dmUBLOCK(-10)"                                  \
    -stim_times_AM1  8 p.1D "dmUBLOCK(-20)"                                  \
    -x1D             q_dmUn.1D                                               


# simplify formatting: output number-only files
1dcat q_dm.1D   > r_dm.1D
1dcat q_dmU.1D  > r_dmU.1D
1dcat q_dmUn.1D > r_dmUn.1D

# =============================================================================
# plotting and concatenating

set figsize  = ( 3.66 7.5 )
set fontsize = 11
set yaxis    = "-0.1:5.5"
set hline    = 1
set dpi      = 300
set xlabel   = "time (vol index)"

1dplot.py                                                                    \
    -infiles       r_dm.1D                                                   \
    -title         'dmBLOCK($x\geq0$)'                                       \
    -ylabels       'No ()' '(0)' '(1)' '(2)' '(3)' '(5.5)' '(10)' '(20)'     \
    -xlabel        "${xlabel}"                                               \
    -censor_hline  ${hline}                                                  \
    -yaxis         ${yaxis}                                                  \
    -figsize       ${figsize}                                                \
    -fontsize      ${fontsize}                                               \
    -dpi           ${dpi}                                                    \
    -prefix        IMG_dm.png                                                

1dplot.py                                                                    \
    -infiles       r_dmU.1D                                                  \
    -title         'dmUBLOCK($x\geq0$)'                                      \
    -ylabels       'No ()' '(0)' '(1)' '(2)' '(3)' '(5.5)' '(10)' '(20)'     \
    -xlabel        "${xlabel}"                                               \
    -censor_hline  ${hline}                                                  \
    -yaxis         ${yaxis}                                                  \
    -figsize       ${figsize}                                                \
    -fontsize      ${fontsize}                                               \
    -dpi           ${dpi}                                                    \
    -prefix        IMG_dmU.png                                               

1dplot.py                                                                    \
    -infiles       r_dmUn.1D                                                 \
    -title         'dmUBLOCK($x\leq0$)'                                      \
    -ylabels       'No ()' '(0)' '(-1)' '(-2)' '(-3)' '(-5.5)' '(-10)' '(-20)' \
    -xlabel        "${xlabel}"                                               \
    -censor_hline  ${hline}                                                  \
    -yaxis         ${yaxis}                                                  \
    -figsize       ${figsize}                                                \
    -fontsize      ${fontsize}                                               \
    -dpi           ${dpi}                                                    \
    -prefix        IMG_dmUn.png                                              

2dcat                                                                        \
    -prefix  img_all_decon_blocks.jpg                                        \
    -gap     5                                                               \
    -gap_col 0 0 0                                                           \
    -nx      3                                                               \
    -ny      1                                                               \
    IMG_dm.png IMG_dmU.png IMG_dmUn.png                           

aiv img_all_decon_blocks.jpg &



exit 0
