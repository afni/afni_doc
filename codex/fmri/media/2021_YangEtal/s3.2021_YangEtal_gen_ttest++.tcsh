#!/bin/tcsh

# The command to generate t-tests for group analysis to localize
# specific S1 sub-regions for the index and middle fingers in the
# present study.  The following abbreviations are used: lh = left
# hemisphere; rh = right hemisphere; D1 = index finger; D2 = middle
# finger; D3 = ring finger; D4 = pinky finger.
#
# Used for processing in: 
#
#    Yang J, Molfese PJ, Yu Y, Handwerker DA, Chen G, Taylor PA, Ejima
#    Y, Wu J, Bandettini PA (2021).  Different activation signatures
#    in the primary sensorimotor and higher-level regions for haptic
#    three-dimensional curved surface exploration. Neuroimage
#    231:117754.  https://pubmed.ncbi.nlm.nih.gov/33454415/
#
# To run, type (while providing actual values for TOP_DIR):
#
#   tcsh s3.2021_YangEtal_ap.tcsh  TOP_DIR
#
# =========================================================================

set top_dir  = $1
set res_path = ${top_dir}/subject_results/group.LC
set out_path = ${res_path}/GROUP.LC/ttest

\mkdir -p ${out_path}

# generate t-test scripts and run each to generate dsets.
foreach hemi ( lh rh )
    foreach digit ( D1 D2 D3 D4 )

        gen_group_command.py                                              \
            -command      3dttest++                                       \
            -write_script ${out_path}/LC.ttest.${digit}.${hemi}.proc      \
            -prefix       ${out_path}/group.LC.${digit}.${hemi}           \
            -dsets        ${res_path}/*/*/stats.*.${hemi}.niml.dset       \
            -subs_betas   "${digit}#0_Coef"                               \
            -set_labels   ${digit}

        cd ${out_path}
        tcsh -exf LC.ttest.${digit}.${hemi}.proc
    end
end
