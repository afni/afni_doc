#!/bin/tcsh

# The command to generate ANOVAs for group analysis to generate ANOVAs
# for group analysis to observe the whole-brain activity pattern of CE
# and RE tasks in the present study.  The following abbreviations are
# used: lh = left hemisphere; rh = right hemisphere; CE = curve
# estimation task; RE = roughness estimation task; HMVC = hand motion
# and visual control task.
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
#   tcsh s4.2021_YangEtal_ap.tcsh  TOP_DIR
#
# =========================================================================

set top_dir  = $1
set res_path = ${top_dir}/subject_results/group.HR
set out_path = ${res_path}/GROUP.HR/group.blur6

\mkdir -p ${out_path}

# --------------------------------------------------------------

foreach hemi ( lh rh )
    gen_group_command.py                                                  \
        -command       3dANOVA2                                           \
        -write_script  ${out_path}/HR.ANOVA.RCvsM.${hemi}.proc            \
        -prefix        ${out_path}/HR.ANOVA.RCvsM.${hemi}                 \
        -dsets         ${res_path}/*/*/stats.mean.*.${hemi}.niml.dset     \
        -subs_betas    'RE-HMVC_GLT#0_Coef' 'CE-HMVC_GLT#0_Coef'          \
        -options                                                          \
            -amean 1   RE_HMVC                                            \
            -amean 2   CE_HMVC                                            \
            -adiff 1 2 RE_HMVC_CE_HMVC                                    \
            -adiff 2 1 CE_HMVC_RE_HMVC
end
