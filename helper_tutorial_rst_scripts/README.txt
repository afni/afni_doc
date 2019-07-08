The *MARK.tcsh (= 'marked up') scripts in this directory can be run on
their own (hopefully), but their main usage is to be converted into
both RST (with accompanying images and text) and script files, using
the @djunct_make_script_and_rst.py program.

An example of running @djunct_make_script_and_rst to create the Sphinx
pages and everything in the right place is (NB: run the following from
AFNI_data6/roi_demo):

 @djunct_make_script_and_rst.py                                              \
     -input          ex_afni11_roi_cmds_MARK.tcsh                            \
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
              Gets echoed into the output tcsh script.

re. code    : All text outside of special env or not on a keyword-flagged
              line is assumed to be CODE, which is executable.  It will be
              copied into the RST as code blocks, and into the script file.

              + When code is translated to the downloadable script
                file, continuation-of-line chars will be evenly spaced.

Special keywords include:

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
                  [stuff]
              TEXTINTRO

              cat << 'TEXTINTRO'
                  [stuff with weird Unix chars, such as matched "`" on
                   sep lines, treated as 'literal'.]
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
              One or many lines long.

              Usage
              -----
              #:HIDE_ON:
                  [code]
              #:HIDE_OFF:

IMAGE       : Inside of TEXT{BLOCK,INTRO}; just for RST, table of images.
              One or many lines, but NO empty lines.
              Can include relative path; can use wildcards (internal globbing).
              Can have 'ragged' table, putting keyword 'NULL' for empty panel.
              Can include optional caption (one line).
             
              Usage
              -----
              #:IMAGE: [title 1]  ||  [optional other title]
                  [IMAGE_1  IMAGE*2
                   NULL     dir/IMAGE_3 
                   IMAGE_4          ]
              #:IMCAPTION: [descriptive text, goes above table]

IMCAPTION   : Optional, see IMAGE env.

INCLUDE     : Inside of TEXT{BLOCK,INTRO}; just for RST, 'literalinclude' file.
              One line, with RST-allowed 'literalinclude' options, such as:
                 :language: none
                 :lines: 1-10

              Usage
              -----
              #:INCLUDE: [file name]
                  :[rst opt]: none


