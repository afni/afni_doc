#!/usr/bin/env python

import numpy as np
import sys as sys
import os

import afni_util as au

THIS_PROG = 'make_file_of_gui_tips.py'
NUM_ARGS  = 2                          # two input args needed

# ===================================================================

AUTHOR    = "PA Taylor (NIMH, NIH)"
#
#VERSION   = "1.0"; VER_DATE  = "Oct 21"
#
VERSION   = "1.1"; VER_DATE  = "Oct 21"
# + [PT] fixed indentation stuff
#
# ------------------------------------------------------------------

text_label = ".. _edu_gui_tips:"

text_title_desc = \
'''

*****************************
**List of all AFNI GUI tips**
*****************************

.. contents:: :local:

Overview
--------

There are typically (at least) four ways of controlling behavior in
the AFNI GUI: 

* clicking a button or menu item

* using a keypress (i.e., keyboard shortcut)

* providing command line options for the GUI to use as it opens
  (referred to as **driving** AFNI).

* setting an environment variable (such as in your ``~/.afnirc`` file)

And in some cases, left- and right-clicks do different things, as
well!  Note that the SUMA GUI has the same trio of controllability
options.

Here we list many of useful GUI features, mainly focusing on clicking
and keypresses; once you know these, you are actually a good ways into
being able to drive AFNI well, too.

We might/should add more over time.

|

'''

# ----------------------------------------------------------------

help_string = '''
--------------------------------------------------------------------
Helpfile for:    ***  %s  ***
Version num:     %s
Version dat:     %s
Written by:      %s

Takes %d arguments: 
   1) file containing all startup tips;
   2) and an output file name.
--------------------------------------------------------------------

'''  % (THIS_PROG, VERSION, VER_DATE, AUTHOR, NUM_ARGS)

# =================================================================

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
        ifile = aa[0]         # fname
        ofile = aa[1]         # output file name

        print( "++ Input file    : {}".format( ifile ))
        print( "++ Out file      : {}".format( ofile ))

    return ifile, ofile


def is_empty(x) :
    ''' Is x a string, and does it look empty?
'''
    try:
        y = x.strip()
        if not(y):
            return 1
        return 0
    except:
        return 0

def is_spacer(x) :
    ''' Is x a string, and does it look like a line spacer?
'''
    try:
        y = x.strip()
        if y.__contains__('-'*30) :
            return 1
        else:
            return 0
    except:
        return 0

def is_sec_title(x) :
    ''' Is x a string, and does it look like a section title?
'''
    try:
        y = x.strip()
        if y[:5] == '*'*5 :
            return 1
        else:
            return 0
    except:
        return 0

def is_sec_descrip( x, prev_emp=0 ) :
    '''Is x a string, and does it look like a section descip?

    (1) Some text ...
    (2) Some text ...
    (371895) Some text ...
    etc.

    Need to know about previous line, to not get fooled by other cases
of numbers in parentheses.

    '''
    try:
        y = x.strip()
        if y[0] == '(' :
            if y[1].isdigit() :
                if prev_emp :
                    return 1
        return 0
    except:
        return 0

def is_subtip_starter(x) :
    ''' Is x a string, and does it look like the start of a new tip?

    (a) Some text ...
    (b) Some text ...
    (aa) Some text ...
    etc.
'''

    try:
        y = x.strip()
        if y[0] == '(' :
            if y[1].isalpha() :
                if y[2] == ')' :
                    return 1
            return 0
        else:
            return 0
    except:
        return 0

def count_indent_space( x ):
    '''count whitespace indentation; any tabs are replaced with 4 spaces,
    to start.

    if input x is not a string, return: -1

    '''

    try:
        y = x.expandtabs( tabsize=4 )
        N  = len(y)
        ll = 0

        while ll < N and y[ll] == ' ' :
            ll+= 1
                
        return ll

    except:
        # not countable
        return -1

def is_line_continuation( x, prev_ind=0 ) :
    if not( is_empty(x) ) and       \
       not( is_spacer(x) ) and      \
       not( is_sec_title(x) ) and   \
       not( is_sec_descrip(x) ) and \
       not( is_subtip_starter(x) ) and  \
       not(x.__contains__(' = ')) :
        if count_indent_space( x ) >= prev_ind :
            return 1
        return 0

def is_possible_tip_line( x ) :
    if not( is_empty(x) ) and       \
       not( is_spacer(x) ) and      \
       not( is_sec_title(x) ) and   \
       not( is_sec_descrip(x) )  :
        return 1
    return 0

# ------------------------------------------------------------------

def parse_all_lines(LL, skip_lines=8):

    N = len(LL)
    previous_indent = 0 # need to identify indentation
    previous_empty  = 0 # need to identify indentation

    alltips = list_tips("all GUI tips")

    KEYBOARD_MODE = False

    tip_count = 0

    aa = []

    # We will ignore the first few lines, and "Tip #1"
    i = skip_lines

    while i < N:
        x  = LL[i]
        xs = x.strip()

        # skip empty lines
        if is_empty(x) :
            print("empty")

        # is a boundary--- clear everything
        elif is_spacer(x) :
            print("spacer")
            
        # must be in a section, or skipping
        elif is_sec_title( x ) :
            section   = init_tip( tip_count )
            sec_title = xs.strip('*').strip()
            section.add_title( sec_title )
            tip_count += 1

            if sec_title.__contains__('Keyboard') :
                KEYBOARD_MODE = True
            else:
                KEYBOARD_MODE = False

        elif is_sec_descrip( x, prev_emp=previous_empty ) :
            sec_descrip = [ ' '.join(xs.split()[1:]) ]
            previous_indent = count_indent_space(x)
           
            # see if it carries on
            for j in range(1, N-i):
                w  = LL[i+j]
                if is_line_continuation(w) :
                    sec_descrip.append(w.strip())
                else:
                    break
            print(' '.join(sec_descrip))
            section.add_descrip( ' '.join(sec_descrip) )
            if j :
                i+= j-1
                x  = LL[i]
                xs = x.strip()

        else:
            sec_tip = [ x ]
            previous_indent = count_indent_space(x)

            # see if it carries on; and if in keyboard mode, space out
            # subparagraphs
            for j in range(1, N-i):
                w  = LL[i+j]
                if is_possible_tip_line(w) :
                    if not(KEYBOARD_MODE) and is_subtip_starter(w) :
                        sec_tip.append( "\n"+w )
                    else:
                        sec_tip.append( w )
                    previous_indent = count_indent_space(w)

                else:
                    break

            print(' '.join(sec_tip))

            if j :
                i+= j-1
                x  = LL[i]
                xs = x.strip()
            section.add_tip_text_list( sec_tip )
            alltips.add_tip(section)

        # save size of indent for next line, help parsing
        previous_indent = count_indent_space(x)
        previous_empty  = is_empty(x)

        i+= 1
   
    print("++ Found %d tips!" % (tip_count))
    return alltips

def write_out_startup_tip_rst(ofile, ttt):
    fff = open(ofile, 'w')

    # Top level header stuff and description
    fff.write(text_label)
    fff.write(text_title_desc)

    Nt = ttt.count

    for i in range(Nt):

        title   = ttt.tips[i].title
        Lt      = len(title)

        descrip = ttt.tips[i].descrip
        tip     = ttt.tips[i].tip

        fff.write("\n"+title+"\n")
        fff.write('-'*Lt+"\n\n")

        fff.write(descrip+"\n\n")

        fff.write(".. code-block:: none\n\n")

        Nrow = len(tip)
        for j in range(Nrow):
            fff.write(tip[j])
        fff.write("\n")
    fff.close()

def check_for_webaddr(sss):

    olds = []
    news = []
    ttt = sss.split()
    for x in ttt:
        if x[:4] == "http":
            uuu = "`"+x+" <"+x+">`_"
            olds.append(x)
            news.append(uuu)

    if olds:
        ppp = sss[:]
        for i in range(len(olds)):
            print("Replacing:", olds[i])
            ppp = ppp.replace(olds[i], news[i])
        return ppp
    else:
        return sss
        

# ====================================================================

# AFNI startup tip class
class list_tips:

    def __init__(self, name):
        self.name  = ''
        self.tips  = [] 
        self.count = 0  

    def add_tip(self, newtip):
        self.tips.append(newtip)
        self.count+=1
    
class init_tip:
            
    def __init__(self, num):
        self.name    = ''
        self.tip     = []
        self.num     = num
        self.title   = ''
        self.descrip = ''

    def add_title(self, ss):
        self.title = ss

    def add_descrip(self, ss):
        self.descrip = ss
    
    def add_tip_text_list(self, ll):
        self.tip = ll



# ====================================================================

if __name__=="__main__":

    # --------------------- get input ------------------------

    print( "++ Command line:\n   {}".format(' '.join(sys.argv) ))
    (ifile, ofile)  =  get_arg(sys.argv[1:])

    # put all recent helps into a file
    os.system("afni -tips > %s" % (ifile))

    all_lines  = au.read_text_file( ifile,strip=0 )

    alltips = parse_all_lines(all_lines)

    write_out_startup_tip_rst(ofile, alltips)

    print("++ Done writing GUI tips rst!")
