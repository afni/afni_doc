#!/bin/tcsh


# Using @afni_refacer_run


# ----------------------- A note on examples below -----------------------



# ===================== Example 1: All modes at once =====================


# AFNI tutorial: refacing/defacing anatomical volumes in AFNI
#
# + last update: Feb 21, 2020
#
##########################################################################

# This tcsh script is meant to be run in the following directory of
# the AFNI Bootcamp demo data:
#     AFNI_data6/afni
#
# ----------------------------------------------------------------------

# Example 1: run all reface/deface modes, and check results

@afni_refacer_run                                                     \
    -input anat+orig.                                                 \
    -mode_all                                                         \
    -anonymize_output                                                 \
    -prefix anat


# ======================== Example 2: Reface mode ========================


# Example 2: simple refacing (only)

@afni_refacer_run                                                     \
    -input anat+orig.                                                 \
    -mode_reface                                                      \
    -anonymize_output                                                 \
    -prefix anat_reface.nii.gz


# ==================== Example 3: Note on other modes ====================


