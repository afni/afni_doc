.. _stats_decon_block:

******************************************************
**Duration modulation (DM) blocks (3dDeconvolve)**
******************************************************

.. contents:: :local:

Amplitude modulation (AM) can be applied to stimulus timing events in
``3dDeconvolve`` and via ``afni_proc.py``, when stimuli of a given
class have varied (but known) durations.  One can use the duration
modulation (DM) to scale the stimulus responses.  This can be applied
using ``-stim_times_AM1 ..`` and ``-stim_times_AM2 ..`` options, and
then also specifying a duration block model function, ``dmBLOCK(...)``
or ``dmUBLOCK(...)``.

There are often questions about which DM block model to pick, and then
what parameters to specify for it.  Here we briefly describe what the
differences are, and provide guidance on making these choices.
Essentially, one will choose based on answering 2 questions:

1. Should the convolved shape height should depend on the stimulus
   duration?

#. To what value should the amplitude be scaled?

The choice of answer to Q1 is typically more fundamental.  The answer
to Q2 depends slightly on Q1 as well: if the response heights vary,
the user essentially picks a representative duration to set the scale.

TL;DR description of block choices
========================================

Below are a set of images showing examples of the convolved models for
the exact same set of inputs (in this case, with subtle labellings;
see above for a clearer one).  In each image, the horizontal, dashed
cyan line shows unit height.  Formatted as **onset time:duration
time** pairs, the input timing specification has the following
successively increasing durations (units in seconds; values can be
non-integer)::

  0:1 30:2.5 60:3 90:4 120:5 150:6 180:10 210:20 240:40

From left->right, the three columns show convolved responses using:
``dmBLOCK(...)``, ``dmUBLOCK(...)`` with arguments :math:`\geq 0`, and
``dmUBLOCK(...)`` with arguments :math:`\leq 0`.  Each row shows the
convolved response for the above set of stimuli using a different
argument in the function's parentheses (or not using any argument).

**It is typically recommended to use** ``dmUBLOCK(...)``
**with a negative** :math:`\leq 1` **argument value.**  Briefly:

* In 99\% of cases, one uses duration modulation because one wants to
  have the convolved response amplitude depend on the stimulus
  duration.  Therefore, one would *avoid* cases where the argument is
  :math:`\geq 1`, like ``dmBLOCK(2)``, ``dmUBLOCK(2)``, etc.
 
* It is often *convenient* to explicitly pick the stimulus duration
  whose response gets scaled to unity---that just makes explanation
  clearer.  That value might come from typical or average response
  durations in a study, say.  In that case, one should use
  ``dmUBLOCK`` with a negative argument, such as ``dmUBLOCK(-2)``,
  ``dmUBLOCK(-12)``, etc.

.. list-table::
   :header-rows: 1
   :widths: 100 

   * - ``dmBLOCK`` and ``dmUBLOCK`` examples (block lengths: 1, 2, 3, 4,
       5, 6, 10, 20, 40 s), notated
   * - .. image:: media/decon_blocks/img_all_decon_blocks_X.jpg
          :width: 100%

Longer description of block choices
========================================

Below are a set of images showing examples of the convolved models for
the exact same set of inputs.  In each image, the horizontal, dashed
cyan line shows unit height.  Formatted as **onset time:duration
time** pairs, the input timing specification has the following
successively increasing durations (units in seconds)::

  0:1 30:2 60:3 90:4 120:5 150:6 180:10 210:20 240:40

From left->right, the three columns show convolved responses using:
``dmBLOCK(...)``, ``dmUBLOCK(...)`` with arguments :math:`\geq 0`, and
``dmUBLOCK(...)`` with arguments :math:`\leq 0`.  Each row shows the
convolved response for the above set of stimuli using a different
argument in the function's parentheses (or not using any argument).

.. list-table::
   :header-rows: 1
   :widths: 100 

   * - ``dmBLOCK`` and ``dmUBLOCK`` examples (block lengths: 1, 2, 3, 4,
       5, 6, 10, 20, 40 s)
   * - .. image:: media/decon_blocks/img_all_decon_blocks.jpg
          :width: 100%

**Column 1:** The first column shows images with ``dmBLOCK``, which
only takes a positive parameter (:math:`\geq 0`) or no parameter.
With no parameter or 0, the convolved response has height 1 for a 1s
duration, and the height increases with duration until eventually
saturating and plateauing (somewhere between 10 and 20 s).  For
arguments :math:`\geq 1`, each convolved response has a constant
amplitude, independent of stimulus duration, scaled to the value of
the argument itself.

* So, for this column, if the answer to Q1 above were **yes**, then
  the user would use ``dmBLOCK`` or ``dmBLOCK(0)`` here; and then the
  answer to Q2 is predetermined, since both of these choices set the
  scale to be response height of 1 for a 1s stimulus.

* And if the answer to Q1 were **no**, then the user would select a
  any other argument value :math:`\geq 1`, such as ``dmBLOCK(1)``,
  ``dmBLOCK(2)``.  Now the answer to Q2 matters, since the argument
  value picked will be the height of all the responses.

**Column 2:** The second column shows ``dmUBLOCK``, with either a
positive parameter (:math:`\geq 0`) or no parameter.  For arguments
:math:`\geq 1`, this function behaves exactly like ``dmBLOCK`` above.
When the argument is 0 or no parameter is given, then the response is
similar to that of ``dmBLOCK`` in that the response amplitude varies,
but different to it in that the scaling is such that convolved plateau
height is scaled to unity, and short duration events are shorter
than 1.

* So, for this column, if the answer to Q1 above were **yes**, then
  the user would use ``dmUBLOCK`` or ``dmUBLOCK(0)`` here; and then
  the answer to Q2 is predetermined, since both of these choices set
  the scale to be response height of 1 for a plateaued stimulus.

* And if the answer to Q1 were **no**, then the situation exactly
  matches that of the ``dmBLOCK`` in column 1: the user would select a
  any other argument value :math:`\geq 1`, such as ``dmUBLOCK(1)``,
  ``dmUBLOCK(2)``.  Now the answer to Q2 matters, since the argument
  value picked will be the height of all the responses.

.. note:: So, the only difference between ``dmBLOCK(0)`` and
          ``dmUBLOCK(0)`` is the scaling, which effectively behaves
          like a change of units (e.g., using inches vs mm or cm or
          feet).  *Within* a study, this should have no effect on
          group level statistics that use subject level effect
          estimates, because every subject has the same scaling. It
          might only make a difference when comparing results
          *between* studies, or when *reporting* the values: the user
          has to specify the scaling used, so a clear comparison can
          be made.

**Column 3:** The third column shows ``dmUBLOCK``, with either a
non-positive parameter (:math:`\leq 0`) or no parameter.  The first
two plots are identical to those of column 2, by definition (response
amplitudes vary in height, increasing until a plateau is reached,
which is scaled to 1).  For negative arguments :math:`\leq 1`, the
response height now *also* varies as a function of block duration,
with an added bit of clarity: the magnitude of the argument chosen
specifies what duration response is scaled to unity.  Thus, for
``dmUBLOCK(-5)`` a 5 s stimulus has a response of height 1, a 3 s
stimulus has a response height :math:`< 1`, and a 10 s stimulus has a
response height :math:`< 1`.

* So, for this column, one must be answering Q1 as **yes** (because
  all response heights depend on stimulus duration). Then, one
  addresses Q2 by choosing what stimulus duration should have a
  response height of unity; (the negative of) that value is used as
  the argument.

**Choosing a function and parameter in practice**

**It is typically recommended to use** ``dmUBLOCK(...)``
**with a negative** :math:`\leq 1` **argument value.**  Briefly:

* In 99\% of cases, one uses duration modulation because one wants to
  have the convolved response amplitude depend on the stimulus
  duration.  Therefore, one would *avoid* cases where the argument is
  :math:`\geq 1`, like ``dmBLOCK(2)``, ``dmUBLOCK(2)``, etc.
 
* It is often *convenient* to explicitly pick the stimulus duration
  whose response gets scaled to unity---that just makes explanation
  clearer.  That value might come from typical or average response
  durations in a study, say.  In that case, one should use
  ``dmUBLOCK`` with a negative argument, such as ``dmUBLOCK(-2)``,
  ``dmUBLOCK(-12)``, etc.


Additional notes
=====================

| You can download and peruse additional notes on amplitude modulation
  here:
| `AMregression.pdf
  <https://afni.nimh.nih.gov/pub/dist/doc/misc/Decon/AMregression.pdf>`_

Demo image script
=========================

| In case you are interested, the script used to create these example
  images is here:
| :download:`example_3dD_blocks.tcsh 
  <media/decon_blocks/example_3dD_blocks.tcsh>`.

