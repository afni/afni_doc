#!/bin/tcsh

set subj    = ${1}
set session = ${2}
set stimdir = ${3}          # timing file dir
set prefix  = errorIMmodel

# ---------------------------------------------------------------------------
# run the regression analysis

3dDeconvolve                                                                 \
    -input          pb05.${subj}.r0*.scale+tlrc.HEAD                         \
    -polort         A                                                        \
    -local_times                                                             \
    -censor         censor_${subj}_combined_2.1D                             \
    -num_stimts     12                                                       \
    -stim_times_IM  1 ${stimdir}/Incon_corr_${subj}-${session}.1D 'GAM'      \
    -stim_label     1 Incong_cor                                             \
    -stim_times_IM  2 ${stimdir}/Incon_com_${subj}-${session}.1D 'GAM'       \
    -stim_label     2 Incong_com                                             \
    -stim_times     3 ${stimdir}/Con_corr_${subj}-${session}.1D 'GAM'        \
    -stim_label     3 Cong_cor                                               \
    -stim_times     4 ${stimdir}/Con_com_${subj}-${session}.1D 'GAM'         \
    -stim_label     4 Cong_com                                               \
    -stim_times     5 ${stimdir}/Con_omission_${subj}-${session}.1D 'GAM'    \
    -stim_label     5 Cong_omi                                               \
    -stim_times     6 ${stimdir}/Incon_omission_${subj}-${session}.1D 'GAM'  \
    -stim_label     6 Incong_omi                                             \
    -stim_file      7 motion_demean.1D'[0]'                                  \
    -stim_base      7                                                        \
    -stim_label     7 roll                                                   \
    -stim_file      8 motion_demean.1D'[1]'                                  \
    -stim_base      8                                                        \
    -stim_label     8 pitch                                                  \
    -stim_file      9 motion_demean.1D'[2]'                                  \
    -stim_base      9                                                        \
    -stim_label     9 yaw                                                    \
    -stim_file      10 motion_demean.1D'[3]'                                 \
    -stim_base      10                                                       \
    -stim_label     10 dS                                                    \
    -stim_file      11 motion_demean.1D'[4]'                                 \
    -stim_base      11                                                       \
    -stim_label     11 dL                                                    \
    -stim_file      12 motion_demean.1D'[5]'                                 \
    -stim_base      12                                                       \
    -stim_label     12 dP                                                    \
    -fout                                                                    \
    -tout                                                                    \
    -GOFORIT        99                                                       \
    -allzero_OK                                                              \
    -cbucket        $prefix.cbucket.stats.${subj}                            \
    -xsave                                                                   \
    -jobs           6                                                        \
    -fout                                                                    \
    -tout                                                                    \
    -x1D            $prefix.X.xmat.1D                                        \
    -xjpeg          $prefix.X.jpg                                            \
    -fitts          $prefix.fitts.${subj}                                    \
    -errts          $prefix.errts.${subj}                                    \
    -bucket         $prefix.stats.${subj}

# if 3dDeconvolve fails, terminate the script
if ( $status != 0 ) then
    echo "------------------------------------------------"
    echo "** 3dDeconvolve error (for $prefix), failing..."
    echo "   subj = ${subj}, session = ${session}"
    echo "   (consider the file 3dDeconvolve.err)"
    exit 1
endif

# ---------------------------------------------------------------------------

# display any large pairwise correlations from the X-matrix
1d_tool.py -show_cormat_warnings -infile X.xmat.1D                           \
    |& tee out.cormat_warn.${prefix}.txt

# display degrees of freedom info from X-matrix
1d_tool.py -show_df_info -infile X.xmat.1D                                   \
    |& tee out.df_info.${prefix}.txt

# -- execute the 3dREMLfit script, written by 3dDeconvolve --
tcsh -x $prefix.REML_cmd -GOFORIT 99

# if 3dREMLfit fails, terminate the script
if ( $status != 0 ) then
    echo "------------------------------------------------"
    echo "** 3dREMLfit error (for $prefix), failing..."
    echo "   subj = ${subj}, session = ${session}"
    exit 1
endif

exit 0
