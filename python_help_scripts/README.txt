TO GENERATE ALL THE HELPS
-------------------------

To make the table of links to all Sphinxified AFNI helps, run:

    help2sphinx.py -OutFolder ../programs



TO GENERATE THE CLASSIFIED HELP
-------------------------------

The file for people to edit/regroup/add/subtract programs and
descriptions is: list_AFNI_PROGS_classed.txt.

Please pay attention to the formatting therein, esp. the "++" starting
the Group Title lines (and the Group Rank must follow the "++" in each
case), and "::" demarking things.

Making the RST file is a 2-step process:

    python convert_list_to_fields_pandas.py         \
       list_AFNI_PROGS_classed.txt           \
       list_STYLED_NEW.txt

    python convert_fields_to_rst.py                 \
       list_STYLED_NEW.txt                   \
       ../educational/classified_progs.rst

# ----------------------------------------------------------------------

The simple script 'do_compare_classified_and_curr_bins.tcsh' exists
just to be run separately from time to time as a way of checking how
if new programs are in the binary distribution that should be
classified.  It also helps point out programs that might be classified
but are no longer distributed.

To run, no arguments are needed (though the location of the Classified
text file list might need to be updated on a given computer):

   tcsh do_compare_classified_and_curr_bins.tcsh

It just produces a couple text files listing differences between
current binary items and current classified items.
