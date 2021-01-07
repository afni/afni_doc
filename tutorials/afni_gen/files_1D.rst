

.. _tut_afni_gen_files_1D:

*************************************
Using 1D files in AFNI
*************************************

.. contents:: :local:

.. highlight:: Tcsh

Overview
==========

1D files are basically just simple text files of numbers, either in
columns or rows or both.  For example, a 1D file might look like::

  1    2
  3    4
  5   -6
  7.8  9

The AFNI program 1d_tool.py is a useful program for dealing with this
files, as are most ``1d*`` programs (though most ``3d*`` programs can
actually operate on them, as well).  If the above numbers were stored
in a file called ``test.1D``, then we could see its dimensions with
varying degrees of descriptive text with::

  1d_tool.py -show_rows_cols -infile test.1D 

  1d_tool.py -show_rows_cols -infile test.1D -verb 0

\.\.\. which would output each the following lines, respectively:

.. code-block:: none

   rows = 4, cols = 2

   4 2

The former might be easier on the inquisitive eye, while latter would
be more useful for scripting, probably.

These files can also contain comments, such as in the top couple rows
or at the furthest right of the data.


1D files as AFNI datasets
===========================

Most (but not all) AFNI ``3d*`` programs can operate on ``*.1D`` files
as if they were 3D datasets. This capability is limited to programs
that operate on data voxel-wise -- that do not do inter-voxel
computations (since no spatial structure is implied by the 1D
format). In this usage, each row of a 1D file is a separate "voxel",
and each column represents a sub-brick (e.g., time point). Thus, the
file below has 3 voxels and 5 time points::

   3 7 9 11 12
   2 4 6  8 10
  -1 2 2 -5  7

To process a single column 1D file as a time-dependent dataset, the
file must be transposed on the command line using the ``\'`` notation
(see below for details). To experiment with this type of input, one
simple test is to use commands like

   3dTstat -prefix - '1D: 3 4 5 6 | 2 3 4 5'
   3dTstat -prefix - '1D: 3 4 5 6 | 2 3 4 5'\'

where ``'1D: 3 4 5 6 | 2 3 4 5'`` is command line shorthand (see the
next section) for the file::

  3 2
  4 3
  5 4
  6 5

\.\.\. and ``'-prefix -'`` means to write the 1D output to stdout (the
screen), which is useful for gaining quick understanding.

Factoids:

#. You can't input a 1D 'dataset' to ``3dcalc`` in this way -- that
   program treats 1D files in a special way. However, the ``1deval``
   program is available for doing calculations on 1D files.

#. You also can't input a 1D dataset to the interactive ``afni``
   program this way.

#. ``3dDeconvolve`` has a special ``-input1D ..`` option for inputting
   a single column 1D file as a time series.

#. If you set environment variable ``AFNI_1D_TIME = YES``, then when a
   multicolumn 1D file is read in as an AFNI dataset, the column
   variable is taken to be time, and a time-dependent dataset is
   created. (The default is to create a bucket dataset, with no time
   axis information.) The value of TR can be set via environment
   variable ``AFNI_1D_TIME_TR``.

There is a difference between putting a 1D file in a place where a 3D
dataset is expected and putting a 1D file in where a 1D file is
expected:

* 1D file in place of a 3D dataset: each row is a separate voxel and
  time proceeds across the columns.

* 1D file in place of a 1D file: time proceeds down the rows and
  each column is a separate time series.

The above rules mean that if you want to process a single column of
numbers with a ``3d*`` program, you will usually need to transpose
it. For example, if you want to use 3dDetrend to process a 1D column
file, then you might do something like so::

  setenv AFNI_1D_TRANOUT YES
  3dDetrend -prefix - -vector G1.1D -polort 3 G5.1D\' | 1dplot -stdin

where files G1.1D and G5.1D are both 1 column files with the same
number of rows (time points). Note that G1.1D is not transposed on
input, since it is in a place that *expects* a 1D file, but that G5.1D
is transposed on input with ``\'`` since it appears in a place that
*expects* a 3D file.

* Note that setting environment variable ``AFNI_1D_TRANOUT = YES``
  means that when a ``3d*`` program writes a 'dataset' that is a 1D
  file, it will transpose it so that the time axis is down the
  columns, rather than across the columns -- but only if the 'dataset'
  prefix is '-' (for stdout) or ends in '.1D'.

* I know this transposition stuff is confusing, but remember that
  suffering is a sign that you are still bound to the wheel of
  Samsara, as are we all. *Om Mane Padme Hum.*


Column selection with ``[...]``
=================================

A similar repertoire of methods is available for on-the-fly editing 1D
files on the command line as was shown for general dsets :ref:`here
<tut_afni_data_files_gen_fly>`.

When specifying a timeseries file to an command-line AFNI program, you
can select a subset of columns using the '[...]' notation::

  fred.1D'[5]'            # only column #5
  fred.1D'[5,9,17]'       # columns #5, #9, and #17
  fred.1D'[5..8]'         # columns #5, #6, #7, and #8
  fred.1D'[5..13(2)]'     # columns #5, #7, #9, #11, and #13

Column indices start at 0. You can use the character ``$`` to indicate
the last column in a 1D file. For example, you can select every third
column in a 1D file by using the selection list::

  fred.1D'[0..$(3)]'      # use columns #0, #3, #6, #9, ....
 

Row selection with ``{...}``
=============================

Similarly, you select a subset of the rows using the ``{...}``
notation::

  fred.1D'{0..$(2)}'      # rows #0, #2, #4, ....

You can also use both notations together, as in::

  fred.1D'[1,3]{1..$(2)}' # columns #1 and #3; rows #1, #3, #5, ....

Direct input of data on the command line with '1D:'
========================================================

You can also input a 1D time series directly on the command line,
without an external file. The 'filename' for such input has the
general format::

  '1D:n_1@val_1,n_2@val_2,n_3@val_3,...'

where each ``n_i@`` is an integer repetition count (which can be
omitted) and each ``val_i`` is a float value. For example, the
following specifies a single 'column' comprising 5+1+5+1=12 numbers::

   '1D:5@0,10.0,5@0,10.0'

Spaces or commas can be used to separate values.  A vertical pipe
``|`` character can be used to start a new input "line".  The
following will plot 2 curves, 1 from each 'column' of 4 values::

  1dplot -DAFNI_1DPLOT_THIK=0.01 -one '1D: 3 4 3 5 | 3 5 4 3'

It is also possible to format the output of program ``1deval`` so that
it can be captured on the command line for interactive use. For
example::

  1dplot `1deval -1D: -num 71 -expr 'cos(t/2)*exp(-t/19)'`

Here, the ``-1D:`` option tells the program to format the output
starting with the string '1D:' and to separate numbers with commas
instead of spaces or newlines. The use of the shell backquotes
```...``` captures the output of the ``1deval`` command to the command
line, and that becomes the input to program ``1dplot``. (If you want
to see what the ``1deval -1D:`` output looks like, just run the
command itself without the backquotes or the ``1dplot``.)

Transposition with ``\'``
===========================

You can force most AFNI programs to tranpose (i.e., swap rows for
columns) a 1D file on input by appending a single ``'`` character at
the end of the filename. Since the ``'`` character is also special to
the shell, you'll probably have to put a ``\`` escape character before
it. Contrast the results of these two commands::

  # cmd A
  1dplot '1D: 3 2 3 4 | 2 3 4 3'

  # cmd B
  1dplot '1D: 3 2 3 4 | 2 3 4 3'\'

