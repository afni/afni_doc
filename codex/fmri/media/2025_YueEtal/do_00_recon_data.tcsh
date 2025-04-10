#!/bin/tcsh

# This is an example code for one subject, to reconstruct anatomical
# and functional images from the raw data.

# From:
# 
#  Yue Q, Newton AT, Marois R (2025). Ultrafast fMRI reveals serial
#  queuing of information processing during multitasking in the human
#  brain. Nat Commun 16(1):3057.
#  https://pmc.ncbi.nlm.nih.gov/articles/PMC11953464/

# ===========================================================================

# set paths 
set topdir = /Volumes/Seagate/prp_data

# list of all subject IDs
set all_sub = ( s773 )

set all_subjn = ( 341285 )


foreach subjn ( ${all_subjn} ) # loop over all subj num
    foreach sub ( ${all_sub} ) # loop over all subj IDs

        set ssdir = ${topdir}/${sub}/Marois_${subjn}

        cd ${ssdir}/T1_3D_TFE_iso070_501
        to3d                                                                 \
            -spgr                                                            \
            -orient   ASL                                                    \
            -session  ../../                                                 \
            -prefix   ${sub}_anat *.dcm

        cd ${ssdir}/T1_3D_TFE_iso070_SENSE_Axial_502
        to3d                                                                 \
            -spgr                                                            \
            -orient   RAI                                                    \
            -session  ../../                                                 \
            -prefix   ${sub}_anat_axial *.dcm

        cd ${ssdir}/T1_3D_TFE_iso070_SENSE_Coronal_503
        to3d                                                                 \
            -spgr                                                            \
            -orient   RSA                                                    \
            -session  ../../                                                 \
            -prefix   ${sub}_anat_coronal *.dcm

        foreach run ( `seq 601 100 1501` ) # loop over all runs

            cd ${ssdir}/Task_199ms_1600dyn_${run}

            Dimon                                                            \
                -infile_pattern    '*.dcm'                                   \
                -GERT_Reco                                                   \
                -quit                                                        \
                -use_last_elem                                               \
                -use_slice_loc                                               \
                -dicom_org                                                   \
                -sort_by_acq_time
            to3d                                                             \
                -prefix         ${sub}_task01 -time:zt 26 1600 199 zero      \
                -use_last_elem                                               \
                -session        ../../ -@ < dimon.files.run.${run}

        end
    end
end
