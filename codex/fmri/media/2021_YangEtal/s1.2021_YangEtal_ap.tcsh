#!/bin/tcsh

# The afni_proc.py command used to process the curve and roughness
# estimation runs in the present study. In the stimulus timing files
# and general linear tests (GLTs), the following abbreviations are
# used to specify task types: CE = curve estimation tasks; RE =
# roughness estimation tasks; HMVC = hand motion and visual control
# task.
#
# Used for processing in: 
#
#    Yang J, Molfese PJ, Yu Y, Handwerker DA, Chen G, Taylor PA, Ejima
#    Y, Wu J, Bandettini PA (2021).  Different activation signatures
#    in the primary sensorimotor and higher-level regions for haptic
#    three-dimensional curved surface exploration. Neuroimage
#    231:117754.  https://pubmed.ncbi.nlm.nih.gov/33454415/
#
# To run for a single subject, type (while providing actual values for
# SUBJ_ID and TOP_DIR):
#
#   tcsh s1.2021_YangEtal_ap.tcsh  SUBJ_ID  TOP_DIR
#
# =========================================================================

set subj    = $1  # provide subject ID
set top_dir = $2  # provide top directory location, e.g., for group

afni_proc.py                                                                  \
    -subj_id               ${subj}                                            \
    -script                proc.${subj}                                       \
    -scr_overwrite                                                            \
    -blocks                tshift align volreg surf blur scale regress        \
    -copy_anat             ${top_dir}/${subj}/anat_00/t1w_ns.nii.gz           \
    -anat_has_skull        no                                                 \
    -tcat_remove_first_trs 2                                                  \
    -blip_reverse_dset     ${top_dir}/${subj}/blip/blip+orig.HEAD             \
    -dsets                 ${top_dir}/${subj}/task/run?+orig.HEAD             \
    -volreg_align_to       third                                              \
    -volreg_align_e2a                                                         \
    -align_opts_aea        -cmass cmass                                       \
    -surf_anat             ${top_dir}/${subj}/SUMA/${subj}_SurfVol.nii        \
    -surf_spec             ${top_dir}/${subj}/SUMA/std.141.${subj}_?h.spec    \
    -blur_size             6.0                                                \
    -regress_stim_types    IM                                                 \
    -regress_stim_times                                                       \
        ${top_dir}/${subj}/onset/CE1.txt                                      \
        ${top_dir}/${subj}/onset/CE2.txt                                      \
        ${top_dir}/${subj}/onset/CE3.txt                                      \
        ${top_dir}/${subj}/onset/CE4.txt                                      \
        ${top_dir}/${subj}/onset/HMVC.txt                                     \
        ${top_dir}/${subj}/onset/RE1.txt                                      \
        ${top_dir}/${subj}/onset/RE2.txt                                      \
        ${top_dir}/${subj}/onset/RE3.txt                                      \
        ${top_dir}/${subj}/onset/RE4.txt                                      \
    -regress_stim_labels     CE1 CE2 CE3 CE4 HMVC RE1 RE2 RE3 RE4             \
    -regress_basis           'BLOCK(5,1)'                                     \
    -regress_censor_motion   0.3                                              \
    -regress_opts_3dD                                                         \
        -gltsym 'SYM: 0.25*RE1 +0.25*RE2 +0.25*RE3 +0.25*RE4 -HMVC' -glt_label 1 RE-HMVC \
        -gltsym 'SYM: 0.25*CE1 +0.25*CE2 +0.25*CE3 +0.25*CE4 -HMVC' -glt_label 2 CE-HMVC \
        -gltsym 'SYM: RE1 -HMVC' -glt_label 3  RE1-HMVC                       \
        -gltsym 'SYM: RE2 -HMVC' -glt_label 4  RE2-HMVC                       \
        -gltsym 'SYM: RE3 -HMVC' -glt_label 5  RE3-HMVC                       \
        -gltsym 'SYM: RE4 -HMVC' -glt_label 6  RE4-HMVC                       \
        -gltsym 'SYM: CE1 -HMVC' -glt_label 7  CE1-HMVC                       \
        -gltsym 'SYM: CE2 -HMVC' -glt_label 8  CE2-HMVC                       \
        -gltsym 'SYM: CE3 -HMVC' -glt_label 9  CE3-HMVC                       \
        -gltsym 'SYM: CE4 -HMVC' -glt_label 10 CE4-HMVC                       \
    -regress_make_ideal_sum  sum_ideal.1D
