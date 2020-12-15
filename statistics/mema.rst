.. _stats_mema:

******************************************************
**Mixed-Effects Meta Analysis (MEMA)**
******************************************************

.. contents:: :local:

Theoretical background
=========================

The conventional approach for FMRI group analysis is to take
regression coefficients (typically referred to as beta values) and run
t-test, AN(C)OVA, or other types of analysis, and ignore the
within-subject variability (sampling error of each
condition/task/event type at individual subject level). The underlying
rationale for such practice is built on the following two assumptions:

#. Within-subject (or intra-subject) variability is relatively small
   compared to between-subjects (group) variability;

#. Within-subject variability is roughly equal across all subjects.

Current evidences show that up to 40% or even more of variability is
usually accounted for with intra-subject variation among all the
variability (sum of within- and cross-subject variability) in an
activated region of interest. Also there are a lot of variations in
within-subject variability across subjects. Violation of either
assumption could render a suboptimal or even invalid group analysis,
and most of the time it reduces the statistical power at group
level. Therefore the conventional group analysis method, typically
referred to as random/mixed-effects modeling, is mostly a
pseudo-random/mixed-effects approach.

Within-subject variability measures how precise/reliable the percent
signal change (beta) estimate is from individual subject time series
regression model. Since such quantity, contained in the corresponding
t-statistic, is conveniently available, there is no reason, except
theoretical complexity and computation cost, to waste this piece of
information in group analysis.

``3dMEMA`` is developed in R with a mixed-effects meta analysis (MEMA)
approach. It effectively takes advantage of estimate precision from
each subject, and assigns each subject's contribution in the final
result based on weighting instead of equal treatment. More
specifically, a more precise beta estimate (meaning higher
t-statistic) from a subject will have more say in the group effect;
conversely, a less reliable beta estimate (i.e., lower t-statistic)
from a subject will be discounted in the MEMA model. Such strategy can
be surprisingly tolerant of and robust against some types of outliers
compared to the conventional group analysis method. More theoretical
considerations of MEMA can be found in the following literature:

Chen et al., 2012. FMRI Group Analysis Combining Effect Estimates and
Their Variances. NeuroImage 60, 747-765.
(:ref:`pubmed link <https://www.ncbi.nlm.nih.gov/pubmed/22245637>`)

MEMA Modeling
================

``3dMEMA`` handles the following model types:

#. random-effects analysis: one-sample, paired-sample

#. mixed-effects analysis: two-sample (two groups of subjects)

#. mixed-effects analysis: multiple between-subjects factors

#. either of the above three types plus between-subjects covariate(s)

This basically covers whatever t-test you could do with ``3dttest``,
``3dANOVAx``, ``3dMVM``, ``3dLME``, or ``3dRegAna`` before. Noticeably
it may give an impression that it can't directly deal with
sophisticated ANOVA designs, but that is not necessarily the
case. F-tests for main effects and interactions in ANOVA, for example,
provide a concise summary for the factors and their relationship, but
eventually most of the time everything boils down to single (not
composite) effect testing. In other words, almost all those t-tests in
``3dttest``, ``3dANOVAx``, ``3dRegAna``, ``3dMVM`` or ``3dLME`` can be
run with 3dMEMA.

Putting in a different perspective, you can run 3dMEMA if your
analysis can be conceptualized into one of the following types:

#. one condition within one group;
   
#. two conditions within one group;
   
#. one condition within two or more groups with homoskedasticity;
   
#. one condition within two or more groups with heteroskedasticity.

Most tests from a sophisticated analysis design should find their
niche in the above list. For example, suppose we have factor A, coding
for two groups of subjects, and factor B, representing two levels
(e.g., house and face) of an experiment condition. Usually we can get
all the tests we want with one batch script::

  3dANOVA3 -type 5 ...

However, whatever we can get with options such as ``-fa``, ``-fb``,
``-fab``, ``-amean``, ``-bmean``, ``-adiff``, ``-bdiff``, ``-acontr``,
``-bcontr``, ``-aBdiff``, ``-Abdiff``, ``-aBcontr``, and ``-Abcontr``,
they are essentially all t-tests (including those F-tests for main
effects and interaction with ONE numerator degree of freedom), which
means we can deal with them with ``3dMEMA`` without any problems, but
just one test a time! Moreover, these F-tests are disadvantageous and
not as informative compared to their counterpart with t-tests because
F hides the directionality (sign) of the effect of interest. For
instance, the F-test for the interaction between factors A and B (both
with 2 levels) in this example is essentially equivalent to the t-test
``(A1B1-A1B2)-(A2B1-A2B2)`` or ``(A1B1-A2B1)-(A1B2-A2B2)``, but we can
say more with the t-test than F: a positive t-value shows ``A1B1-A1B2
> A2B1-A2B2`` and ``A1B1-A2B1 > A1B2-A2B2``.

The only tests that 3dMEMA can't currently handle are those F-tests
with multiple numerator degrees of freedom, but hopefully this F-test
limitation will change in the future.

.. the following contains broken links!
 
   See more discussion here or here regarding ``3dMEMA`` or
   ``3dtest++`` vs. traditional ANOVA framework.

   https://sscc.nimh.nih.gov/afni/community/board/read.php?1,76082,76097#msg-76097
   and
   http://wang2yg.blogspot.com/2011/10/good-point-from-gang-chen.html,
   respectively!


As beta precision estimate is important for MEMA, it is suggested (not
mandated, of course) that

#. all input files, beta and more importantly t-statistic, come from
   ``3dREMLfit`` output instead of 3dDeconvolve;
   
#. warping to standard space be performed before spatial smoothing and
   individual subject regression analysis to avoid the troubling step
   of warping on t-statistic;
   
#. no masking be applied at individual subject analysis level so that
   no data is lost at group level along the edge of (and sometimes
   inside) the brain.

If you don't have R installed yet on your computer, choose a `mirror
site <https://cran.r-project.org/mirrors.html>`_ geographically close
to you, and download the appropriate binary for your platform (or the
source code and then compile yourself). Set your path
appropriately. For example, my R executable is under
``/Applications/R.app/Contents/MacOS`` on my Mac OS X, so I add
``/Applications/R.app/Contents/MacOS`` as one of the search paths in
my C shell startup configuration file ``~/.cshrc``

If the installation is successful, start the R interface with the
following command on the prompt::

  R
  
You can also work with the GUI version of R on Mac OS and
Windows. Special note for Mac OS X users when using the GUI R: Don't
start the GUI R through clicking the icon because it would fail to
initialize all the path setup on the X11. Instead run the GUI version
by typing/copying the following on the terminal (or, even better,
setting an alias ``/Applications/R.app/Contents/MacOS/R &``).

The usage of 3dMEMA can be found at the terminal::
  
  3dMEMA -help | less
  
How to use 3dMEMA to handle multiple groups
=================================================

Suppose at group level we have three categorical variables (factors):
one within-subject factor condition with two levels, positive (pos)
and negative (neg); two between-subjects factors, sex (male and
female) and genotypes (FF, TT, and FT). This would be a mixed 2 (sex)
x 3 (genotype) x 2 (condition) ANOVA, but we would like to use 3dMEMA
to tackle the analysis.

First we need the contrast of positive and negative conditions and its
t-statistic from each subject (with 3dREMLfit). Then we treat the two
between-subjects factors and their interactions as covariate via dummy
coding in a text file with the five columns. Note that dummy coding
works like this: for each factor choose one level as base (also called
reference) and code it with 0, and a factor with k levels is
represented with k-1 columns each of which codes for one level (except
for the base level):

.. code-block:: none

   F-M  TT-FF  FT-FF  int1  int2
   0     0      0     0     0
   0     1      0     0     0
   0     0      1     0     0
   1     0      0     0     0
   1     1      0     1     0
   1     0      1     0     1


If you call the above text file as cov.txt, then add the following
line in the ``3dMEMA`` script::

  -covariates_center F-M = 0 TT-FF = 0 FT-FF = 0 int1 = 0 int2 = 0

**Interpretation of the output:**

#. the first two sub-bricks corresponds to the base of all
   between-subjects factors: the contrast of positive and negative
   conditions of male with FF genotype.

#. the next two sub-bricks corresponds to the first column of the
   covariate file: the sex difference in the contrast of positive and
   negative conditions (or the interaction between sex and condition)

#. the next two sub-bricks corresponds to the second column of the
   covariate file: the genotype difference between TT and FF in the
   contrast of positive and negative conditions

#. the next two sub-bricks corresponds to the third column of the
   covariate file: the genotype difference between FT and FF in the
   contrast of positive and negative conditions

#. the next two sub-bricks corresponds to the fourth column of the
   covariate file: three-way interaction

#. the next two sub-bricks corresponds to the fifth column of the
   covariate file: another three-way interaction.


Running 3dMEMA inside R
===========================

Alternatively ``3dMEMA`` works in a procedural or streamlined fashion
with a string of information about modeling parameters, input files
(beta and t-statistic) and options. Hopefully anything else should be
self-evident from there as shown below with user input underlined in
bold face (Note: input files with sub-brick selector are allowed, but
no quotes are needed around the square brackets. See example below):

.. hidden-code-block:: none
   :starthidden: False
   :label: - show code y/n -

   > source("~/abin/3dMEMA.R")
   [1] "#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
   [1] "          ================== Welcome to 3dMEMA.R ==================          "
   [1] "AFNI Meta-Analysis Modeling Package!"
   [1] "#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
   [1] "Version 0.1.3,  Jan. 8, 2010"
   [1] "Author: Gang Chen (gangchen@mail.nih.gov)"
   [1] "Website: http://afni.nimh.nih.gov/sscc/gangc/3dMEMA.html"
   [1] "SSCC/NIMH, National Institutes of Health, Bethesda MD 20892"
   [1] "#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
   [1] "################################################################"
   [1] "Please consider citing the following if this program is useful for you:"
        Gang Chen, Manual or manuscript coming soon.
   [1] "################################################################"
   [1] "Use CNTL-C on Unix or ESC on GUI version of R to stop at any moment."
   Output file name (just prefix, no view+suffix needed, e.g., myOutput): myOutput
   [1] "On a multi-processor machine, parallel computing will speed up the program significantly."
   [1] "Choose 1 for a single-processor computer."
   Number of parallel jobs for the running (e.g., 2)? 4
   Number of groups (1 or 2)? 1
   [1] "-----------------"
   [1] "The following types of group analysis are currently available:"
   [1] "The following types of group analysis are currently available:"
   [1] "1: one condition with one group;"
   [1] "2: one condition across 2 groups with homoskedasticity (same variability);"
   [1] "3: two conditions with one group;"
   [1] "4: one condition across 2 groups with heteroskedasticity (different variability)."
   Which analysis type (1, 2, 3): 3
   [1] "Since the contrast between the 2 conditions will be the 1st minus the 2nd, choose"
   [1] "an appropriate order between the 2 conditions to get the desirable contrast."
   Label for the contrast? myContrast
   Number of subjects: 18
   Number of subjects in group Female (e.g., 12)? 24
   No. 1 subject label in group: S1
   ...
   No. 18 subject label in group: S18
   Label for condition 1? conditon1
   No. 1 subject file for beta or linear combination of betas with condition1: subj1_con1_B+tlrc.BRIK[0]
   No. 1 subject file for the corresponding t-statistic with condition1: subj1_con1_T+tlrc.BRIK[1]
   [1] "-----------------"
   No. 2 subject file for beta or linear combination of betas with condition1: subj2_con1_B+tlrc.BRIK[0]
   No. 2 subject file for the corresponding t-statistic with condition1: subj2_con1_T+tlrc.BRIK[1]
   ...
   Label for condition 2? conditon2
   No. 1 subject file for beta or linear combination of betas with condition2: subj1_con2_B+tlrc.BRIK[0]
   No. 1 subject file for the corresponding t-statistic with condition2: subj1_con2_T+tlrc.BRIK[1]
   [1] "-----------------"
   No. 2 subject file for beta or linear combination of betas with condition2: subj2_con2_B+tlrc.BRIK[0]
   No. 2 subject file for the corresponding t-statistic with condition2: subj2_con2_T+tlrc.BRIK[1]
   ...
   Number of subjects with non-zero t-statistic? (0-18) 12
   [1] "-----------------"
   [1] "t-statistic is a little more conservative but also more appropriate for significance testing than Z"
   [1] "especially when sample size, number of subjects, is relatively small."
   Z- or t-statistic for the output? (0: Z; 1: t) 0
   [1] "-----------------"
   [1] "Masking is optional, but will alleviate unnecessary penalty on q values of FDR correction."
   Any mask (0: no; 1: yes)? myMask+tlrc.BRIK
   [1] "-----------------"
   [1] "Covariates are continuous variables (e.g., age, behavioral data) that can be partialled out in the model."
   Any covariates (0: no; 1: yes)? 0
   [1] "-----------------"
   [1] "If outliers exist at voxel/subject level, a special model can be adopted to account for outliers"
   [1] "in the data, leading to increased statistical power at slightly higher computation cost."
   Model outliers (0: no; 1: yes)? 1
   [1] "-----------------"
   [1] "The Z-score of residuals indicates the significance level a subject is an outlier at a voxel."
   [1] "Turn off this option if memory allocation problem occurs later on."
   Want residuals Z-score for each subject (0: no; 1: yes)? 1
   [1] "-----------------"
   [1] "Totally 43 slices in the data."
   [1] "-----------------"
   [1] "Package snow successfully loaded!"
   Z slice # 1 done:  04/30/09 14:06:17.290 
   Z slice # 2 done:  04/30/09 14:06:17.982
   ...
   Z slice # 43 done:  04/30/09 14:17:27.149
   [1] "Analysis finished: 04/30/09 14:17:27.151"
   [1] "#++++++++++++++++++++++++++++++++++++++++++++"
   ++ 3drefit: AFNI version=AFNI_2008_07_18_1710 (Apr  8 2009) [32-bit]
   ++ Authored by: RW Cox
   ++ Processing AFNI dataset myOutput+orig
    + Changed dataset view type and filenames.
    + created 2 FDR curves in dataset header
   ++ 3drefit processed 1 datasets
   > proc.time()
      user  system elapsed 
    39.847  13.348 743.834


All input files should only contain ONE (either beta or t-statistic)
sub-brick. You don't have to type those input file names. Instead I
suggest that you list all those files by executing 'ls -1 *.BRIK'
(number ONE, not letter L ) on the terminal, and copy and taste them
onto the 3dMEMA interface. Directories can be included as part of the
file name, that is, those input files don't have to be in the same
directory where you run 3dMEMA. It's always a good habit, for records
and for running it again (or a different analysis) in batch mode later
on, to save all the input items in a pure text file with content like
the following (don't include those interpretive words after the pound
sign):

.. hidden-code-block:: none
   :starthidden: False
   :label: - show code y/n -

   source("~/abin/3dMEMA.R")
   myOutput    # output file name (no view and appendix needed)
   4           # number of parallel jobs
   1           # number of groups of subjects
   3           # paired-sample type
   myContrast  # label for condition 1 vs. condition 2
   18          # total number of subjects
   conditon1   # condition 1 label
   subj1_con1_B+tlrc.BRIK[0]   # beta value for subject 1
   subj1_con1_T+tlrc.BRIK[1]   # t-statistic for subject 1
   subj2_con1_B+tlrc.BRIK[0]
   subj2_con1_T+tlrc.BRIK[1]
   ......
   conditon2   # condition 2 label
   subj1_con2_B+tlrc.BRIK[0]
   subj1_con2_T+tlrc.BRIK[1]
   subj2_con2_B+tlrc.BRIK[0]
   subj2_con2_T+tlrc.BRIK[1]
   ......
   12          # minimum number of subjects allowed to have ZERO t-statistic at a voxel
   0           # want Z or t-statistic
   1           # yes a mask will be provided; otherwise 0
   myMask+tlrc.BRIK  # mask
   0           # no covariates
   1           # handle outliers with a special model
   1           # Z-score for residuals




There are **two output files**, one includes all the major effects
plus the associated statistics, while the other output, if requested,
contains two values at a voxel for each subject: lambda measures the
percentage of within-subject variability relative the total
variability, and Z-score shows the significance level that voxel is an
outlier relative to the group effect.

The runtime can be significantly reduced through parallel computing:
If multiple cores are available on your computer, simply specify the
number of parallel jobs in the program. Once you know the exact
answers for those sequential questions, you may want to run 3dMEMA.R
in a batch mode for a slightly different analysis by creating a file
like one above (or multiple ones concatenated), calling it Cmds.R, for
example (again don't include those interpretive words). Type one of
the following two commands at the terminal prompt (not inside R):

.. code-block:: none

   R CMD BATCH Cmds.R myDiary &
   Rscript Cmds.R |& tee myDiary &
   
or in the same fashion but remotely:

.. code-block:: none

   nohup R CMD BATCH Cmds.R myDiary &
   nohup Rscript Cmds.R > myDiary &


File "myDiary" contains the progression of the running including error
message. In case you encounter some problem with ``3dMEMA``, please send
me the whole file myDiary.

To quit R, type

.. code-block:: none

   q()

(or hit letter "d" while holding down CTRL key on UNIX-based systems).

Acknowledgements
====================
                
I'd like to thank Jarrod Hadfield for directing my attention to meta
analysis, Wolfgang Viechtbauer for theoretical consultation and
programming support, Xianggui Qu for help in formula derivation, and
James Bjork for help in testing the program and for providing
feedback.
