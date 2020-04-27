#!/usr/bin/env python

import numpy as np
import sys as sys
import os

from afnipy import afni_util as au

THIS_PROG = 'make_file_of_readme_env.py'
NUM_ARGS  = 2                          # two input args needed

# ------------------------------------------------------------------

text_label = ".. _edu_env_vars:"

text_title_desc = \
'''

**********************************
**List of all AFNI env variables**
**********************************

.. contents:: :local:

Overview
--------

You can set Unix environment variables to control AFNI behavior and
defaults on your system.  These allow you, Dear User, to set things
like: crosshair colors; default colorbars; colormap ranges; left=left
or left=right behavior in image panels; having labels appear; image
background color; 1dplot characteristics; "locking" behaviors in the
GUI; text editor for viewing help files with ``-hview`` (like emacs!);
global dset and atlas paths; and sooo maaaany mooore.

These settings can be managed in several ways-- for example, using
``setenv`` in ``tcsh`` or ``export`` in ``bash``.  Probably the
**easiest+best** way to go would be to define a file called
``~/.afnirc`` (i.e., a file in your computer's home directory called
".afnirc"-- note the dot) and store your variable definitions and
settings there.  In fact, as part of your installation instructions,
you should have *already* created this file (in fact, one for each of
``afni`` and ``suma``; we just present the options for the former
here).  If you don't, you should check the setup instructions for
quickly doing this.


|

'''

# ===================================================================

VERSION   = "1.0"
VER_DATE  = "Oct 21, 2019"
AUTHOR    = "PA Taylor (NIMH, NIH)"

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

def is_sec_title(x) :
    ''' Is x a string, and does it look like a section title?
'''
    try:
        y = x.strip()
        if y[:15] == '#'*15 :
            return 1
        else:
            return 0
    except:
        return 0

def find_sec_title(x):
    ''' x should be a list of 3 str
'''

    if len(x) != 3:
        print("** ERROR: can't get sec title (ran out of space?)")
        sys.exit(21)

    for i in range(3):
        if x[i][:3] != '###':
            print("** ERROR: can't get sec title (format issue)")
            sys.exit(21)

    ys = x[1].strip()
    title = ys.replace('###', '').strip()
    return title

def is_nb(x) :
    ''' Is x a string, and does it look like a note starting with 'N.B.'?
'''
    try:
        y = x.strip()
        if y[:5] == 'N.B.:' :
            return 1
        else:
            return 0
    except:
        return 0

def is_var_title(x) :
    ''' Is x a string, and does it look like a variable title?
'''
    try:
        y = x.strip()
        if y[:15] == '-'*15 :
            return 1
        else:
            return 0
    except:
        return 0

def is_var_title_three_line(x):
    ''' x should be a list of 3 str
'''

    if len(x) != 3:
        print("** ERROR: checking var title (ran out of space?)")
        sys.exit(11)

    for i in [0, 2]:
        if x[i][:10] != '-'*10:
            return 0

    ys = x[1].strip()
    if ys[:8] == "Variable" : # some have "Variables:"
        return 1
    return 0

def find_var_title(x):
    ''' x should be a list of 3 str
'''

    if len(x) != 3:
        print("** ERROR: can't get var title (ran out of space?)")
        sys.exit(31)

    for i in [0, 2]:
        if x[i][:10] != '-'*10:
            print("** ERROR: can't get var title (format issue)")
            sys.exit(21)

    ys = x[1].strip()
    if ys[:8] != "Variable" : # some have "Variables:"
        print("** ERROR: can't get var title (no name?)")
        sys.exit(22)

    # chop off the first "variable:" or "variables:"
    zs    = ys.split(":")  
    title = ''.join(zs[1:]).strip()
    return title


# -----------------------------------------------------------------------

def parse_all_lines(LL, skip_lines=0):

    N               = len(LL)
    previous_indent = 0 # need to identify indentation
    previous_empty  = 0 # need to identify indentation

    mode = 'START' # switch to reading vars at some point
    END_WITH_COLON = False # switch for knowing if code is there

    envcount = 0
    START = 0
    allenv = list_env("the list")
    aa = []
 
    # We will ignore the first few lines, and "Tip #1"
    i = skip_lines

    while i < N :
        x  = LL[i]
        xs = x.strip()

        # skip empty lines
        if is_empty(x) :
            print("empty")
       
        elif is_sec_title(x) :
            obj = env_obj(obj_type="title")
            title = find_sec_title(LL[i:i+3])
            obj.set_title(title)
            i+=2
            x  = LL[i]
            xs = x.strip()
            print("title: "+obj.title)
            allenv.add_env( obj )
            if title == 'Env vars: the looong list' :
                mode = 'VARIABLE'


        elif is_nb(x) : # NBs in the VARIABLE section are shielded...
            obj = env_obj(obj_type="nb")
            text = [ x ]

            for j in range(1, N-i):
                w  = LL[i+j]
                ws = w.strip()
                if ws :
                    text.append( w )
                else:
                    break

            obj.add_text( text )
            print("nb:\n"+ ''.join(obj.text))
            allenv.add_env( obj )

            if j :
                i+= j-1
                x  = LL[i]
                xs = x.strip()

        elif mode == 'START' and not(END_WITH_COLON) :
            obj = env_obj(obj_type="text")
            text = [ x ]

            for j in range(1, N-i):
                w  = LL[i+j]
                ws = w.strip()
                if ws :
                    text.append( w )
                else:
                    break

            obj.add_text( text )
            print("text:\n"+ ''.join(obj.text))
            allenv.add_env( obj )

            if j :
                i+= j-1
                x  = LL[i]
                xs = x.strip()
            if xs[-1] == ':' :
                END_WITH_COLON = True
            else:
                END_WITH_COLON = False

        elif mode == 'START' and END_WITH_COLON :
            obj = env_obj(obj_type="code")
            text = [ x ]

            for j in range(1, N-i):
                w  = LL[i+j]
                ws = w.strip()
                if ws :
                    text.append( w )
                else:
                    break

            obj.add_text( text )
            print("code:\n| "+ '| '.join(obj.text))
            allenv.add_env( obj )

            if j :
                i+= j-1
                x  = LL[i]
                xs = x.strip()
            END_WITH_COLON = False

        elif mode == 'VARIABLE' :
            obj = env_obj(obj_type="variable")
            title = find_var_title(LL[i:i+3])
            obj.set_title(title)
            i+=2
            x  = LL[i]
            xs = x.strip()
            print("var title: "+obj.title)

            text = []

            lines_left = N-i
            # a variable will end the file
            if lines_left < 4 :
                for j in range(1, lines_left):
                    w  = LL[i+j]
                    text.append( w )
                    #print('= '  + w)
                i+= j
            else:
                # from here, carry on until we find another var title
                for j in range(1, N-i):
                    if not(is_var_title_three_line(LL[i+j:i+j+3])) and \
                       not(is_sec_title(LL[i+j])) :
                        w  = LL[i+j]
                        text.append( w )
                        #print('= '  + w)
                    else:
                        break
                if j :
                    i+= j-1
                    x  = LL[i]
                    xs = x.strip()

            obj.add_text( text )
            #print("var:\n* "+ '* '.join(obj.text))
            allenv.add_env( obj )
            envcount+= 1

        i+= 1

           
    print("++ Found %d env vars!" % (envcount))
    return allenv


def write_out_env_vars_rst(ofile, ttt):
    fff = open(ofile, 'w')

    # Top level header stuff and description
    fff.write(text_label)
    fff.write(text_title_desc)

    Nt = ttt.count

    for i in range(Nt):
        
        if ttt.envs[i].obj_type == 'title' :
            title   = ttt.envs[i].title
            Lt      = len(title)
            fff.write("\n"+title+"\n")
            fff.write('-'*Lt+"\n\n")

        elif ttt.envs[i].obj_type == 'code' :
            fff.write("\n")
            fff.write(".. code-block:: none\n\n")
            x = ttt.envs[i].text
            Nrow = len(x)
            for j in range(Nrow):
                fff.write("    "+x[j])
                #fff.write("   | "+check_for_webaddr(x[j])+"\n")
            fff.write("\n")

        elif ttt.envs[i].obj_type == 'text' :
            fff.write("\n")
            x = ttt.envs[i].text
            Nrow = len(x)
            for j in range(Nrow):
                fff.write(x[j])
                #fff.write("   | "+check_for_webaddr(x[j])+"\n")
            fff.write("\n")

        elif ttt.envs[i].obj_type == 'nb' :
            fff.write("\n")
            x = ttt.envs[i].text
            Nrow = len(x)
            # has to be at least one line
            line0 = x[0].replace("N.B.:", "").strip()
            fff.write('.. note:: '+ line0+'\n')
            for j in range(1, Nrow):
                fff.write('          ' + x[j].strip()+'\n')
                #fff.write("   | "+check_for_webaddr(x[j])+"\n")
            fff.write("\n")


        elif ttt.envs[i].obj_type == 'variable' :
            fff.write("\n**"+str(ttt.envs[i].title)+"**\n\n")
            fff.write("    .. code-block:: none\n\n")
            x = ttt.envs[i].text
            Nrow = len(x)
            for j in range(Nrow):
                fff.write("       "+x[j])
                #fff.write("   | "+check_for_webaddr(x[j])+"\n")
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
class list_env:

    def __init__(self, name):
        self.name  = name
        self.envs  = [] 
        self.count = 0  

    def add_env(self, newenv):
        self.envs.append(newenv)
        self.count+=1

class env_obj:

    def __init__(self, obj_type ):
        self.obj_type = obj_type    # title, variable, descript
        self.num     = ''
        self.text    = []
        self.title   = ''   # if title

    def add_text(self, ss):
        self.text += ss

    def set_title(self, ss):
        self.title = ss


# ====================================================================

if __name__=="__main__":

    # --------------------- get input ------------------------

    print( "++ Command line:\n   {}".format(' '.join(sys.argv) ))
    (ifile, ofile)  =  get_arg(sys.argv[1:])

    # put all recent helps into a file
    os.system("afni -env > %s" % (ifile))

    all_lines  = au.read_text_file( ifile, strip=0 )

    allenvs = parse_all_lines(all_lines)

    write_out_env_vars_rst(ofile, allenvs)

    print("++ Done writing environment vars to rst!")
