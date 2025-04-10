#!/bin/tcsh

# Create stimulus timing files for afni_proc.py

# From:
# 
#  Yue Q, Newton AT, Marois R (2025). Ultrafast fMRI reveals serial
#  queuing of information processing during multitasking in the human
#  brain. Nat Commun 16(1):3057.
#  https://pmc.ncbi.nlm.nih.gov/articles/PMC11953464/

# ===========================================================================

# list of all subject IDs
set all_sub = ( s707 s709 s710 s713 s718 s719 s722 s726 s735 s736 \
                s738 s741 s747 s748 s750 s751 s755 s759 s760 s761 \
                s763 s764 s765 s766 s768 s773 )

# list of all stimulus conditions
set all_cond = ( AO VM S_AOVM S_VMAO L_AOVM L_VMAO AO_response VM_response )

foreach sub ( ${all_sub} )  # loop over all subj IDs

    cd ~/Downloads/prp_scripts/timing/${sub}

    # partition trials according to correct/incorrect response in each of
    # task conditions
    foreach cond ( ${all_cond} ) # loop over all conditions

        timing_tool.py                                                       \
            -timing     all_trials_${cond}.txt                               \
            -partition  partition_${cond}.txt                                \
            ${cond}
    end

    # left vs. right manual response
    timing_tool.py                                                           \
        -timing     VM_response_correct.1D                                   \
        -partition  partition_VM_response_correct_l_vs_r.txt                 \
        VM_response_correct

    timing_tool.py                                                           \
        -timing     VM_correct.1D                                            \
        -partition  partition_VM_response_correct_l_vs_r.txt                 \
        VM_correct


    # partition trials according to AO task RT quartiles
    timing_tool.py                                                           \
        -timing     AO_correct.1D                                            \
        -partition  partition_AO_rt_quartile.txt                             \
        AO_correct


    # partition trials according to VM task RT quartiles
    timing_tool.py                                                           \
        -timing     VM_correct.1D                                            \
        -partition  partition_VM_rt_quartile.txt                             \
        VM_correct

end
