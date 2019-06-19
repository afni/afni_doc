The scripts in this directory can be run on their own (hopefully), but
their main usage is to be converted into both RST (with accompanying
images and text) and script files, using the
@djunct_make_script_and_rst.py program.

An example of running @djunct_make_script_and_rst to create the Sphinx
pages and everything in the right place is (NB: run the following from
AFNI_data6/roi_demo):

 @djunct_make_script_and_rst.py                                              \
     -input          ex_afni11_roi_cmds.tcsh                                 \
     -reflink        afni11_roi_cmds                                         \
     -prefix_script  afni11_roi_cmds.tcsh                                    \
     -prefix_rst ~/AFNI/afni_doc/tutorials/rois_corr_vis/afni11_roi_cmds.rst \
     -execute_script

(If the images don't need to be changed, then it could be run without
the '-execute_script', in order to just remake the text stuff.)

** NOTE that the appropriate main_toc.rst would still need to be run to
   add the *.rst file to the documentation tree!

   Additionally, all the created stuff would have to be
   committed+pushed to the git repo to be preserved for future generations.
