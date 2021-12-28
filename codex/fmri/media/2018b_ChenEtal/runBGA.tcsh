#!/bin/tcsh

# Example of Bayesian multilevel (BML) modeling for group-level
# analysis.  Uses data table in standard AFNI format (similar to
# 3dMVM, 3dLME, etc.) that is in file "test_ToMI_1106.txt".
#
# To execute, type:
#   tcsh runBGA.tcsh
#
# Note that this program requires specific R packages like brms (and
# its dependencies) to run.  If packages are missing, please try
# running:
#   rPkgsInstall -pkgs ALL
# to install any missing ones.
#
# ver  : 1.1
# date : Oct 05, 2018
# auth : G Chen, JK Rajendra
#
#===================================================================

BayesianGroupAna.py                    \
    -dataTable test_ToMI_1106.txt      \
    -y zscore                          \
    -x total                           \
    -prefix test                       \
    -chains 4 -iterations 1000         \
    -RData

