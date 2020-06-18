#!/usr/bin/env python

import numpy as np
import sys as sys
import os

from afnipy import afni_util as au

THIS_PROG = 'make_substeps_of_quickbuilds.py'
NUM_ARGS  = 1

# ===================================================================

VERSION   = "1.0"
VER_DATE  = "Mar 29, 2018"
AUTHOR    = "PA Taylor (NIMH, NIH)"

help_string = '''
--------------------------------------------------------------------
Helpfile for:    ***  %s  ***
Version num:     %s
Version dat:     %s
Written by:      %s

Takes %d arguments: 
   1) and an output directory name
--------------------------------------------------------------------

'''  % (THIS_PROG, VERSION, VER_DATE, AUTHOR, NUM_ARGS)

# =================================================================




# =================================================================

def make_hidden_code_block_header( starthidden='True', 
                                   hcb_format='None',
                                   label='- show script y/n -',
                                   nempty=2,
                                   lspace=3):
    """
    Make a hidden-code-block in RST;  a couple params get entered.
    """

    lpad = ' '*lspace
    jstr = '\n' + lpad

    hcb_list = []
    hcb_list.append( '''.. hidden-code-block:: {}'''.format(hcb_format))
    hcb_list.append( '''   :starthidden: {}'''.format(starthidden))
    hcb_list.append( '''   :label: {}'''.format(label))

    for i in range(nempty):
        hcb_list.append( '')

    return lpad + jstr.join(hcb_list)

def make_code_block_header( cb_format='None',
                            nempty=2):
    """
    Make a code-block in RST;  a couple params get entered.
    """

    jstr = '\n'

    cb_list = []
    cb_list.append( '''.. code-block:: {}'''.format(cb_format))

    for i in range(nempty):
        cb_list.append( '')

    return jstr.join(cb_list)

# ---------------------------------------------------------------------

def get_arg(aa):
    Narg = len(aa)
    
    if Narg == 0:
        print( help_string )
        sys.exit(0)
    elif Narg < NUM_ARGS:
        sys.exit("** ERROR: too few args!\n"
                 "   Need one input file name (contains all tips),\n"
                 "   and an output fname.")
    elif Narg > NUM_ARGS:
        sys.exit("** ERROR: too many args! See help.")
    else:
        odir = aa[0]         # output dir name

        print( "++ odir      : {}".format( odir ))

    return odir

# ---------------------------------------------------------------------

def parse_data_file_top(H, lspace=3):
    """
    We assume each top-of-file contains 5 lines:
    + "Quick" ... comment
    + comment about tcsh/bash
    + actual command
    + comment about tcsh/bash
    + actual command
    """
    
    lpad = " "*lspace

    N = len(H)
    nstart = -1

    for ii in range(N):
        line = H[ii].split()
        if len(line) > 1 :
            if line[1] == "Quick" :
                nstart = ii
                break

    if nstart < 0 :
        print("** ERROR: couldn't find keyword 'Quick' starting a line!\n"
              "   I am lost with how to process this file")
        sys.exit(1)

    out = []
    # skip "Quick" line
    for ii in [nstart+1, nstart+3]:
        out.append(lpad + "* *... " + H[ii][1:].strip()[:-1] + '*::\n')
        out.append(lpad + "  " + "   " + H[ii+1][1:].strip() + '\n')

    return out

# ---------------------------------------------------------------------

def write_out_quickbuild_substep(ofile, ttt):
    fff = open(ofile, 'w')

    fff.writelines(ttt)
    fff.close()


# ====================================================================

class quickbuild:

    def __init__(self, name, tip, num):
        self.package = name
        self.links   = []
        self.nlinks  = 0

# ====================================================================

if __name__=="__main__":

    # --------------------- get input ------------------------

    print( "++ Command line:\n   {}".format(' '.join(sys.argv) ))
    odir  =  get_arg(sys.argv[1:])

    # where to get stuff, from the interweb
    base_path = "https://raw.githubusercontent.com/afni/afni/"
    base_path+= "master/src/other_builds"

    # ----------------------------------------------------------
    this_sys  = 'linux_ubuntu_20_64'
    oname_sys = 'substep_quickbuild_' + this_sys
    
    list_files = []
    list_comms = []

    comm = '''To install packages requiring admin privileges '''
    comm+= '''('sudo' password required)...'''
    list_files.append('OS_notes.linux_ubuntu_20_64_a_admin.txt')
    list_comms.append(comm)
    
    comm = '''To install other dependencies (**don't** use 'sudo' here)...'''
    list_files.append('OS_notes.linux_ubuntu_20_64_b_user.tcsh')
    list_comms.append(comm)

    comm = '''To niceify your terminal (optional, but useful)...'''
    list_files.append('OS_notes.linux_ubuntu_20_64_c_nice.tcsh')
    list_comms.append(comm)
    
    # download files
    nfiles    = len(list_files)
    list_data = []
    list_curl = []

    for ii in range(nfiles):
        ifile  = list_files[ii]
        curler = "curl -O %s/%s" % (base_path, ifile)
        os.system(curler)
        list_curl.append(curler)

        fff  = open(ifile, 'r')
        data = fff.readlines()
        fff.close()
        list_data.append(data)


    # build text string
    otext = ""

    otext+= '\n\n'

    otext+= '''This is a briefer form of the above setup instructions.\n'''
    otext+= '''It includes downloading the Bootcamp data and running\n'''
    otext+= '''the system check (so don't forget to check that!).\n'''

    otext+= '\n\n'

    otext+= '''There are 3 scripts to run.\n'''
    otext+= '''To download them, copy+paste:'''
    otext+= '\n\n'

    # code-block: curl commands
    hdr_cb = make_code_block_header()
    otext+= hdr_cb
    otext+= '   ' + 'cd\n'
    otext+= '   ' + '\n   '.join(list_curl)
    otext+= '\n\n'

    otext+= "Then run each of them, as described below.\n"
    otext+= "(Each creates a log file, for checking and/or asking questions.)\n"
    otext+= '\n\n'

    lspace = 3
    lpad   = ' '*lspace

    # hidden-code-block: each file
    for ii in range(nfiles):

        otext+= "#. " + list_comms[ii]
        otext+= '\n\n'

        run_cmd = parse_data_file_top(list_data[ii])
        otext+= '\n'.join(run_cmd)
        otext+= '\n\n'

        hdr_hcb = make_hidden_code_block_header()
        otext+= hdr_hcb
        jstr  = lpad + '   '
        otext+= '   ' + jstr.join(list_data[ii])
        otext+= '\n\n'
        otext+= lpad + '|\n'

    write_out_quickbuild_substep(odir + '/' + oname_sys + '.rst', 
                                 otext)

    print("++ Done writing RST for quickbuild instructions!")

    sys.exit(0)
