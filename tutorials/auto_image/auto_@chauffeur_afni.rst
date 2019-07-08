.. _tut_auto_@chauffeur_afni:

***********************************************************
Examples of things with ROIs: resampling and clusterizing
***********************************************************


.. contents:: :local:

Introduction
============

**Download script:** :download:`auto_@chauffeur_afni.tcsh <media/tut_auto_@chauffeur_afni/auto_@chauffeur_afni.tcsh>`


.. highlight:: Tcsh

``@chauffeur_afni`` creates+saves images (JPG, PNG, etc.)  or movies
(MP3, etc.)  of volumetric data sets.  **The primary purpose of this
program is to help users look at their data as and after they process
it.**

It can be used to view either:

* multiple slices within a single 3D volume

* a single slice across a multiple volumes in a 4D dataset.

Image files are produced in sets of 3: one each of axial, coronal and
sagittal slices.  One can view either olay+ulay combinations, or just
a ulay dset.

This program works semi-magically by wrapping around a lot of the
AFNI's underlying "driving" capabilities and environment variables.
The full list of these are provided in these fun documentation pages,
provided for The Curious amongst you:

* The `README.driver
  <https://afni.nimh.nih.gov/pub/dist/doc/program_help/README.driver.html>`_

* `README.environment
  <https://afni.nimh.nih.gov/pub/dist/doc/program_help/README.environment.html>`_

``@chauffeur_afni`` embeds as much of that functionality as possible
(or as asked-for) with the convenience of command line options.

**Historical note:** 
    This program was originally written for use within :ref:`FATCAT
    fat_proc\* tools <FATCAT_prep>` tools (generalizing the
    visualization of ``@snapshot_volreg``).  The ``fat_proc*``
    programs call ``@chauffeur_afni`` internally, generating images at
    each step of the pipeline that can be reviewed later as a first
    pass evaluation of the data processing.  This program drives a lot
    of the image-generating capability of HTML QC output of
    ``afni_proc.py``, too.

**Usage note:**
    Each example below includes a ``-do_clean`` option.  This means
    that a working directory of copied/intermediate data is deleted.
    As of July 8, 2019, it is default behavior to remove that
    directory, so that option is not longer needed.  

    Now, if you want to *keep* the temporary directory, on invokes
    ``-no_clean``.




Examples, and how to run them
===============================

For the ``@chauffeur_afni`` image-making examples below, we use data
of the ``AFNI_data6/afni/`` directory of the freely available AFNI
Bootcamp demo sets (see :ref:`here <Bootcamping>` if you don't have it
yet).

The code snippets can all be run in a single (``tcsh``) script file
(provided above)-- the variable names are consistent throughout the
page, starting from the initial definitions.  Just save the script in
your ``AFNI_data6/afni/`` directory.

A few supplementary volumes/text files will be generated and added to
the directory. The images themselves are put into a subdirectory
called ``QC/`` that is created. Several of the examples include
thresholding statistical output data sets, and therefore include
running additional AFNI programs like ``3dClusterize``, etc.  And all
at no extra charge!

Some of the examples build on each other.  Not every style of image is
the most recommended, but they are chosen to demonstrate a lot of
options, as well as relative benefits of some choices compared to
others.

**To toggle between images**: open each of the images you want to move
between/among in a separate browser tab (e.g., middle mouse click on
it), and then move between tabs (e.g., ``Ctrl + Tab`` and ``Ctrl
+ Shift + Tab``).

**Variable definitions**: The following are relevant variables for the
below commands (``tcsh`` syntax), such as defining the directory
where the data is sitting, dset names, etc.:
 


.. code-block:: Tcsh

   #!/bin/tcsh
   
   # AFNI tutorial: series of examples of automatic image-making in AFNI.
   #
   # + last update: July 8, 2019
   #
   ##########################################################################
   
   # This tcsh script is meant to be run in the following directory of
   # the AFNI Bootcamp demo data:
   #     AFNI_data6/afni
   #
   # ----------------------------------------------------------------------
   
   # anatomical volumes: some present already, and some derived here
   set vol_anat     = anat+orig                              # anatomical vol
   set pre_anat     = `3dinfo -prefix_noext "${vol_anat}"`   # vol prefix
   set pre_tut      = _tut                                   # new dset prefix
   set vol_anat_s   = strip+orig                             # anat. no skull
   set pre_anat_s   = `3dinfo -prefix_noext "${vol_anat_s}"` # vol prefix
   set pre_anat_m   = anat_mask                              # vol prefix
   set vol_anat_m   = ${pre_tut}_${pre_anat_m}.nii.gz        # anat. ss + msk
   set pre_anat_su  = anat_ss_uni                            # vol prefix
   set vol_anat_su  = ${pre_tut}_${pre_anat_su}.nii.gz       # anat. unifized
   set pre_anat_sub = anat_ss_uni_box                        # vol prefix
   set vol_anat_sub = ${pre_tut}_${pre_anat_sub}.nii.gz      # anat. uni + box
   
   # stat/model output vol
   set vol_stat     = func_slim+orig                         # model results
   set pre_stat     = `3dinfo -prefix_noext "${vol_stat}"`   # vol prefix
   
   # EPI volumes: some present already, others derived here
   set vol_epi      = epi_r1+orig                            # EPI vol, 4D
   set pre_epi      = `3dinfo -prefix_noext "${vol_epi}"`    # vol prefix
   set pre_epi_e    = epi_edge0                              # vol prefix
   set vol_epi_e    = ${pre_tut}_${pre_epi_e}.nii.gz         # EPI edgey [0]
   set pre_epi_p    = epi_part                               # vol prefix
   set vol_epi_p    = ${pre_tut}_${pre_epi_p}.nii.gz         # part of EPI
   
   # selecting coef/stat bricks and labels
   set ind_coef   = 3                                        # effect estimate
   set ind_stat   = 4                                        # stat of ee
   set lab_coef   = `3dinfo -label "${vol_stat}[${ind_coef}]"` # str label of ee
   set lab_stat   = `3dinfo -label "${vol_stat}[${ind_stat}]"` # str label of stat
   set lab_statf  = "${lab_stat:gas/#/_/}"                   # str: no '#'
   set lab_coeff  = "${lab_coef:gas/#/_/}"                   # str: no '#'
   
   set stat_map   = ${pre_tut}_${pre_stat}_map.nii.gz        # cluster map 
   set stat_ee    = ${pre_tut}_${pre_stat}_EE.nii.gz         # effect est, clust
   set stat_rep   = ${pre_tut}_${pre_stat}_report.txt        # cluster text rep
   
   # info for thresholding/clustering
   set pthr       = 0.001                                    # voxelwise thresh
   set tail_type  = "bisided"                                # {1,2,bi}sided
   
   # --------------------------------------------------------------------------
   
   
   # make output dir for all images
   \mkdir -p QC
   
   
**Ex. 0**: 3D anatomical volume
---------------------------------

Simply view the anatomical volume as an underlay by itself.  Might be
useful to check for artifact, coverage, etc.  The full crosshair grid
shows where slices are taken from, and might be useful for seeing the
relative alignment/axialization of the brain.

Unless specified otherwise, the ulay black/white mapping is to 0%/98%
of voxels in the whole volume. The AFNI GUI uses 2%/98% of slicewise
percentiles by default, but since default viewing here is
montage-based, volumewise is implemented by default for consistency
across both the individual view-plane montage as well as across three
view-planes that are created per command execution.



.. code-block:: Tcsh

   set opref = QC/ca000_${pre_anat}
   
   @chauffeur_afni                                                       \
       -ulay    ${vol_anat}                                              \
       -prefix  ${opref}                                                 \
       -montx 3 -monty 3                                                 \
       -set_xhairs MULTI                                                 \
       -label_mode 1 -label_size 3                                       \
       -do_clean
   


.. list-table:: 
   :header-rows: 1
   :widths: 50 50 

   * - Example 0
     -  
   * - .. image:: media/tut_auto_@chauffeur_afni/ca000_anat.axi.png
          :width: 100%   
          :align: center
     - .. image:: media/tut_auto_@chauffeur_afni/ca000_anat.cor.png
          :width: 100%   
          :align: center
   * - .. image:: media/tut_auto_@chauffeur_afni/ca000_anat.sag.png
          :width: 100%   
          :align: center
     -

|

**Ex. 1**: 3D anatomical volume
---------------------------------

By default, the image slices are set as follows: if there are N total
images in the montage, place N along each axis spaced as evenly as
possible (as done in the previous example).  

However, users can specify either the (x, y, z) or (i, j, k) location
of the central slice, as well as spacing between each of the N slices
(the "delta" number of rows/columns between image slices).  In this
example the central image is placed at the location (x, y, z) = (0, 0,
0), and different slice spacing is specified along different axes.



.. code-block:: Tcsh

   set opref = QC/ca001_${pre_anat}
   
   @chauffeur_afni                                                       \
       -ulay    ${vol_anat}                                              \
       -prefix  ${opref}                                                 \
       -montx 3 -monty 3                                                 \
       -set_dicom_xyz 0 0 0                                              \
       -delta_slices  5 15 10                                            \
       -set_xhairs MULTI                                                 \
       -label_mode 1 -label_size 3                                       \
       -do_clean
   


.. list-table:: 
   :header-rows: 1
   :widths: 50 50 

   * - Example 1
     -  
   * - .. image:: media/tut_auto_@chauffeur_afni/ca001_anat.axi.png
          :width: 100%   
          :align: center
     - .. image:: media/tut_auto_@chauffeur_afni/ca001_anat.cor.png
          :width: 100%   
          :align: center
   * - .. image:: media/tut_auto_@chauffeur_afni/ca001_anat.sag.png
          :width: 100%   
          :align: center
     -

|

**Ex. 2**: 3D anatomical volume, olay mask
--------------------------------------------

(Going back to evenly spread slices...) Add an overlay with some
transparency to the previous anatomical-- here, a binary mask of the
skullstripped volume to check the quality of the skullstripping
results. The olay color comes from the max of the default colorbar
('Plasma').  The crosshairs have been turned off.



.. code-block:: Tcsh

   # binarize the skullstripped anatomical, if not already done
   if ( ! -e ${vol_anat_m} ) then
       3dcalc                                                            \
           -a ${vol_anat_s}                                              \
           -expr 'step(a)'                                               \
           -prefix ${vol_anat_m}
   endif
   
   set opref = QC/ca002_${pre_anat_m}
   
   @chauffeur_afni                                                       \
       -ulay    ${vol_anat}                                              \
       -olay    ${vol_anat_m}                                            \
       -opacity 4                                                        \
       -prefix  ${opref}                                                 \
       -montx 3 -monty 3                                                 \
       -set_xhairs OFF                                                   \
       -label_mode 1 -label_size 3                                       \
       -do_clean
   
   


.. list-table:: 
   :header-rows: 1
   :widths: 50 50 

   * - Example 2
     -  
   * - .. image:: media/tut_auto_@chauffeur_afni/ca002_anat_mask.axi.png
          :width: 100%   
          :align: center
     - .. image:: media/tut_auto_@chauffeur_afni/ca002_anat_mask.cor.png
          :width: 100%   
          :align: center
   * - .. image:: media/tut_auto_@chauffeur_afni/ca002_anat_mask.sag.png
          :width: 100%   
          :align: center
     -

|

**Ex. 3**: threshold stats voxelwise, view effects
----------------------------------------------------

Pretty standard "vanilla mode" of seeing thresholded statistic results
of (task) FMRI modeling.  In AFNI we strongly recommend viewing the
effect estimate ("coef", like the beta in a GLM, for example) as the
olay, and using its associated statistic for voxelwise
thresholding. The range of the functional data is "3", since that
might be a reasonable max/upper response value for this FMRI data that
has been scaled to meaningful BOLD %signal change units; the colorbar
is just the one that is default in AFNI GUI. 

Here, the underlay is just the skullstripped anatomical volume.  Note
that there is a lot of empty space: this might be a reason to use the
``-delta_slices ..`` option from above.  Another option would be
to "autobox" the ulay volume, as shown below.

The threshold appropriate for this statistic was generated by
specifying a p-value, and then using the program ``p2dsetstat`` to
read the header info for that volume and do the p-to-stat conversion.

Note that the slice location is shown in each panel (in a manner
agnostic to the dset's orientation like RAI, LPI, SRA, etc.).



.. code-block:: Tcsh

   # determine voxelwise stat threshold, using p-to-statistic
   # calculation
   set sthr = `p2dsetstat                                                \
                   -inset "${vol_stat}[${ind_stat}]"                     \
                   -pval $pthr                                           \
                   -$tail_type                                           \
                   -quiet`
   
   echo "++ The p-value ${pthr} was convert to a stat value of: ${sthr}."
   
   set opref = QC/ca003_${pre_stat}_${lab_coeff}
   
   @chauffeur_afni                                                       \
       -ulay  ${vol_anat_s}                                              \
       -olay  ${vol_stat}                                                \
       -func_range 3                                                     \
       -cbar Spectrum:red_to_blue                                        \
       -thr_olay ${sthr}                                                 \
       -set_subbricks -1 ${ind_coef} ${ind_stat}                         \
       -opacity 5                                                        \
       -prefix  ${opref}                                                 \
       -montx 3 -monty 3                                                 \
       -set_xhairs OFF                                                   \
       -label_mode 1 -label_size 3                                       \
       -do_clean
   


.. list-table:: 
   :header-rows: 1
   :widths: 50 50 

   * - Example 3
     -  
   * - .. image:: media/tut_auto_@chauffeur_afni/ca003_func_slim_Arel_0_Coef.axi.png
          :width: 100%   
          :align: center
     - .. image:: media/tut_auto_@chauffeur_afni/ca003_func_slim_Arel_0_Coef.cor.png
          :width: 100%   
          :align: center
   * - .. image:: media/tut_auto_@chauffeur_afni/ca003_func_slim_Arel_0_Coef.sag.png
          :width: 100%   
          :align: center
     -

|

**Ex. 4**: threshold stats voxelwise, view effects, II
--------------------------------------------------------

Quite similar to the above command and output, with a couple changes:

* the colorbar has been changed, to one that shows pos and neg effects
  separately

* the ulay range has been specified in a way to make it darker-- this
  might be useful to allow more olay colors to stick out; in
  particular, yellows/light colors don't get lost in a white/light
  ulay coloration.



.. code-block:: Tcsh

   # Make a nicer looking underlay: unifized and skullstripped
   # anatomical
   if ( ! -e $vol_anat_su ) then
       3dUnifize -GM -prefix $vol_anat_su -input $vol_anat_s
   endif
   
   set opref = QC/ca004_${pre_stat}_${lab_coeff}
   
   @chauffeur_afni                                                       \
       -ulay  ${vol_anat_su}                                             \
       -olay  ${vol_stat}                                                \
       -cbar Reds_and_Blues_Inv                                          \
       -ulay_range 0% 150%                                               \
       -func_range 3                                                     \
       -thr_olay ${sthr}                                                 \
       -set_subbricks -1 ${ind_coef} ${ind_stat}                         \
       -opacity 5                                                        \
       -prefix  ${opref}                                                 \
       -montx 3 -monty 3                                                 \
       -set_xhairs OFF                                                   \
       -label_mode 1 -label_size 3                                       \
       -do_clean
   


.. list-table:: 
   :header-rows: 1
   :widths: 50 50 

   * - Example 4
     -  
   * - .. image:: media/tut_auto_@chauffeur_afni/ca004_func_slim_Arel_0_Coef.axi.png
          :width: 100%   
          :align: center
     - .. image:: media/tut_auto_@chauffeur_afni/ca004_func_slim_Arel_0_Coef.cor.png
          :width: 100%   
          :align: center
   * - .. image:: media/tut_auto_@chauffeur_afni/ca004_func_slim_Arel_0_Coef.sag.png
          :width: 100%   
          :align: center
     -

|

**Ex. 5**: threshold stats voxelwise, view effects, III
---------------------------------------------------------

Another take on thresholding: one without being so strict, and showing
more of the data.  For example, it might be quite informative to still
see some of the "near misses" in the data.  

One can soften the ON/OFF binarization of thresholding, by decreasing
the "alpha" level (or opacity) of sub-threshold voxels in a continuous
manner: either quadratically (used here) or linearly (less steep
decline in visibility).  The black outline still highlights the
suprathreshold locations nicely.



.. code-block:: Tcsh

   set opref = QC/ca005_${pre_stat}_${lab_coeff}_alpha
   
   @chauffeur_afni                                                       \
       -ulay  ${vol_anat_su}                                             \
       -olay  ${vol_stat}                                                \
       -cbar Reds_and_Blues_Inv                                          \
       -ulay_range 0% 150%                                               \
       -func_range 3                                                     \
       -thr_olay   ${sthr}                                               \
       -olay_alpha Yes                                                   \
       -olay_boxed Yes                                                   \
       -set_subbricks -1 ${ind_coef} ${ind_stat}                         \
       -opacity 5                                                        \
       -prefix  ${opref}                                                 \
       -montx 3 -monty 3                                                 \
       -set_xhairs OFF                                                   \
       -label_mode 1 -label_size 3                                       \
       -do_clean
   


.. list-table:: 
   :header-rows: 1
   :widths: 50 50 

   * - Example 5
     -  
   * - .. image:: media/tut_auto_@chauffeur_afni/ca005_func_slim_Arel_0_Coef_alpha.axi.png
          :width: 100%   
          :align: center
     - .. image:: media/tut_auto_@chauffeur_afni/ca005_func_slim_Arel_0_Coef_alpha.cor.png
          :width: 100%   
          :align: center
   * - .. image:: media/tut_auto_@chauffeur_afni/ca005_func_slim_Arel_0_Coef_alpha.sag.png
          :width: 100%   
          :align: center
     -

|

**Ex. 6**: threshold stats voxelwise + clusterize, view effects
-----------------------------------------------------------------

The previous examples were just thresholded voxelwise. This used
``3dClusterize`` to add in cluster-volume thresholding to this;
the program generates both the effect estimate volume ("EE") as well
as a map of the clusters ("map", has a different integer per ROI,
sorted by size) produced by the dual thresholding.  The clustersize of
200 voxels was just chosen arbitrarily (but could be calculated for
real data with ``3dClustSim``, for example).

Comment on ``3dClusterize`` usage: if you have a mask in the
header of the stats file, then you can add an opt "-mask_from_hdr" to
this command to read it directly from the header, similar to usage in
the GUI.

The rest of the visualization aspects of the EE volume here are pretty
similar to the preceding.



.. code-block:: Tcsh

   3dClusterize                                                          \
       -overwrite                                                        \
       -echo_edu                                                         \
       -inset   ${vol_stat}                                              \
       -ithr    ${ind_stat}                                              \
       -idat    ${ind_coef}                                              \
       -${tail_type}  "p=$pthr"                                          \
       -NN             1                                                 \
       -clust_nvox     200                                               \
       -pref_map       ${stat_map}                                       \
       -pref_dat       ${stat_ee}                                        \
     > ${stat_rep}
   
   set opref = QC/ca006_${pre_stat}
   
   @chauffeur_afni                                                       \
       -ulay  ${vol_anat_su}                                             \
       -olay  ${stat_ee}                                                 \
       -cbar Reds_and_Blues_Inv                                          \
       -ulay_range 0% 150%                                               \
       -func_range 3                                                     \
       -opacity    5                                                     \
       -prefix     ${opref}                                              \
       -montx 3 -monty 3                                                 \
       -set_xhairs OFF                                                   \
       -label_mode 1 -label_size 3                                       \
       -do_clean
   


.. list-table:: 
   :header-rows: 1
   :widths: 50 50 

   * - Example 6
     -  
   * - .. image:: media/tut_auto_@chauffeur_afni/ca006_func_slim.axi.png
          :width: 100%   
          :align: center
     - .. image:: media/tut_auto_@chauffeur_afni/ca006_func_slim.cor.png
          :width: 100%   
          :align: center
   * - .. image:: media/tut_auto_@chauffeur_afni/ca006_func_slim.sag.png
          :width: 100%   
          :align: center
     -

|

**Ex. 7**: threshold stats voxelwise + clusterize, view effects, II
---------------------------------------------------------------------

Same olay as above, but just autobox the ulay for a smaller FOV that
has less empty space ("autoboxed" with a wee bit of padding).



.. code-block:: Tcsh

   # Save space: autobox
   if ( ! -e ${vol_anat_sub} ) then
       3dAutobox -prefix ${vol_anat_sub} -npad 7 -input ${vol_anat_su}
   endif
   
   3dClusterize                                                          \
       -overwrite                                                        \
       -echo_edu                                                         \
       -inset   ${vol_stat}                                              \
       -ithr    ${ind_stat}                                              \
       -idat    ${ind_coef}                                              \
       -${tail_type}  "p=$pthr"                                          \
       -NN             1                                                 \
       -clust_nvox     200                                               \
       -pref_map       ${stat_map}                                       \
       -pref_dat       ${stat_ee}                                        \
     > ${stat_rep}
   
   set opref = QC/ca007_${pre_stat}
   
   @chauffeur_afni                                                       \
       -ulay  ${vol_anat_sub}                                            \
       -olay  ${stat_ee}                                                 \
       -cbar Reds_and_Blues_Inv                                          \
       -ulay_range 0% 150%                                               \
       -func_range 3                                                     \
       -opacity    5                                                     \
       -prefix     ${opref}                                              \
       -montx 3 -monty 3                                                 \
       -set_xhairs OFF                                                   \
       -label_mode 1 -label_size 3                                       \
       -do_clean
   


.. list-table:: 
   :header-rows: 1
   :widths: 50 50 

   * - Example 7
     -  
   * - .. image:: media/tut_auto_@chauffeur_afni/ca007_func_slim.axi.png
          :width: 100%   
          :align: center
     - .. image:: media/tut_auto_@chauffeur_afni/ca007_func_slim.cor.png
          :width: 100%   
          :align: center
   * - .. image:: media/tut_auto_@chauffeur_afni/ca007_func_slim.sag.png
          :width: 100%   
          :align: center
     -

|

**Ex. 8**: view ROIs (here, cluster maps)
-------------------------------------------

Here we view the cluster map of the clusterized data. Each ROI is
"labelled" in the data by having a different integer volume, and the
colorbar used now could accommodate the visualization of up to 64
clusters (there are other integer-appropriate colorbars that go up
higher).

Oh, and the background color of zero-valued ulay voxels can be
changed, along with the labelcolor.  

The resolution at which the images are saved is controlled by the
"blowup factor".  By default, the resampling mode of the dsets is just
NN, so that datasets aren't blurred, and as the olay is resampled to
match the ulay resolution the results are not distorted or smoothed
artificially (and integers would stay integers).  This also has a bit
of interaction with how the labels look.  Larger blow-up factors might
not affect how the brain images appear, but they will affect how the
labels look: higher blowup factors leading to finer labels (which may
be harder to read on some screens, depending on settings/programs,
though on paper they would look nicer).  Larger blowup factors might
be necessary for making images to submit as journal figures.  Lots of
things to consider.



.. code-block:: Tcsh

   set opref = QC/ca008_${pre_stat}
   
   @chauffeur_afni                                                       \
       -ulay  ${vol_anat_sub}                                            \
       -olay  ${stat_map}                                                \
       -ulay_range 0% 150%                                               \
       -cbar ROI_i64                                                     \
       -pbar_posonly                                                     \
       -opacity     6                                                    \
       -zerocolor   white                                                \
       -label_color "blue"                                               \
       -blowup      1                                                    \
       -prefix      ${opref}                                             \
       -montx 3 -monty 3                                                 \
       -set_xhairs OFF                                                   \
       -label_mode 1 -label_size 3                                       \
       -do_clean
   


.. list-table:: 
   :header-rows: 1
   :widths: 50 50 

   * - Example 8
     -  
   * - .. image:: media/tut_auto_@chauffeur_afni/ca008_func_slim.axi.png
          :width: 100%   
          :align: center
     - .. image:: media/tut_auto_@chauffeur_afni/ca008_func_slim.cor.png
          :width: 100%   
          :align: center
   * - .. image:: media/tut_auto_@chauffeur_afni/ca008_func_slim.sag.png
          :width: 100%   
          :align: center
     -

|

**Ex. 9**: check alignment with edge view
-------------------------------------------

Check out the alignment between two volumes by making and "edge-ified"
version of one and overlaying it on the other.  This is *quite* useful
in many occasions.  (Note that this is also the purpose of
``@snapshot_volreg``, which is also discussed
:ref:`in this tutorial section here <tut_auto_@snapshot_volreg>`.)

Users can then check the alignment of pertinent things: tissue
boundaries, matching structures, etc.  

Note that in the present case the EPI **hadn't** been aligned to the
anatomical yet, so we might not expect great alignment in the present
scenario (it's basically just a question of how much the subject might
have moved betwixt scans).  The EPI has also relatively low contrast
and spatial resolution, so that the lines are fairly course-- much
more so than if two anatomicals were viewed in this way.  There are
tricks that one can play to enhance the features of the EPI for such
viewing, but that is a larger sidenote (and most readers have likely
rightfully given up detailed reading by this point in the webpage).



.. code-block:: Tcsh

   if ( ! -e ${vol_epi_e} ) then
        3dedge3 -prefix ${vol_epi_e} -input ${vol_epi}'[0]'
   endif
   
   set opref = QC/ca009_${pre_stat}
   
   @chauffeur_afni                                                       \
       -ulay  ${vol_anat_sub}                                            \
       -olay  ${vol_epi_e}                                               \
       -ulay_range 0% 150%                                               \
       -func_range_perc 25                                               \
       -cbar     "red_monochrome"                                        \
       -opacity  6                                                       \
       -prefix   ${opref}                                                \
       -montx 3 -monty 3                                                 \
       -set_xhairs OFF                                                   \
       -label_mode 1 -label_size 3                                       \
       -do_clean
   


.. list-table:: 
   :header-rows: 1
   :widths: 50 50 

   * - Example 9
     -  
   * - .. image:: media/tut_auto_@chauffeur_afni/ca009_func_slim.axi.png
          :width: 100%   
          :align: center
     - .. image:: media/tut_auto_@chauffeur_afni/ca009_func_slim.cor.png
          :width: 100%   
          :align: center
   * - .. image:: media/tut_auto_@chauffeur_afni/ca009_func_slim.sag.png
          :width: 100%   
          :align: center
     -

|

**Ex. 10**: 4D mode
---------------------

This program can also look at one slice across time, using the
``-mode_4D``\ flag-- in the present example, looking at one slice
across the first 17 time points.  This might be useful, for example,
to look for distortions across time (e.g., dropout slices, severe
motion or EPI distortion). 

By default, a slice is chosen hear the center of the volume's FOV, but
users may specify the location.

Here, the per-slice "xyz" label would not represent the location in
space; instead, we use the ``-image_label_ijk`` option to specify
which [n]th volume we are viewing in the time series, starting with
[0]. 



.. code-block:: Tcsh

   # just taking a subset of the time series for this example
   if ( ! -e ${vol_epi_p} ) then
        3dcalc -a ${vol_epi}'[0..16]' -expr 'a' -prefix ${vol_epi_p}
   endif
   
   set opref = QC/ca010_${pre_epi_p}
   
   @chauffeur_afni                                                       \
       -ulay  ${vol_epi_p}                                               \
       -mode_4D                                                          \
       -image_label_ijk                                                  \
       -prefix  ${opref}                                                 \
       -blowup  4                                                        \
       -set_xhairs OFF                                                   \
       -label_mode 1 -label_size 3                                       \
       -do_clean
   


.. list-table:: 
   :header-rows: 1
   :widths: 100 

   * - Example 10
   * - .. image:: media/tut_auto_@chauffeur_afni/ca010_epi_part.sag.png
          :width: 100%   
          :align: center
   * - .. image:: media/tut_auto_@chauffeur_afni/ca010_epi_part.axi.png
          :width: 100%   
          :align: center
   * - .. image:: media/tut_auto_@chauffeur_afni/ca010_epi_part.cor.png
          :width: 100%   
          :align: center

|

