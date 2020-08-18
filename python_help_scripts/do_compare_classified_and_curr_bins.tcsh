#!/bin/tcsh

# Script to check which items in the current AFNI binaries (as defined
# by apsearch output) are not in the Classified program list, and vice
# versa.
#
# Not all mismatches are problematic: some R programs only run in the
# R env, some plugins (non-command line progs) are listed in the
# classified items, etc.  But in general it would be good to minimize
# the differences between these two, mainly by having the Classified
# items remain uptodate.
#
# The main outputs of this program are 2 text files:  
# + A list of current apsearch/program items that are not in the
#   Classified list
# + A list of items in the Classified list that are not in the
#   apsearch/program list
#
# auth = PT
# ver  = 1.0
# date = Aug 18, 2020

# ------------------------------------------------------------------------

set ifile_class    = ~/AFNI/afni_doc/python_help_scripts
set ifile_class    = ${ifile_class}/list_AFNI_PROGS_classed.txt

set ofile_curr     = o.list_aprogs_only_in_curr_abin.txt
set ofile_class    = o.list_aprogs_only_in_class_list.txt

set tpref          = __tmp_list_CAP
set fclass_dump    = ${tpref}_class_00_dump.txt
set fclass_names   = ${tpref}_class_01_names.txt
set fclass_sort    = ${tpref}_class_02_sort.txt

set fcurr_sort     = ${tpref}_curr_00_sort.txt

# ------------------------------------------------------------------------

# -------------------- classified afni progs 

grep "::" ${ifile_class} \
    > ${fclass_dump}

set nline = `cat ${fclass_dump} | wc -l`

echo "++ Start reading classified progs: "
printf "" > ${fclass_names}
foreach ii ( `seq 1 1 ${nline}` )

    printf "+ ${ii} "
    set line = `awk "NR==${ii}" ${fclass_dump}`
    set cmd  = "${line[3]}"
    
    # filter out titles, which have '::' in this position
    if ( "${cmd}" != "::" ) then
        echo "${line[3]}" >> ${fclass_names}
    endif
end

echo "\n++ Done reading."

# need sorted, and remove duplication
cat ${fclass_names} | sort | uniq > ${fclass_sort}

# ------------------ current progs on OS

apsearch -list_all_afni_progs | sort > ${fcurr_sort}

# ------------------ compare 
# each file must be pre-sorted 

# show comments in current progs NOT listed in classified list
comm -23                         \
    ${fcurr_sort}                \
    ${fclass_sort}               \
    > ${ofile_curr}

comm -13                         \
    ${fcurr_sort}                \
    ${fclass_sort}               \
    > ${ofile_class}

# ------------------ report

set ncurr  = `cat ${ofile_curr} | wc -l`
set nclass = `cat ${ofile_class} | wc -l`
set nclass_noplug = `cat ${ofile_class} | grep -v plugin | wc -l`

cat <<EOF
--------------------------------------------------------------------------

N unclassified items in current binaries   : ${ncurr}
N classified items not in current binaries : ${nclass}
                  ... not counting plugin* : ${nclass_noplug}

See these files: 
afni_open -e ${ofile_curr} & afni_open -e ${ofile_class} &

--------------------------------------------------------------------------
EOF

# --------------------------------------------------------------------

# clean
\rm ${tpref}*

exit 0
