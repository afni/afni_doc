#!/bin/tcsh

# DESC: run AP to fully process FMRI data (here, for the salmon scan)

# Process a single subj+ses pair. Run it from its partner run*.tcsh script.
# Run on a slurm/swarm system (like Biowulf) or on a desktop.

# ---------------------------------------------------------------------------

# use slurm? 1 = yes, 0 = no (def: use if available)
set use_slurm = $?SLURM_CLUSTER_NAME

# ----------------------------- biowulf-cmd ---------------------------------
if ( $use_slurm ) then
    # load modules: ***** add any other necessary ones
    source /etc/profile.d/modules.csh
    module load afni

    # set N_threads for OpenMP
    setenv OMP_NUM_THREADS $SLURM_CPUS_ON_NODE
endif
# ---------------------------------------------------------------------------

# initial exit code; we don't exit at fail, to copy partial results back
set ecode = 0

# set relevant environment variables
setenv AFNI_COMPRESSOR GZIP           # zip BRIK dsets

# ---------------------------------------------------------------------------
# top level definitions (constant across demo)
# ---------------------------------------------------------------------------

# labels
set subj           = $1
set ses            = $2

# for convenience, "full" subj ID and path
set subjid = ${subj}_${ses}
set subjpa = ${subj}/${ses}

# upper directories
set dir_inroot     = ${PWD:h}                        # one dir above scripts/
set dir_log        = ${dir_inroot}/logs
set dir_basic      = ${dir_inroot}/data_00_basic
set dir_ap         = ${dir_inroot}/data_21_ap
set dir_clust      = ${dir_inroot}/data_50_clust

# subject directories
set sdir_basic     = ${dir_basic}/${subjpa}
set sdir_func      = ${sdir_basic}/func
set sdir_anat      = ${sdir_basic}/anat
set sdir_ap        = ${dir_ap}/${subjpa}
set sdir_clust     = ${dir_clust}/${subjpa}

# supplementary directory (reference data, etc.)
###set dir_suppl      = ${dir_inroot}/supplements
###set template       = ${dir_suppl}/*****

# ** set output directory 
set sdir_out = ${sdir_clust}
set lab_out  = 50_clust

# --------------------------------------------------------------------------
# data and control variables
# --------------------------------------------------------------------------

# dataset inputs

# data to copy to output/working dir
set resdir       = ${sdir_ap}/${subj}.results
set dset_anat    = anat_final.${subj}+orig.HEAD
set dset_stats   = stats.sub-000+orig.HEAD
set dset_errts   = errts.${subj}+orig.HEAD
set dset_fin_epi = final_epi_vr_base_min_outlier+orig.HEAD
set file_xmat    = X.xmat.1D

# control variables

# ----- set cluster parameters
set csim_NN     = "2"          # neighborhood definition (face+edge)
set csim_sided  = "bisided"    # 2sided test, sep pos/neg
set csim_pthr   = 0.001        # voxelwise thr in 3dClustSim
set csim_alpha  = 0.05         # nominal FDR

set nclust_simple = 3          # simple cluster extent


# check available N_threads and report what is being used
set nthr_avail = `afni_system_check.py -disp_num_cpu`
set nthr_using = `afni_check_omp`

echo "++ INFO: Using ${nthr_using} of available ${nthr_avail} threads"

# ----------------------------- biowulf-cmd --------------------------------
if ( $use_slurm ) then
    # try to use /lscratch for speed; store "real" output dir for later copy
    if ( -d /lscratch/$SLURM_JOBID ) then
        set usetemp  = 1
        set sdir_BW  = ${sdir_out}
        set sdir_out = /lscratch/$SLURM_JOBID/${subjid}

        # prep for group permission reset
        \mkdir -p ${sdir_BW}
        set grp_own  = `\ls -ld ${sdir_BW} | awk '{print $4}'`
    else
        set usetemp  = 0
    endif
endif
# ---------------------------------------------------------------------------

# ---------------------------------------------------------------------------
# run programs
# ---------------------------------------------------------------------------

# make output directory, go to it, and copy some data in
\mkdir -p ${sdir_out}
cd ${sdir_out}
echo "++ Running in : ${PWD}"

3dcopy -overwrite ${resdir}/${dset_anat} .
3dcopy -overwrite ${resdir}/${dset_stats} .
3dcopy -overwrite ${resdir}/${dset_errts} .
3dcopy -overwrite ${resdir}/${dset_fin_epi} .
\cp    ${resdir}/${file_xmat} .

if ( ${status} ) then
    set ecode = 1
    goto COPY_AND_EXIT
endif

# the final mask here has a lot of holes, so we make a new one and
# also run some cluster simulations again, in that mask.

# ----- make WB mask for final EPI results 

# name of whole brain mask to create
set mask_wb   = mask_anat_in_epi_final.nii.gz

# calc from anat dset extent
3dAutomask                                                  \
    -overwrite                                              \
    -prefix     mask_anat.nii.gz ${dset_anat}

3dresample                                                  \
    -overwrite                                              \
    -prefix     mask_anat_in_epi.nii.gz                     \
    -master     ${dset_fin_epi}                             \
    -rmode      NN                                          \
    -input      mask_anat.nii.gz

# dilate+shrink, filling holes
3dmask_tool                                                 \
    -overwrite                                              \
    -prefix         mask_anat_in_epi_dil.nii.gz             \
    -dilate_inputs  3 -3                                    \
    -input          mask_anat_in_epi.nii.gz

# make sure mask overlaps with where EPI data exists
3dcalc                                                      \
    -overwrite                                              \
    -a          mask_anat_in_epi_dil.nii.gz                 \
    -b          ${dset_fin_epi}                             \
    -expr       'a*bool(b)'                                 \
    -prefix     ${mask_wb}

if ( ${status} ) then
    set ecode = 2
    goto COPY_AND_EXIT
endif

# ----- make dset for image ulay (autobox and smooth slightly)

# don't waste image space on empty regions
3dAutobox                                                        \
    -overwrite                                                   \
    -prefix     mask_anat_abox.nii.gz                            \
    -npad       10                                               \
    -noclust    mask_anat.nii.gz

3dZeropad                                                        \
    -overwrite                                                   \
    -prefix     anat_aboxed.nii.gz                               \
    -master     mask_anat_abox.nii.gz                            \
    ${dset_anat}

# smooth the anatomical a bit, for underlaying in images
3dLocalstat                                                      \
    -overwrite                                                   \
    -nbhd       "SPHERE(1)"                                      \
    -stat       osfilt                                           \
    -prefix     anat_aboxed_osfilt.nii.gz                        \
    anat_aboxed.nii.gz

if ( ${status} ) then
    set ecode = 3
    goto COPY_AND_EXIT
endif

# ----- calculate ACF within WB mask 

# same way afni_proc.py creates this (and only do this 

if ( ! -f new_blur_est.${subj}.1D ) then  # START_ACF
    touch new_blur_est.${subj}.1D

    set nepi = 2
    set runs = (`count -digits 2 1 ${nepi}`)

    # restrict to uncensored TRs, per run
    foreach run ( $runs )
        set trs = `1d_tool.py -infile X.xmat.1D -show_trs_uncensored encoded \
                              -show_trs_run $run`
        if ( $trs == "" ) continue
        3dFWHMx \
            -overwrite                                                   \
            -detrend -mask ${mask_wb}                                    \
            -ACF new_files_3dFWout.3dFWHMx.ACF.errts.r$run.1D            \
            errts.${subj}+orig"[$trs]" >> new_blur_est.${subj}.1D
    end

    # get average of ACF params across runs: first 3 values from ACF rows
    # only
    set blur_est = ( `3dTstat -mean -prefix -     \
                        new_blur_est.${subj}.1D'[0..2]{1,3}'\'` )

    echo "++ blur est : ${blur_est}"

    # this is kinda slow, so don't repeat
    3dClustSim                                       \
        -overwrite                                   \
        -both                                        \
        -mask   ${mask_wb}                           \
        -acf    ${blur_est}                          \
        -prefix ClustSim 

    if ( ${status} ) then
        set ecode = 4
        goto COPY_AND_EXIT
    endif

endif # END_ACF

set clust_thrvol = `1d_tool.py -verb 0                                  \
                        -infile ClustSim.NN${csim_NN}_${csim_sided}.1D  \
                        -csim_pthr   ${csim_pthr}                       \
                        -csim_alpha  ${csim_alpha}`

echo "++ MCC nvoxels : ${clust_thrvol}"

# ----- clusterize for two cases 

# this is now just informational, and for WB mask cases, since we
# have the @chauffeur cmds include clusterize directly, below

# No multiple comparisons correction:
# only voxelwise thresholding, no cluster thresholding (clust thr = 3)
3dClusterize                                                                 \
    -overwrite                                                               \
    -nosum                                                                   \
    -1Dformat                                                                \
    -inset       stats.${subj}+orig.HEAD                                     \
    -idat        "checkbrd#0_Coef"                                           \
    -ithr        "checkbrd#0_Tstat"                                          \
    -NN          ${csim_NN}                                                  \
    -clust_nvox  ${nclust_simple} -${csim_sided} p=${csim_pthr}              \
    -pref_map    Clust_map_NO_MCC_mskd.nii.gz                                \
    -pref_dat    Clust_dat_NO_MCC_mskd.nii.gz                                \
    -mask        ${mask_wb} > Clust_table_NO_MCC_mskd.1D

# Using multiple comparisons correction:
# both voxelwise and clusterwise thresholding
3dClusterize                                                                 \
    -overwrite                                                               \
    -nosum                                                                   \
    -1Dformat                                                                \
    -inset       stats.${subj}+orig.HEAD                                     \
    -idat        "checkbrd#0_Coef"                                           \
    -ithr        "checkbrd#0_Tstat"                                          \
    -NN          ${csim_NN}                                                  \
    -clust_nvox  ${clust_thrvol} -${csim_sided} p=${csim_pthr}               \
    -pref_map    Clust_map_YES_MCC_mskd.nii.gz                               \
    -pref_dat    Clust_dat_YES_MCC_mskd.nii.gz                               \
    -mask        ${mask_wb} > Clust_table_YES_MCC_mskd.1D

if ( ${status} ) then
    set ecode = 5
    goto COPY_AND_EXIT
endif

# ----- Make images of cluster outputs 

set ulay   = anat_aboxed_osfilt.nii.gz 
set olay   = ${dset_stats}

# from earlier checks, we saw that Cluster #2 from one of hte runs
# above was a nice location to view
set coords = ( `3dCM -Icent Clust_map_NO_MCC_mskd.nii.gz'<3>'` )

# these settings are constant across all imgs
set img_params = ( \
            -cbar              Reds_and_Blues_Inv   \
            -ulay_range        0% 130%              \
            -thr_olay_p2stat   0.001                \
            -thr_olay_pside    bisided              \
            -blowup            4                    \
            -opacity           9                    \
            -montx             1                    \
            -monty             1                    \
            -set_dicom_xyz     ${coords}            \
            -olay_boxed_color  'limegreen'          \
            -set_xhairs        OFF                  \
            -no_cor                                 \
            -label_mode        0                    \
            -label_size        0                    )

# Make images for various cases:
# ... like transparent thresholding: ON or OFF
set all_ab     = ( Yes No )
# ... cluster size thr: simple (3 voxels), or derived from 3dClustSim, above
set all_nclust = ( ${nclust_simple} ${clust_thrvol} ) 
# ... overlay type: coefficient/effect estimate, or t-stat
set all_otype  = ( Coef Tstat )

foreach ab ( ${all_ab} )
    foreach nclust ( ${all_nclust} )
        foreach otype ( ${all_otype} )
            set alpha = ${ab}
            set boxed = ${ab}
            set nnn   = `printf "%03d" ${nclust}`

            # olay range of colorbar
            if ( "${otype}" == "Tstat" ) then
                set frange = 4.5
            else
                set frange = 3
            endif

            # apply WB mask or not
            if ( "${ab}" == "No" ) then
                set optmask = "-mask ${mask_wb}"
                set mmm     = WB
            else
                set optmask = ""
                set mmm     = None
            endif

            # descriptive output prefix
            set opref = img_v3_salmon_alpha-${alpha}_boxed-${boxed}
            set opref = ${opref}_olay-${otype}_mask-${mmm}_clustn-${nnn}

            @chauffeur_afni                                                  \
                -ulay           ${ulay}                                      \
                -olay           ${olay}                                      \
                -prefix         ${opref}                                     \
                -clusterize     "-NN 2 -clust_nvox ${nclust} ${optmask}"     \
                -func_range     ${frange}                                    \
                -set_subbricks  0 "checkbrd#0_${otype}" "checkbrd#0_Tstat"   \
                -olay_alpha     ${alpha}                                     \
                -olay_boxed     ${boxed}                                     \
                -prefix         ${opref}                                     \
                ${img_params}

            if ( ${status} ) then
                set ecode = 5
                goto COPY_AND_EXIT
            endif
        end
    end
end

echo "++ FINISHED ${lab_out}"

# ---------------------------------------------------------------------------

COPY_AND_EXIT:

# ----------------------------- biowulf-cmd --------------------------------
if ( $use_slurm ) then
    # if using /lscratch, copy back to "real" location
    if( ${usetemp} && -d ${sdir_out} ) then
        echo "++ Used /lscratch"
        echo "++ Copy from: ${sdir_out}"
        echo "          to: ${sdir_BW}"
        \cp -pr   ${sdir_out}/* ${sdir_BW}/.

        # reset group permission
        chgrp -R ${grp_own} ${sdir_BW}
    endif
endif
# ---------------------------------------------------------------------------

if ( ${ecode} ) then
    echo "++ BAD FINISH: ${lab_out} (ecode = ${ecode})"
else
    echo "++ GOOD FINISH: ${lab_out}"
endif

exit ${ecode}

