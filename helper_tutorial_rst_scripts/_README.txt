The *MARK.tcsh (= 'marked up') scripts in this directory can be run on
their own (hopefully), but their main usage is to be converted into
both RST (with accompanying images and text) and script files, using
the adjunct_make_script_and_rst.py program.

An example of running adjunct_make_script_and_rst to create the Sphinx
pages and everything in the right place is (NB: run the following from
AFNI_data6/roi_demo):

 # tutorial pages: ROI demo (from afni11 in Bootcamp)
 adjunct_make_script_and_rst.py                                              \
     -input          ex_afni11_roi_cmds_MARK.tcsh                            \
     -reflink        afni11_roi_cmds                                         \
     -prefix_script  afni11_roi_cmds.tcsh                                    \
     -prefix_rst ~/AFNI/afni_doc/tutorials/rois_corr_vis/afni11_roi_cmds.rst \
     -execute_script

 # tutorial pages: @chauffeur_afni
 adjunct_make_script_and_rst.py                                              \
     -input          tut_auto_@chauffeur_afni_MARK.tcsh                      \
     -reflink        tut_auto_@chauffeur_afni                                \
     -prefix_script  auto_@chauffeur_afni.tcsh                               \
     -prefix_rst ~/AFNI/afni_doc/tutorials/auto_image/auto_@chauffeur_afni.rst \
     -execute_script

 # tutorial pages: 2dcat (copy *SSW* vols into ~/AFNI_data6/group_results 
 # and run)
 adjunct_make_script_and_rst.py                                              \
     -input          tut_auto_2dcat_*_MARK.tcsh                              \
     -reflink        tut_auto_2dcat_0                                        \
                     tut_auto_2dcat_1                                        \
                     tut_auto_2dcat_2                                        \
     -prefix_script  tut_auto_2dcat_0.tcsh                                   \
                     tut_auto_2dcat_1.tcsh                                   \
                     tut_auto_2dcat_2.tcsh                                   \
     -prefix_rst ~/AFNI/afni_doc/tutorials/auto_image/auto_2dcat.rst         \
     -execute_script

 # tutorial pages: FS prep (3dcopy, recon-all, @SUMA_Make_Spec_FS)
 adjunct_make_script_and_rst.py                                              \
     -input          tut_fs_fsprep_MARK.tcsh                                 \
     -reflink        tut_fs_fsprep                                           \
     -prefix_script  fs_fsprep.tcsh                                          \
     -prefix_rst     ~/AFNI/afni_doc/tutorials/fs/fs_fsprep.rst    

 # tutorial pages: reface/defae dsets
 # NB: some additional files are in subdir here 'for_refacer', namely the
 # SUMA images showing original+refaced dsets
 adjunct_make_script_and_rst.py                                              \
     -input          tut_auto_@afni_refacer_run_MARK.tcsh                    \
     -reflink        tut_auto_@afni_refacer_run                              \
     -prefix_script  refacer_run.tcsh                                        \
     -prefix_rst     ~/AFNI/afni_doc/tutorials/refacer/refacer_run.rst       \
     -execute_script


(If the images don't need to be changed, then adjunct*py program could
be run without the '-execute_script', in order to just remake the text
stuff.)

** NOTE that the appropriate main_toc.rst would still need to be run to
   add the *.rst file to the documentation tree!

   Additionally, all the created stuff would have to be
   committed+pushed to the git repo to be preserved for future generations.

** A note on 'here document' writing, such as: 
      cat << KW
        ...
      KW

   RST uses the backquote '`' as a special character for many things.
   This can cause trouble for the tcsh script, e.g., if the '`' pair
   is split over multiple lines.
   To escape this badness, as well as other Unix-character-derived
   woes, you can put single quotes around your 'here document' keyword:
      cat << 'KW'
        ...
      'KW'
   In bash, you wouldn't put quotes around the closing KW, but in tcsh you 
   need it.

# ------------------ Guide to environs + keywords ---------------------------

re. shebang : A shebang ('#!/bin/tcsh') is expected at the top of the MARK file.
              Gets echoed into the top of the output tcsh script.

re. code    : All text outside of special env or not on a keyword-flagged
              line is assumed to be CODE, which is executable.  It will be
              copied into the RST as code blocks, and into the script file.

              + When code is translated to the downloadable script
                file, continuation-of-line chars will be evenly spaced.

Special keywords for environments/functionality include:

TITLE       : Main title of RST doc page, and a "# comment" at top of script.
              One line long.

              Usage
              -----
              #:TITLE: something

TEXTINTRO   : Plaintext section at top of RST.
              One or many lines.

              Usage
              -----
              cat << TEXTINTRO
                  ...stuff...
              TEXTINTRO

              cat << 'TEXTINTRO'
                  ...stuff with weird Unix chars, such as matched "`" on
                   separate lines, treated as 'literal'...
              'TEXTINTRO'

TEXTBLOCK   : (Exact same as TEXTINTRO, but not first text block of RST.)

SECTION     : Section title in RST, and a "# === comment ===" in script.
              One line long.

              Usage
              -----
              #:SECTION: something

SUBSECTION  : Subsection title in RST, and a "# --- comment ---" in script.
              One line long.

              Usage
              -----
              #:SUBSECTION: something

HIDE_ON     : Start of hidden code block in RST; normal code in script.
              One or many lines long; must use #:HIDE_OFF: to close it.

              Usage
              -----
              #:HIDE_ON:
                  ...code...
              #:HIDE_OFF:

IMAGE       : Inside of TEXT{BLOCK,INTRO}; just for RST, table of images.
              One or many lines, but NO empty lines.
              Makes a table of images (and/or text):
                   + all entries on one text line form one table row
                   + table can be ragged (differing number of columns)
                   + for "leftward" empty panel, use keyword: NULL
              Image file names can:
                   + include relative path; 
                   + use wildcards (internal globbing).
              Text block must be placed in pair of [[ square brackets]].
              Can include optional caption (one line), via keyword: IMCAPTION.
              Ends with first empty line after #:IMAGE:.

              Usage
              -----
              #:IMAGE:  title 1   ||   optional other title 
                  image_1    image*2
                  [[ descriptive text]] 
                   NULL     dir/image_3 
                   image_4          
              #:IMCAPTION: descriptive text, goes above table

IMCAPTION   : Optional, see IMAGE env.

INCLUDE     : Inside of TEXT{BLOCK,INTRO}; for RST, to 'literalinclude' a file.
              One line, with RST-allowed 'literalinclude' options, such as:
                 :language: none
                 :lines: 1-10

              Usage
              -----
              #:INCLUDE: file_name
                  :rst_opt: rst_opt_value


