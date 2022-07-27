:tocdepth: 2

.. _stats_df:

****************************************************************************
**How to get the degrees of freedom (DF) in an AFNI file?**
****************************************************************************

.. highlight:: none

.. contents:: :local:


There are at least four ways to find out the degrees of freedom
(DF) for a specific statistical sub-brick:

#. ``3dinfo``
#. the AFNI GUI/viewer
#. ``3dAttribute``
#. ``p2dsetstat``/\ ``dsetstat2p``

The command line programs all apply equivalently to either volumetric
or surface-format files. (Using the AFNI GUI just applies to the
volumetric format.)

In the examples below, we use a volume called ``stats.FT+tlrc``.  This
also happens to be the stats volume output by running the AFNI
Bootcamp demo example of ``afni_proc.py`` in
``~/AFNI_data6/FT_analysis/s05.ap.uber``.  Assume that sub-brick #0 is
an F-statistic and sub-brick #8 is a t-statistic.


Using ``3dinfo``
--------------------------------

The first method is to use ``3dinfo``, which outputs information about
the entire dataset.  This can be piped through less, to be able to
scroll through it::

  3dinfo -verb stats.FT+tlrc | less

On the screen you can find the header information about sub-brick #0
(the full F-statistic), just beneath the line starting ``Number of
values stored at each pixel ...``::

    -- At sub-brick #0 'Full_Fstat' datum type is float:            0 to       977.037
       statcode = fift;  statpar = 2 412

The two numbers under ``statpar`` (=statistic parameters), 2 and 412,
on the second line are the degrees of freedom for this F-statistic.
(The statcode relates to internal code usage/labelling for identifying
this type of statistic; see the help of ``cdf`` for a wee bit more
description, if intrigued.)

Further down you should be able to locate the other t-statistic
sub-brick (#8)::

    -- At sub-brick #8 'V-A_GLT#0_Tstat' datum type is float:     -11.3157 to       12.7985
       statcode = fitt;  statpar = 412

\.\.\. and the DF count in this case is 412.


Using the AFNI GUI
--------------------

Load the statistics volume ``stats.FT+tlrc`` as an overlay in the AFNI
viewer (GUI). 

Go through the following buttons: 

* ``Define Datamode`` (just above the ``Underlay`` and ``Overlay`` buttons)
* ``Misc`` (in the bottom row of the new panel that opens)
* ``OLay Info``. 

You should be able to find the same information in the new window as
shown above with ``3dinfo``.

The same also works if you load the stats dset as an underlay, and
then go to ``Define Datamode`` -> ``Misc`` -> ``Ulay Info``.

Using ``3dAttribute``
--------------------------------

For example, for the same sub-brick #0 above, run the following
command::

  3dAttribute BRICK_STATAUX stats.FT+tlrc"[0]"

\.\.\. and you should get five numbers on the screen::

  0 4 2 2 412 

The last two are the DF for the F-statistic.

**NB:** For the sub-brick selection in the quoted squarebrackets, you
can use the label associated with the subbrick, which in this case is
"Full_Fstat". So, the following would lead to the same output as
above::

  3dAttribute BRICK_STATAUX stats.FT+tlrc"[Full_Fstat]"

Doing the same for the t-statistic sub-brick (with either the
number- or string-label for subbrick selection)::

  3dAttribute BRICK_STATAUX stats.FT+tlrc'[8]'

\.\.\.  you will see::

  0 3 1 412 

\.\.\. and the last number is the DF count for the t-statistic.

Using ``p2dsetstat`` and ``dsetstat2p``
--------------------------------------------

There are some complementary convenience programs for converting
p-values to statistics and vice versa, ``p2dsetstat`` and
``dsetstat2p``.  These can be helpful for either scripting or for
seeing stats information (and they make use of the above
functionality, under the hood).  

Similar to the ``3dAttribute`` example, one looks at information for a
single subbrick.  For example, querying information about subbrick #0
(or, again, one could use the string label, "Full_Fstat")::

  p2dsetstat -inset stats.FT+tlrc'[0]' -pval 0.001 -1sided 

\.\.\. one obtains the output table::

  ++ Found input file : stats.FT+tlrc[0]
  ++ OK stat type     : fift
  ++ BRICK_STATAUX    : 0 4 2 2 412
  ++        params    : 2 412
  ++ Final stat val   : 6.3093

This might be more convenient than ``3dAttribute`` for visualization,
because the "params" line highlights the one or more DF parameters,
rather than having to know *a priori* how many DFs to expect for a
given stat.  Or, at least, this could be used to verify the
interpretation of the more opaque ``BRICK_STATAUX`` info.  **NB:** For
getting an appropriate statistic value, one has to use an appropriate
sidedness of testing (e.g., ``-1sided`` for the F-stat here), but that
does not affect the DF info.

Running the similar program for the t-stat in #8, one might use::

  p2dsetstat -inset stats.FT+tlrc'[8]' -pval 0.001 -bisided 

\.\.\. obtaining::

  ++ Found input file : stats.FT+tlrc[8]
  ++ OK stat type     : fitt
  ++ BRICK_STATAUX    : 0 3 1 412
  ++        params    : 412
  ++ Final stat val   : 3.3143

Running the complementary program ``dsetstat2p`` will provide the same
DF info in either case.  For example, going back to the F-stat in #0
(and using the classy label for sub-brick selection)::

  dsetstat2p -inset stats.FT+tlrc'[Full_Fstat]' -statval 3 -1sided 

\.\.\. yields::

  ++ Found input file : stats.FT+tlrc[Full_Fstat]
  ++ OK stat type     : fift
  ++ BRICK_STATAUX    : 0 4 2 2 412
  ++        params    : 2 412
  ++ Final p-val      : .025437950000000

On a final note for these programs, if you are really just wanting
either the stat or p-value output for scripting purposes, you can use
the ``-quiet`` option, to just get that number and assign it to a
variable. In ``tcsh`` syntax, this might look like::

  set pval = `dsetstat2p -inset stats.FT+tlrc'[Full_Fstat]' -statval 3 -1sided -quiet`

\.\.\. where subsequently using ``echo ${pval}`` to display the value
yields::

  .025437950000000
