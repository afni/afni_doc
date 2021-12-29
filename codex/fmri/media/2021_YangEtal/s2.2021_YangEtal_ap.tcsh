#!/bin/tcsh

# The afni_proc.py command used to process the somatotopic finger
# mapping runs in the present study. In the stimulus timing files and
# general linear tests (GLTs), the following abbreviations are used to
# specify task types: D1 = index finger; D2 = middle finger; D3 = ring
# finger; D4 = pinky finger.
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
#   tcsh s2.2021_YangEtal_ap.tcsh  SUBJ_ID  TOP_DIR
#
# =========================================================================

set subj    = $1  # provide subject ID
set top_dir = $2  # provide top directory location, e.g., for group

afni_proc.py                                                                \
    -subj_id               ${subj}                                          \
    -script                proc.${subj}                                     \
    -scr_overwrite                                                          \
    -blocks                tshift align volreg surf blur scale regress      \
    -copy_anat             ${top_dir}/${subj}/anat_00/t1w_ns.nii.gz         \
    -anat_has_skull        no                                               \
    -tcat_remove_first_trs 2                                                \
    -blip_reverse_dset     ${top_dir}/${subj}/blip/blip+orig.HEAD           \
    -dsets                 ${top_dir}/${subj}/task/lcrun+orig.HEAD          \
    -volreg_align_to       third                                            \
    -volreg_align_e2a                                                       \
    -align_opts_aea        -cmass cmass                                     \
    -surf_anat             ${top_dir}/${subj}/SUMA/${subj}_SurfVol.nii      \
    -surf_spec             ${top_dir}/${subj}/SUMA/std.141.${subj}_?h.spec  \
    -blur_size             6.0                                              \
    -regress_stim_times                                                     \
        ${top_dir}/${subj}/onset/D1.txt                                     \
        ${top_dir}/${subj}/onset/D2.txt                                     \
        ${top_dir}/${subj}/onset/D3.txt                                     \
        ${top_dir}/${subj}/onset/D4.txt                                     \
    -regress_stim_labels    D1 D2 D3 D4                                     \
    -regress_basis          'BLOCK(18,1)'                                   \
    -regress_censor_motion  0.3                                             \
    -regress_opts_3dD                                                       \
        -gltsym 'SYM: D1 +D2 +D3 +D4' -glt_label 1 all_digits               \
    -regress_make_ideal_sum sum_ideal.1D

