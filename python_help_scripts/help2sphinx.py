#!/usr/bin/env python

########################################################################
## 01/2018 Justin Rajendra
## parse help outputs to make sphinx pages

## system libraries
import sys, os, glob, subprocess, csv, re, shutil, argparse, signal, textwrap

# requires PYTHONPATH to directory of AFNI binaries
from afnipy import afni_util as au

## [PT: Mar 22, 2018] Make the reference for each help in the "All
## Help" section be ".. _ahelp_PROGNAME"
##
## [PT: May 13, 2019] Get rid of vertical pipe chars "|", because
## there were doc build warnings about unindented character...  Don't
## think those were doing much there, anyways.
##
## [PT: May 13, 2019] replace "*" with "\*" to get rid of non-italic
## asterisks causing woe ("WARNING: Inline emphasis start-string
## without end-string.")
#
## [PT: May 23, 2019] *put back* vertical pipe chars "|", because
## they were useful afterall, just like the comment above them had said...
##
## [PT: Feb 15, 2021] Put ":orphan:" at top of files so we don't get
## annoying warning about not being included in toctree
##
## [PT: 27 Dec 2021] Add a fix to deal with Sphinx being clever about
## recognizing option names and expecting (= demanding) an option list
## with very specific formatting to follow it.
##
## [PT: 30 Dec 2021] Include a list of available manuals, too, which
## are stored here: https://afni.nimh.nih.gov/pub/dist/doc/manual/,
## so Gang won't be mad at me anymore.
## -> this is just done as a 'hardwired' list, because it was simple
##    to implement, and we don't expect the manual list to change
##    anymore; that part of getting the list of manuals could always
##    be adapted later by some enterprising spirit.
## + Also, fix issue here with incomplete list(s) being output if the
#    total number of programs was not a factor of 3.

## possible codes as characters
hdr_codes = ['1','2','3','4']

## where we (currently) get the manual list to read
file_pdfman   = 'list_manuals.txt'
## where the base webadress of the files online be
webbase_pdfman = 'https://afni.nimh.nih.gov/pub/dist/doc/manual/'

########################################################################
## functions

## check for a code at the end of a line
## takes in a line from help, returns code as character
def get_code(line_in):

    ## set the header code
    hdr_code = "boo"

    ## get the current line without leading or trailing whitespace
    cur_line = line_in.rstrip().lstrip()

    ## get the last digits and see if the code is there
    line_end = cur_line[-3:]
    if len(line_end) == 3:
        if line_end[0] == "~" and line_end[2] == "~":
            hdr_code = line_end[1]

    return hdr_code

## check the next lines to see if there is a code after a code
def next_line(help_in,line_num):

    ## loop through the next lines
    for l in range(line_num+1,len(help_in)-1):

        ## strip the line and search for a non blank or separator line
        cur_line = help_in[l].rstrip().lstrip()
        if len(set(cur_line)) != 1 and cur_line != "":

            ## get code duh and
            if get_code(help_in[l]) in hdr_codes:
                return(1)
            else:
                return(0)  ## has text but no header code

## this could be done in a fancier way to read from webpage, if that
## is desired in The Future
def get_list_pdfman(fname):
    mlist = au.read_text_file(fname)
    return mlist

########################################################################
## parse command line arguments / build help

## make parser with help
parser = argparse.ArgumentParser(prog=str(sys.argv[0]),
                                 formatter_class=argparse.RawDescriptionHelpFormatter,
                                 description=textwrap.dedent('''\
Overview ~1~

Parse the help output of all AFNI programs (or just one) to create a
sphinxy version.

This program will look for codes in the help output and use those to
make sphinx headers and tables of contents.

The codes are 3 characters at the end of a line of the help output:
~1~ = Main section
~2~ = Sub section
~3~ = Sub sub section
~4~ = Horizontal line separator above the line with the code

Caveats ~1~

If there are no codes, this program will create a code-block of the
help output.  It will also create a table of contents with all
programs listed in a 3 column table.

If you use the -prog option, you will break the main_toc as it will be
overwritten with just one entry. Use this option for testing only!

                                 '''),epilog=textwrap.dedent('''\
------------------------------------------
Justin Rajendra 01/2018
Keep on keeping on!
------------------------------------------
                                 '''))
########################################################################
## collect the arguments

parser._action_groups.pop()
required = parser.add_argument_group('required')
optional = parser.add_argument_group('optional')

required.add_argument('-OutFolder',
                      type=str,
                      help='Where do you want the .rst files to go?',
                      required=True)
optional.add_argument('-prog',
                      type=str,
                      default="nothing",
                      help="Single AFNI program to sphinxify. (For testing only. Will break main_toc.)")
parser.add_argument('-help',action='help',help='Show this help.')


args = parser.parse_args()
prog_list = args.prog

## where to dump the .rst files? (with trailing "/") (create if not there)
OutFolder = args.OutFolder
if OutFolder[-1] != "/":
    OutFolder = OutFolder+"/"
if not os.path.exists(OutFolder):
    os.makedirs(OutFolder)


########################################################################
## get list of afni files or use the one provided
if prog_list == "nothing":
    stat,prog_list = au.exec_tcsh_command("apsearch -list_all_afni_progs",
                                       lines=1,noblank=0)
else:
    prog_list = [prog_list]

########################################################################
## create the main_toc.rst

## open file for writing
toc_file = OutFolder+"main_toc.rst"
main_toc = open(toc_file,"w")

## write out the header
top_text = '''
:tocdepth: 2

.. _programs_main:

###################################
Alphabetical list of program helps
###################################

.. contents:: :local:

Links to program help files
----------------------------

This is a list of all AFNI programs.  Click on any name to see the
help for that program.

For additional reference, please also see the "classified" list of
helps :ref:`HERE<edu_class_prog>`\, where programs are loosely grouped
by topic and functionality, with a brief description of each provided.

.. csv-table::

'''

main_toc.write(top_text)

########################################################################
## main loop through prog_list

## for the main_toc 3 column csv
csv_line = ""
csv_index = 1

for afni_prog in prog_list:

    ## skip the progs that hang on -help
    if afni_prog in ["qdelaunay","qhull","scan_niml_vals.csh"] :
        continue

    ## read in the help file
    stat,help_in = au.exec_tcsh_command(afni_prog+' -help',
                                     lines=1,
                                     noblank=0)

    ## check to see if there was a help
    if len(help_in) < 1:
        # print(help_in)
        print("ERROR: "+afni_prog+" not found or -help failed!")
        # sys.exit(1)
    else:
        print(afni_prog)

    ## add to main_toc as a 3 column csv
    if csv_index == 1:
        csv_line = "   :ref:`"+afni_prog+" <ahelp_"+afni_prog+">`,"
        csv_index = 2
    elif csv_index == 2:
        csv_line = csv_line+":ref:`"+afni_prog+" <ahelp_"+afni_prog+">`,"
        csv_index = 3
    elif csv_index == 3:
        csv_line = csv_line+":ref:`"+afni_prog+" <ahelp_"+afni_prog+">`"
        main_toc.write(csv_line+"\n")
        csv_index = 1

    ## open file for writing
    out_file = OutFolder+afni_prog+"_sphx.rst"
    sphinx_out = open(out_file,"w")

    sphinx_out.write(":orphan:\n\n")

    ## main header as the prog name
    sphinx_out.write(".. _ahelp_"+afni_prog+":\n\n")
    sphinx_out.write((str("*") * len(afni_prog))+"\n")
    sphinx_out.write(afni_prog+"\n")
    sphinx_out.write((str("*") * len(afni_prog))+"\n\n")

    ## table of contents and a blank to remove the indentation for the
    ## next line
    sphinx_out.write(".. contents:: :local:\n\n") # [PT: Aug 29, 2018]
    #sphinx_out.write("    :depth: 4 \n\n")
    sphinx_out.write("\n| \n\n") # got warnings from |

    ## flag for the existence of codes
    has_codes = 0

    ## loop through the lines of the help
    for l in range(0,len(help_in)-1):

        ## get code duh
        code = get_code(help_in[l])

        ## check if it is all the same character (some separator)
        if len(set(help_in[l].rstrip().lstrip())) == 1:
            sphinx_out.write("")

        ######################################
        ## we can has code?
        elif code in hdr_codes:

            ## set the no_codes to something else
            has_codes = 1

            ## strip the current line
            cur_line = help_in[l].rstrip().lstrip()[0:-4]

            # [PT: May 13, 2019] 
            if cur_line.__contains__("*") :
                cur_line = cur_line.replace("*", "\*")

            ### [PT: 27 Dec 2021] The following fix is added to
            ### address the numerous repeated warnings for
            ### timing_tool.py's help:
            #     WARNING: Option list ends without a blank line;
            #     unexpected unindent
            ### The above occurs (and for AP's help, too) for options
            ### that are just flags (i.e., they take no args), or for
            ### ones that have an option name given with >1 space of
            ### separation. The Fix is to escape the initial '-' sign,
            ### so Sphinx doesn't try to be too clever about option
            ### lists.
            if len(cur_line) :
                if cur_line[0] == "-" :
                    #print("  ++ NB replacing the '-':", cur_line)
                    cur_line = "\\" + cur_line
                    #print("     ... with guarded one:", cur_line)

            ## give the appropriate header punctuation and the header
            ## line
            if code == '1':
                sphinx_out.write("\n"+cur_line+"\n")
                sphinx_out.write((str("=") * len(cur_line))+"\n\n")

                if next_line(help_in,l) == 0:
                    sphinx_out.write(".. code-block:: none\n\n")


            elif code == '2':
                sphinx_out.write("\n"+cur_line+"\n")
                sphinx_out.write((str("+") * len(cur_line))+"\n\n")
                sphinx_out.write(".. code-block:: none\n\n")
            elif code == '3':
                sphinx_out.write("\n"+cur_line+"\n")
                sphinx_out.write((str("~") * len(cur_line))+"\n\n")
                sphinx_out.write(".. code-block:: none\n\n")
            elif code == '4':
                ## break line then line as code
                sphinx_out.write((str("-") * len(cur_line))+"\n\n")
                sphinx_out.write(".. code-block:: none\n\n")
                sphinx_out.write("    "+help_in[l][0:-4]+"\n")

        else:
            ## write out the line indented to match the code block
            sphinx_out.write("    "+help_in[l]+"\n")

    ## close the sphinx out
    sphinx_out.close()

    ###############################################################
    ## if no has codes
    if has_codes == 0:

        ## open file for writing
        sphinx_out = open(out_file,"w")

        ## this suppresses maketime warning: <<.. isn't include in any
        ## toctree>>
        sphinx_out.write(":orphan:\n\n")  

        ## table of contents and a blank to remove the indentation for
        ## the next line
        sphinx_out.write(".. _ahelp_"+afni_prog+":\n\n")
        sphinx_out.write((str("*") * len(afni_prog))+"\n")
        sphinx_out.write(afni_prog+"\n")
        sphinx_out.write((str("*") * len(afni_prog))+"\n\n")

        ## table of contents
        sphinx_out.write(".. contents:: :local:\n\n") # [PT: Aug 29, 2018]
        #sphinx_out.write("    :depth: 4 \n\n")
        sphinx_out.write("\n| \n\n") # got warnings from |

        ## set for code block for all
        sphinx_out.write(".. code-block:: none\n\n")

        ## loop through the lines of the help
        for l in range(0,len(help_in)-1):
            sphinx_out.write("    "+help_in[l]+"\n")

    ## close the sphinx out
    sphinx_out.close()

    ## reset code flag
    has_codes = 0
    
# we might also have a last line with <3 elements left to write
if csv_index != 1 :
    main_toc.write(csv_line+"\n")

# =======================================================================
# Bonus, end of year special: Buy one help file listing, get one 
# PDF-manuals for free!

print("++ Add PDF-manual section of 'All Program helps'")

## write out the section header
pdfman_text = '''

.. _programs_main_pdfman:

Links to program manuals
----------------------------

This is a list of all AFNI program manuals, which were written in
ancient times in elvish runes.  These are the few that have been
translated to modern(ish) human speak.

It is possible that some of these manuals refer to programs that are
no longer in circulation, typically having been deprecated for a newer
one.  The "classified" list of program helps
:ref:`HERE<edu_class_prog>`\, contains information on such
deprecations and pointers to the more modern version.

.. csv-table::
   :width: 100%

'''

main_toc.write(pdfman_text)

list_pdfman = get_list_pdfman(file_pdfman)

## for the main_toc 3 column csv
csv_line = ""
csv_index = 1

for pdfman in list_pdfman :
    print(pdfman)

    ## add to main_toc as a 3 column csv
    if csv_index == 1:
        csv_line  = "   `"+pdfman+" <"+webbase_pdfman+pdfman+">`_,"
        csv_index = 2
    elif csv_index == 2:
        csv_line  = csv_line+"`"+pdfman+" <"+webbase_pdfman+pdfman+">`_,"
        csv_index = 3
    elif csv_index == 3:
        csv_line = csv_line+"`"+pdfman+" <"+webbase_pdfman+pdfman+">`_"
        main_toc.write(csv_line+"\n")
        csv_index = 1

# we might also have a last line with <3 elements left to write
if csv_index != 1 :
    main_toc.write(csv_line+"\n")

## close the main_toc
main_toc.close()
