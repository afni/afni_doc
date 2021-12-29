#!/bin/tcsh

# The command for MVM analysis with 3dMVM for group analysis to
# observe the brain regions parametrically modulated by CE and RE
# tasks in the present study. The following abbreviations are used: lh
# = left hemisphere; rh = right hemisphere; CE = curve estimation
# task; RE = roughness estimation task; HMVC = hand motion and visual
# control task; L1 = degree level one (and similar for L2, etc.).
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
set out_path = ${res_path}/GROUP.MVM

\mkdir -p ${out_path}

foreach hemi ( lh rh ) 
    3dMVM                                                                \
        -prefix   ${out_path}/mvm.${hemi}.niml.dset                      \
        -jobs     6                                                      \
        -wsVars   "task*degree"                                          \
        -SS_type  3                                                      \
        -num_glt  2                                                      \
            -gltLabel 1 roughness -gltCode  1                            \
                'task : 1*Roughness degree : -3*L1 -1*L2 1*L3 3*L4'      \
            -gltLabel 2 curve -gltCode 2                                 \
                'task : 1*Curve degree : -3*L1 -1*L2 1*L3 3*L4'          \
        -dataTable  ${res_path}/data_table_mvm.${hemi}.txt  
end

# --- COMMENT ---
# The '-dataTable ..' input text file contains 4 columns, with the
# following column labels:
#    Subj  condition  degree     InputFile      
# where
#    Subj      = subject ID (sub01, sub02, sub03, etc.)
#    condition = Roughness|Curve
#    degree    = L1|L2|L3|L4
#    InputFile = surface dataset of stats results (stats*.lh.niml.dset
#                or stats*.rh.niml.dset, for the respective data_table*), 
#                with the appropriate effect estimate selected by 
#                specifying the contrast of interest, e.g.:
#                "[RE1-HMVC_GLT#0_Coef]", "[RE2-HMVC_GLT#0_Coef]", 
#                "[CE1-HMVC_GLT#0_Coef]", "[CE2-HMVC_GLT#0_Coef]", etc.
