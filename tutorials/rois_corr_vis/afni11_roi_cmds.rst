.. _afni11_roi_cmds:

***********************************************************
Examples of things with ROIs: resampling and clusterizing
***********************************************************


.. contents:: :local:

Introduction
-------------

**Download script:** :download:`afni11_roi_cmds.tcsh <media/afni11_roi_cmds/afni11_roi_cmds.tcsh>`


This demo accompanies the afni11*pdf presentation that is part of the
AFNI Bootcamp.

Briefly, this describes was to both resample and use ROIs to extract
values of interest from data: sometimes averaging within the ROI,
sometimes extracting all voxel values. 

Clusterizing is also performed on the command line.  We also
demonstrate using `whereami`` in conjunction with clusterizing: first,
to identify in which ROI a voxel might be located (WRT some atlas);
and second, what atlas regions a clusterized ROI overlaps with.

Examples of auto-imagemaking with ``@chauffeur_afni`` are also
provided (typically in the "hidden" code blocks).

An **ROI** is defined to be a set of voxels that have the same integer
value.  In general, these can include both positive and negative
values.  

A **mask** is a set of nonzero voxels, that is essentially binary; the
distinction of individual voxel values is ignored, and it is
essentially one giant ROI.

Note that sometimes the dset input with ``-mask ..`` will be treated
as a **mask** (the set of all nonzero voxels forms a single,
undifferentiated region) and sometimes as a map of **ROIs** (each set
of voxels of a given value will be treated separately).  Please check
the help file carefully for correct usage.






.. code-block:: Tcsh

   #!/bin/tcsh
   
   # AFNI demo: part of afni11*pdf talk about ROIs
   #
   # + last update: May 19, 2019
   #
   ##########################################################################
   
   # This script is meant to be run in the following directory of the
   # AFNI Bootcamp demo data:
   #     AFNI_data6/roi_demo
   
Resampling (regridding) ROIs
------------------------------

We start with an ROI in original anatomical (=high res) space.

We then resample the data, using the ``NN`` resampling mode to
preserve integer values.



.. code-block:: Tcsh

   # Change grid/resolution of data set from (high res) anat to 
   # (low res) EPI
   3dresample                                                            \
       -overwrite                                                        \
       -master rall_vr+orig                                              \
       -prefix anat_roi_resam                                            \
       -inset anat_roi+orig                                              \
       -rmode NN
   


.. hidden-code-block:: Tcsh
   :starthidden: True
   :label: - show code y/n -

   
   # image before resampling
   set cent_of_mass = `3dCM anat_roi+orig`
    
   @chauffeur_afni                                                       \
       -ulay  anat+orig                                                  \
       -olay  anat_roi+orig                                              \
       -ulay_range 0% 120%                                               \
       -cbar ROI_i64                                                     \
       -set_dicom_xyz ${cent_of_mass}                                    \
       -opacity 9                                                        \
       -prefix   IMG_roi_orig                                            \
       -montx 1 -monty 1                                                 \
       -set_xhairs OFF                                                   \
       -label_mode 1 -label_size 3                                       \
       -do_clean
   
   @chauffeur_afni                                                       \
       -ulay  rall_vr+orig                                               \
       -olay  anat_roi_resam+orig                                        \
       -ulay_range 0% 110%                                               \
       -cbar ROI_i64                                                     \
       -set_dicom_xyz ${cent_of_mass}                                    \
       -set_subbricks 0 0 0                                              \
       -opacity 9                                                        \
       -blowup 4                                                         \
       -prefix   IMG_roi_resam                                           \
       -montx 1 -monty 1                                                 \
       -set_xhairs OFF                                                   \
       -label_mode 1 -label_size 3                                       \
       -do_clean
   


.. list-table:: 
   :header-rows: 1
   :widths: 50 50 

   * - Original ROI
     - Resampled ROI
   * - .. image:: media/afni11_roi_cmds/IMG_roi_orig.sag.png
          :width: 100%   
          :align: center
     - .. image:: media/afni11_roi_cmds/IMG_roi_resam.sag.png
          :width: 100%   
          :align: center

Averaging quantities within a mask
------------------------------------

Calculate the average value of the voxels in the ROI, per time point,
and dump the result to a text file (via the redirect ``>`` operator;
otherwise, results are just shown in the terminal).

Note that any value >0 in the ``-mask ..`` dset would be recognized as
a single ROI here.



.. code-block:: Tcsh

   # Average within ROI mask, per volume
   3dmaskave                                                             \
       -mask anat_roi_resam+orig                                         \
       -quiet                                                            \
       rall_vr+orig > epi_avg.1D
   

The following are ways to view the output time series, as numbers
and/or plots:



.. code-block:: Tcsh

   # ... and view dumped text file results, just a column of numbers
   cat epi_avg.1D
   
   # Plot the time series (without the "-jpg ...", a GUI opens with the plot).
   1dplot -jpg IMG_epi_avg -yaxis 1000:1200:2:1 epi_avg.1D
   
   # ... and, if you have Python + matplotlib
   1dplot.py -prefix IMG_epi_avg_py.jpg -yaxis 1000:1200 -infiles epi_avg.1D
   
   

Excerpt of text file:


.. literalinclude:: media/afni11_roi_cmds/epi_avg.1D
   :lines: 1-10
   :language: none


.. list-table:: 
   :header-rows: 1
   :widths: 50 50 

   * - 1dplot version
     - 1dplot.py version
   * - .. image:: media/afni11_roi_cmds/IMG_epi_avg.jpg
          :width: 100%   
          :align: center
     - .. image:: media/afni11_roi_cmds/IMG_epi_avg_py.jpg
          :width: 100%   
          :align: center

Extracting individual voxel values within a mask
--------------------------------------------------

We could also dump the *values* of a dset's voxels that reside within
a mask region into a text file.  In the present example no coordinate
locations are saved in the file, but one could save the coordinates of
each voxel, too (as indices, by *not* including ``-noijk``; or as
physical coors, by using ``-xyz``):



.. code-block:: Tcsh

   # Save values of individual voxels within the ROI
   3dmaskdump                                                            \
       -noijk                                                            \
       -mask anat_roi_resam+orig                                         \
       func_slim+orig'[2]' > Vrel-tstats.txt
   
   # ... and view dumped text file results
   cat Vrel-tstats.txt
   
   

leads to ->


.. literalinclude:: media/afni11_roi_cmds/Vrel-tstats.txt
   :language: none

Calculating stats from separate ROIs
--------------------------------------

One might also have a dataset with multiple ROIs.  Recall that each
ROI is just defined by being a set of voxels with the same integer
value.  One can even have negative values of integers define an ROI.

The following program will calculate averages (or other statistical
quantities) from a given dset within each ROI:



.. code-block:: Tcsh

   # Compute separate statistics for each ROI in a volume
   3dROIstats                                                            \
       -mask 3rois+orig                                                  \
       func_slim+orig'[0]'                                               \
       > stats_3rois.txt
   
   # ... and view dumped text file results
   cat stats_3rois.txt
   
   

The information in "stats_3rois.txt" is displayed as a grid of
headers/labels and data, but the columns might not always align,
unfortunately:


.. literalinclude:: media/afni11_roi_cmds/stats_3rois.txt
   :language: none

Note that running the same command with the ``-quiet`` option would
produce the same numbers, but without the text descriptions.  That
might be more useful for scripting purposes.

Clusterizing, visualizing and extracting info about ROIs
----------------------------------------------------------

A clusterizing example, using labels to specify stat and effect
estimate volumes, and using a p-value (with bi-sided testing) to
specify voxelwise threshold.

Bi-sided testing is similar to two-sided, with the additional
constraint that positive and negative voxels cluster separately.
(With just two-sided clustering, a single cluster could contain both
positive and negative effects, which is probably not what most people
would want for this process.)

Here, we have made up a volume threshold of 200 voxels-- that could be
calculated, for example, by 3dClustSim or something.  



.. code-block:: Tcsh

   # Note the use of labels to specify relevant subbricks and the p-value
   # to specify the voxelwise threshold.
   3dClusterize                                                          \
       -overwrite                                                        \
       -1Dformat                                                         \
       -inset func_slim+orig                                             \
       -idat 'Vrel#0_Coef'                                               \
       -ithr 'Vrel#0_Tstat'                                              \
       -NN 2                                                             \
       -clust_nvox 200                                                   \
       -bisided p=0.0001                                                 \
       -pref_map Clust_map.nii.gz                                        \
       -pref_dat Clust_dat.nii.gz                                        \
       > Clust_report.1D
   


.. hidden-code-block:: Tcsh
   :starthidden: True
   :label: - show code y/n -

   
   @chauffeur_afni                                                       \
       -ulay  anat+orig                                                  \
       -olay  Clust_dat.nii.gz                                           \
       -box_focus_slices AMASK_FOCUS_OLAY                                \
       -cbar Reds_and_Blues_Inv                                          \
       -ulay_range 0% 110%                                               \
       -func_range 3                                                     \
       -opacity 6                                                        \
       -prefix   IMG_clust_dat                                           \
       -montx 7 -monty 1                                                 \
       -set_xhairs OFF                                                   \
       -label_mode 1 -label_size 3                                       \
       -do_clean
   
   @chauffeur_afni                                                       \
       -ulay  anat+orig                                                  \
       -olay  Clust_map.nii.gz                                           \
       -box_focus_slices AMASK_FOCUS_OLAY                                \
       -cbar ROI_glasbey_256                                             \
       -ulay_range 0% 110%                                               \
       -pbar_posonly                                                     \
       -opacity 7                                                        \
       -prefix   IMG_clust_map                                           \
       -montx 7 -monty 1                                                 \
       -set_xhairs OFF                                                   \
       -label_mode 1 -label_size 3                                       \
       -do_clean
   


.. list-table:: 
   :header-rows: 1
   :widths: 100 

   * - Betas and ROI maps after clusterizing
   * - .. image:: media/afni11_roi_cmds/IMG_clust_dat.axi.png
          :width: 100%   
          :align: center
   * - .. image:: media/afni11_roi_cmds/IMG_clust_map.axi.png
          :width: 100%   
          :align: center

In this example, the text report of the results (= "cluster table")
has also been saved, using the ``>`` redirect to dump it to a text file.
Here, it contains both the numerical information about clusters, as
well as text description and column headers in comments.


.. literalinclude:: media/afni11_roi_cmds/Clust_report.1D
   :language: none

AFNI programs will be able to read just the numbers from this file,
using standard selectors like '[]'.  One can also display just the
numbers with the following AFNI command: ``1dcat Clust_report.1D`` or,
relatedly, ``1dcat Clust_report.1D > Clust_report_numbers.1D``

Finding ROI locations in atlases with "whereami"
--------------------------------------------------

AFNI's ``whereami`` provides information with respect to atlases that
the user has on their system.  One can provide either a single
coordinate set (e.g., a peak location or center of mass) or an entire
ROI, and find out its approximate overlap with atlas regions.

In the case of individual coordinates, "nearby" ROIs are also listed,
because neither alignment nor atlas definition are perfect...



.. code-block:: Tcsh

   # ... and use the center of mass (CM) locations of clusters, as
   # determined using the '[..]' selectors, for identification in loaded
   # atlases with 'whereami'
   whereami                                                              \
      -tab                                                               \
      -coord_file Clust_report.1D'[1,2,3]'                               \
      > Clust_whereami_CM.1D
   
   # ... AND we could use the map of ROIs to find out locations, based on
   # overlaps in loaded atlases, also with whereami
   whereami                                                              \
      -omask Clust_map.nii.gz                                            \
      > Clust_whereami_olap.1D
   
