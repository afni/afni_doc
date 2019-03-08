#!/usr/bin/env python

import numpy as np
import sys as sys

import afni_util as au

THIS_PROG = 'convert_handouts_list_to_table.py'
NUM_ARGS  = 2                          # two input args needed
OUT_FNAME = ''

# ===================================================================

VERSION   = "1.0"
VER_DATE  = "Mar 8, 2019"
AUTHOR    = "PA Taylor (NIMH, NIH)"

help_string = '''
--------------------------------------------------------------------
Helpfile for:    ***  %s  ***
Version num:     %s
Version dat:     %s
Written by:      %s

Takes %d arguments: 
   1) file containing one-column list
   2) and an output file name.

Outputs:
   1) file of list as list-table, to output file name

--------------------------------------------------------------------

'''  % (THIS_PROG, VERSION, VER_DATE, AUTHOR, NUM_ARGS)

# ===================================================================

def get_arg(aa):
    Narg = len(aa)
    
    if Narg == 0:
        print help_string
        sys.exit(0)
    elif Narg < NUM_ARGS:
        sys.exit("** ERROR: too few args!\n"
                 "   Need one input file name (contains list of files),\n"
                 "   and an output fname.")
    elif Narg > NUM_ARGS:
        sys.exit("** ERROR: too many args! See help.")
    else:
        ifile = aa[0]         # fname
        ofile = aa[1]         # output file name

        print "++ Input file    :", ifile
        print "++ Out file      :", ofile

    return ifile, ofile

# ---------------------------------------------------------------------

def tableize_list( LL, title = '', hrows='' ):

    Nhrows = 0
    if hrows :
        Nhrows = 1
        hrows = '* - ' + hrows

    list_table = '''
.. list-table:: {title}
   :header-rows: {Nhrows} 
   :align: left
   :widths: 50

   {hrows}

'''.format(title=title, Nhrows=Nhrows, hrows=hrows)

    NL = len(LL)

    for i in range(NL):
        xx = LL[i].strip()
        list_table+= '   * - ' + xx

        list_table+= '\n'

    return list_table


# ---------------------------------------------------------------------

def tableize_list_twocol( LL, title = '', hrows='' ):

    Nhrows = 0
    if hrows :
        Nhrows = 1
        hrows = '   * - ' + hrows + '\n'
        hrows+= '     - ' 

    list_table = '''
.. list-table:: {title}
   :header-rows: {Nhrows} 
   :align: left
   :widths: 50 50

{hrows}

'''.format(title=title, Nhrows=Nhrows, hrows=hrows)

    NL = len(LL)
    print("++ afni_handouts dir has {} files".format(NL))

    # zipper-reorder the list
    NLhalf = (NL+1) // 2
    AA  = LL[:NLhalf]
    BB  = LL[NLhalf:]
    BBL = len(BB)

    for i in range(NLhalf):
        xx = AA[i].strip()
        list_table+= '   * - ' + xx
        list_table+= '\n'

        if i < BBL :
            xx = BB[i].strip()
            list_table+= '     - ' + xx
        else:
            list_table+= '     - '
        list_table+= '\n'

    return list_table

# ---------------------------------------------------------------------

def write_output(ostr, ofile):

    fff = open(ofile, 'w')
    fff.write(ostr)
    fff.close()
    
# =================================================================

if __name__=="__main__":

    print "++ Command line:\n   ", ' '.join(sys.argv)
    (ifile, ofile)  =  get_arg(sys.argv[1:])

    all_lines  = au.read_text_file( ifile )

    table_hrow = 'Current files in afni_handouts directory'

    otable     = tableize_list_twocol( all_lines, 
                                       hrows=table_hrow )
    
    write_output(otable, ofile)
