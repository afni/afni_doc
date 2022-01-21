
import urllib.request as UR

# read the webpage
link_atlases = 'https://afni.nimh.nih.gov/pub/dist/atlases/'
page_atlases = UR.urlopen(link_atlases) 

list_names = []

for line in page_atlases: 
    text = line.decode("utf-8").strip() 
    if "href=" in text : 
        list_names.append( text.split("href=")[1].split(">")[0] )

########################################################################
## create the RST: we actually put a similar webpage in 2 places


all_paths = [ '../template_atlas/', '../nonhuman/' ]
all_targs = [ 'tempatl_other'     , 'nh_other' ]
npages    = len(all_paths)

for i in range(npages):
    path = all_paths[i]
    targ = all_targs[i]


    ## open file for writing
    file_rst = path + "other_tas.rst"
    fff = open(file_rst, "w")

    ## write out the header
    top_text = '''.. _{targ}:

.. comment:
   This file was created by:
       afni_doc/python_help_scripts/make_list_of_pub_dist_atlases.py
   as part of the default documentation build.

*******************************
Other templates and atlases
*******************************

.. contents:: :local:

.. highlight:: none

Overview
=========

A default set of atlases and templates are distributed with the AFNI
binaries (the `afni_atlases_dist.tgz
<{link_atlases}afni_atlases_dist.tgz>`__).  
There are also additional atlas and template datasets (both human and
non-human) that can be downloaded, which are listed below.  This list
is likely to expand over time.

Note that there are also several ``@Install_*`` programs that may
provide a more convenient way to download+install some of the packages
listed here (as well as demos utilizing them, in some cases).

Links to additional datasets
=================================

The following table provides links to the available datasets and
datapackages.  

* Items ending with ``*.tgz`` are compressed tarballs. Clicking on
  these should lead to a download prompt.  Once downloaded, the files
  can be unpacked on the command line with ``tar -xf FILE.tgz`` or
  separately perhaps by clicking on it.

* Items without an apparent file extension are typically directories
  of related datasets.  Clicking on these should lead to a file
  directory (using a right-click or middle-click might be useful to
  open the link in a new tab), from which you can select data to
  download.

**Downloadable datasets:**

.. csv-table::
   :width: 100%

'''.format(link_atlases=link_atlases, targ=targ)

    fff.write(top_text)

    ## for the main_toc 3 column csv
    csv_line = ""
    csv_index = 0

    for name in list_names :
        print(name)

        ## add to main_toc as a 3 column csv
        if csv_index == 0:
            csv_line  = "   `"+name+" <"+link_atlases+name+">`__,"
        elif csv_index == 1:
            csv_line  = csv_line+"`"+name+" <"+link_atlases+name+">`__,"
        elif csv_index == 2:
            csv_line  = csv_line+"`"+name+" <"+link_atlases+name+">`__"
            fff.write(csv_line+"\n")
        csv_index = (csv_index + 1) % 3

    # we might also have a last line with <3 elements left to write
    if csv_index :
        fff.write(csv_line+"\n")

    more_text = '''
|
| The link to the "basic" webpage interface for downloading the above
  dsets is here:
| `<{link_atlases}>`_

|

'''.format(link_atlases=link_atlases)

    fff.write(more_text)

    ## close the RST
    fff.close()
