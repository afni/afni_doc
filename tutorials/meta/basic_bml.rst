

.. _tut_meta_basic_bml:

*********************************************************************
Basic meta analysis with BML
*********************************************************************


.. contents:: :local:

Introduction
============

.. highlight:: R

Here we provide the data and code for the basic meta analysis example
with Bayesian multilevel modeling (BML) presented in Sec. 3.1 of
***link to bioRxiv paper*** (see Fig. 5 there).

BML meta analysis
=================


**The data**

  The data for this example is stored in a simple text file, formatted
  like this:

  .. include:: media/basic_bml/data_meta1.txt
     :literal:

  *Download data:* :download:`data_meta1.txt <media/basic_bml/data_meta1.txt>`

  The three columns contain, respectively: a study index, effect
  estimate (ef) and standard error (se).


**The script**

  The R language code for performing the meta analysis and making a
  simple plot of the results is as follows:

  .. include:: media/basic_bml/run_meta1.R
     :literal:

  *Download data:* :download:`run_meta1.R <media/basic_bml/run_meta1.R>`

  The program loads the input data file and libraries, and then runs
  the BML model with 4 parallel chains, and finally plots the
  resulting effect estimate distribution.

**The output**

  This displays the estimated posterior distribution for the effect
  estimate:

  .. list-table:: 
     :header-rows: 0
     :widths: 50 

     * - .. image:: media/basic_bml/img_meta1.png
            :width: 100%   
            :align: center

  The vertical green line shows the zero effect.  In this case, the
  vast majority of the distribution is to the right of this zero
  effect line, which is interpreted as strong evidence for having a
  positive effect.

  (See the paper for more details.)

|

*Welcome to Bayesian analysis!  It's not so bad, is it?*
