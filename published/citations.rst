.. _pubcit_citations:


**Citations**
==========================================

.. contents:: :local:

.. highlight:: None

If you make use of AFNI and its tools in your work, we ask that you
please cite the main paper and any accompanying items as appropriate.


Methods: General
----------------

If you use AFNI in your work, please cite:

* | Cox RW (1996). AFNI: software for analysis and visualization of
    functional magnetic resonance neuroimages. Comput Biomed Res
    29(3):162-173. doi:10.1006/cbmr.1996.0014 
  | `<https://pubmed.ncbi.nlm.nih.gov/8812068/>`_

* | RW Cox, JS Hyde (1997). Software tools for analysis and
    visualization of FMRI Data.  NMR in Biomedicine, 10: 171-178.
  | `<https://pubmed.ncbi.nlm.nih.gov/9430344/>`_

If you use SUMA in your work for surface calculations and/or
visualizations, please cite:

* | Saad ZS, Reynolds RC, Argall B, Japee S, Cox RW (2004). SUMA: an
    interface for surface-based intra- and inter-subject analysis with
    AFNI, in: 2004 2nd IEEE International Symposium on Biomedical
    Imaging: Nano to Macro (IEEE Cat No. 04EX821). Presented at the
    2004 2nd IEEE International Symposium on Biomedical Imaging: Nano
    to Macro (IEEE Cat No. 04EX821), pp. 1510-1513
    Vol. 2. doi.org/10.1109/ISBI.2004.1398837
  | `<https://ieeexplore.ieee.org/document/1398837>`_

* | Saad ZS, Reynolds RC (2012). SUMA. Neuroimage 62,
    768–773. doi.org/10.1016/j.neuroimage.2011.09.016
  | `<https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3260385/>`_

If you use standard meshes within your surface/SUMA analysis, please
cite:

* | Argall BD, Saad ZS, Beauchamp MS (2006). Simplified intersubject
    averaging on the cortical surface using SUMA.  Human Brain Mapping
    27: 14-27.
  | `<https://pubmed.ncbi.nlm.nih.gov/16035046/>`_

If you use the realtime functionality from AFNI, please cite:

* | Cox RW, Jesmanowicz A (1999). Real-time 3D image registration for
    functional MRI.  Magnetic Resonance in Medicine, 42:
    1014-1018.
  | `<https://pubmed.ncbi.nlm.nih.gov/10571921/>`_

If you use the left-right flip checking for consistency in your data
(and you should!), please cite:

* | Glen DR, Taylor PA, Buchsbaum BR, Cox RW, Reynolds RC
    (2020). Beware (Surprisingly Common) Left-Right Flips in Your MRI
    Data: An Efficient and Robust Method to Check MRI Dataset
    Consistency Using AFNI. Front. Neuroinformatics 14. 
    doi.org/10.3389/fninf.2020.00018
  | `<https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7263312/>`_

For several choices of FMRI processing with ``afni_proc.py``, please cite
the following (if relevant):

* | Taylor PA, Chen G, Glen DR, Rajendra JK, Reynolds RC, Cox RW
    (2018).  FMRI processing with AFNI: Some comments and corrections
    on 'Exploring the Impact of Analysis Software on Task fMRI
    Results'. bioRxiv 308643; doi:10.1101/308643
  | `<https://www.biorxiv.org/content/10.1101/308643v1.abstract>`_

If you use ANATICOR to de-noise FMRI datasets (e.g., in
``afni_proc.py``), please cite:

* | Jo HJ, Saad ZS, Simmons WK, Milbury LA, Cox RW. Mapping sources of
    correlation in resting state FMRI, with artifact detection and
    removal. Neuroimage. 2010;52(2):571-582. 
    doi:10.1016/j.neuroimage.2010.04.246
  | `<https://pubmed.ncbi.nlm.nih.gov/20420926/>`_

If you use InstaCorr to investigate your data (it is *definitely* fun
and even *highly probably* informative), please cite:

* | Song S, Bokkers RPH, Edwardson MA , Brown T, Shah S, Cox RW, Saad
    ZS, Reynolds RC, Glen DR, Cohen LG, Latour LL (2017).  Temporal
    similarity perfusion mapping: A standardized and model-free method
    for detecting perfusion deficits in stroke.  PLoS ONE 12, Article
    number e0185552. doi: 10.1371/journal.pone.0185552
  | `<https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5626465/>`_

If you use ``3ddelay``, please cite:

* | Saad ZS, Ropella KM, Cox RW, DeYoe EA (2001). Analysis and use of
    FMRI response delays. Hum Brain Mapp 13(2):74-93. 
    doi:10.1002/hbm.1026
  | `<https://pubmed.ncbi.nlm.nih.gov/11346887/>`_

If you use ``3dSeg`` for segmentation, please cite:

* | Vovk A, Cox RW, Stare J, Suput D, Saad ZS (2011).  Segmentation
    Priors From Local Image Properties: Without Using Bias Field
    Correction, Location-based Templates, or Registration.
    Neuroimage 55:142-152.
  | `<https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3031751/>`_

If you use ``3dReHo``, ``3dNetCorr``, ``3dRSFC``, ``3dLombScargle``
(yes, really a program), ``3dAmpToRSFC``, ``3dSpaceTimeCorr``, and/or
``3dSliceNDice``, please cite:

* | Taylor PA, Saad ZS (2013). FATCAT: (An Efficient) Functional And
    Tractographic Connectivity Analysis Toolbox. Brain Connect. 3,
    523–535. doi.org/10.1089/brain.2013.0154
  | `<https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3796333/>`_

If you use ``dcm2niix_afni`` in your processing, which is a copy of
the program ``dcm2niix`` kindly contributed by Chris Rorden, please
cite:

* | Li X, Morgan PS, Ashburner J, Smith J, Rorden C (2016). The first
    step for neuroimaging data analysis: DICOM to NIfTI conversion. J
    Neurosci Methods. 264:47-56. doi:
    10.1016/j.jneumeth.2016.03.001. PMID: 26945974
  | `<https://github.com/rordenlab/dcm2niix>`_


Methods: Group analysis, stats and clustering
---------------------------------------------

If you use either of the linear mixed effects (LME) modeling programs
``3dLME`` or ``3dLMEr`` in your work, please cite:

* | Chen G, Saad ZS, Britton JC, Pine DS, Cox RW (2013). Linear
    mixed-effects modeling approach to FMRI group analysis.  NeuroImage,
    73: 176-190.
  | `<https://pubmed.ncbi.nlm.nih.gov/23376789/>`_

If you use multivariate modeling (MVM) program ``3dMVM`` in your work,
please cite:

* | Chen G, Adleman NE, Saad ZS, Leibenluft E, Cox RW (2014).
    Applications of multivariate modeling to neuroimaging group
    analysis: A comprehensive alternative to univariate general linear
    model.  NeuroImage 99:571-588.
  | `<https://pubmed.ncbi.nlm.nih.gov/24954281/>`_

If you use the mixed effects meta analysis (MEMA) program ``3dMEMA``
in your work, please cite:

* | Chen G, Saad ZS, Nath AR, Beauchamp MS, Cox RW (2012).
    FMRI Group Analysis Combining Effect Estimates and Their Variances.
    Neuroimage, 60: 747-765.
  | `<https://pubmed.ncbi.nlm.nih.gov/22245637/>`_

If you use the Bayesian multilevel (BML) modeling approach for
matrix-based analysis with the ``MBA`` program, please cite:

* | Chen G, Burkner P-C, Taylor PA, Li Z, Yin L, Glen DR, Kinnison J,
    Cox RW, Pessoa L (2019). An Integrative Approach to Matrix-Based
    Analyses in Neuroimaging. Human Brain Mapping (in press)
    doi:10.1101/459545
  | `<https://onlinelibrary.wiley.com/doi/full/10.1002/hbm.24686>`_

If you use the Bayesian Multilevel (BML) modeling approach for
region-based analysis with the ``RBA`` program, please cite:

* | Chen G, Xiao Y, Taylor PA, Rajendra JK, Riggins T, Geng F, Redcay
    E, Cox RW (2019). Handling Multiplicity in Neuroimaging Through
    Bayesian Lenses with Multilevel Modeling. Neuroinformatics. 
    17(4):515-545. doi:10.1007/s12021-018-9409-6
  | `<https://pubmed.ncbi.nlm.nih.gov/30649677/>`_

If you use IntraClass Correlation (ICC) methods within AFNI via
``3dICC``, please cite:

* | Chen G, Taylor PA, Haller SP, Kircanski K, Stoddard J, Pine DS,
    Leibenluft E, Brotman MA, Cox RW (2018). Intraclass correlation:
    Improved modeling approaches and applications for
    neuroimaging. Hum Brain
    Mapp. 2018;39(3):1187-1206. doi:10.1002/hbm.23909
  | `<https://pubmed.ncbi.nlm.nih.gov/29218829/>`_

If you use ``3dISC`` for inter-subject correlation, please cite:

* | Chen G, Taylor PA, Shin YW, Reynolds RC, Cox RW (2017). Untangling
    the Relatedness among Correlations, Part II: Inter-Subject Correlation
    Group Analysis through Linear Mixed-Effects Modeling. Neuroimage
    147:825-840. doi: 10.1016/j.neuroimage.2016.08.029
  | `<https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5303634/>`_

For an ROI-based approach through Bayesian multilevel (BML) modeling
to ISC (inter-subject correlation) and naturalistic FMRI

* | Chen G, PA Taylor, Qu X, Molfese PJ, Bandettini PA, Cox RW, Finn ES
    (2020). Untangling the Relatedness among Correlations, Part III:
    Inter-Subject Correlation Analysis through Bayesian Multilevel
    Modeling for Naturalistic Scanning. NeuroImage 216:116474. 
    doi:10.1016/j.neuroimage.2019.116474
  | `<https://pubmed.ncbi.nlm.nih.gov/31884057/>`_

For a nonparametric (voxelwise) approach to ISC (inter-subject
correlation) and naturalistic FMRI, you might want to check out:

* | Chen GC, Shin Y-W, Taylor PA,q Glen DR, Reynolds RC, Israel RB, Cox RW
    (2016). Untangling the Relatedness among Correlations, Part I:
    Nonparametric Approaches to Inter-Subject Correlation Analysis at the
    Group Level. Neuroimage 142:248-259. 
    doi:10.1016/j.neuroimage.2016.05.023
  | `<https://pubmed.ncbi.nlm.nih.gov/27195792/>`_

If you use ``1dSVAR`` (Structured Vector AutoRegression)

* | Chen G, Glen DR, Saad ZS, Paul Hamilton J, Thomason ME, Gotlib IH,
    Cox RW (2011). Vector autoregression, structural equation
    modeling, and their synthesis in neuroimaging data
    analysis. Comput Biol Med 41(12):1142-55. doi:
    10.1016/j.compbiomed.2011.09.004.
  | `<https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3223325/>`_

If you use clustering approaches such as 3dClustSim, ``3dttest++
-Clustsim``, and/or the mixed autocorrelation function (ACF)
smoothness estimation in your work, please cite:

* | Cox RW, Chen G, Glen DR, Reynolds RC, Taylor PA (2017). fMRI
    clustering and false-positive rates. Proc Natl Acad Sci
    USA. 114(17):E3370-E3371. doi:10.1073/pnas.1614961114
  | `<https://pubmed.ncbi.nlm.nih.gov/28420798/>`_

* | Cox RW, Chen G, Glen DR, Reynolds RC, Taylor PA (2017). FMRI
    Clustering in AFNI: False-Positive Rates Redux.  Brain Connect
    7(3):152-171. doi: 10.1089/brain.2016.0475.
  | `<https://pubmed.ncbi.nlm.nih.gov/28398812/>`_

If you use the equitable thresholding and clustering (ETAC) method in
your work, please cite:

* | Cox RW (2017).  Equitable Thresholding and Clustering: A Novel
    Method for Functional Magnetic Resonance Imaging Clustering in AFNI.
    9(7):529-538.  doi: 10.1089/brain.2019.0666.
  | `<https://pubmed.ncbi.nlm.nih.gov/31115252/>`_

If you use the FAT-MVM approach to group analysis (combining FATCAT
and multivariate modeling with ``3dMVM``), please cite (as well as the
main FATCAT paper, above):

* | Taylor PA, Jacobson SW, van der Kouwe A, Molteno CD, Chen G,
    Wintermark P, Alhamud A, Jacobson JL, Meintjes EM (2015). A
    DTI-based tractography study of effects on brain structure
    associated with prenatal alcohol exposure in newborns. Hum Brain
    Mapp. 36(1):170-186. doi:10.1002/hbm.22620
  | `<https://pubmed.ncbi.nlm.nih.gov/25182535/>`_

* | Chen G, Adleman NE, Saad ZS, Leibenluft E, Cox RW (2014).
    Applications of multivariate modeling to neuroimaging group
    analysis: A comprehensive alternative to univariate general linear
    model.  NeuroImage 99:571-588.
  | `<https://pubmed.ncbi.nlm.nih.gov/24954281/>`_

* | Taylor PA, Chen G, Cox RW, Saad ZS (2016). Open Environment for
    Multimodal Interactive Connectivity Visualization and
    Analysis. Brain Connect. 6,
    109–121. doi.org/10.1089/brain.2015.0363
  | `<https://pubmed.ncbi.nlm.nih.gov/26447394/>`_


Methods: Alignment 
--------------------

If you use either the local Pearson correlation (lpc) or local Pearson
absolute (lpa) cost function in your alignment (e.g., with
``3dAllineate``, ``align_epi_anat.py``, ``afni_proc.py``, ``3dQwarp``,
``@SSwarper``, ``@animal_warper``, etc.), please cite:

* | Saad ZS, Glen DR, Chen G, Beauchamp MS, Desai R, Cox RW (2009). A
    new method for improving functional-to-structural MRI alignment
    using local Pearson correlation. Neuroimage 44
    839–848. doi: 10.1016/j.neuroimage.2008.09.037
  | `<https://www.ncbi.nlm.nih.gov/pmc/articles/PMC2649831/>`_

If you use nonlinear warping in AFNI, in particular ``3dQwarp``,
please cite:

* | Cox RW, Glen DR (2013). Nonlinear warping in AFNI. Presented at
    the 19th Annual Meeting of the Organization for Human Brain Mapping.
  | `<https://afni.nimh.nih.gov/pub/dist/HBM2013/Cox_Poster_HBM2013.pdf>`_

If you use ``@animal_warper`` (esp. for alignment in animal studies),
please cite:

* | Jung B, Taylor PA, Seidlitz PA, Sponheim C, Perkins P, Glen DR,
    Messinger A (2020). A Comprehensive Macaque FMRI Pipeline and
    Hierarchical Atlas. doi: 10.1101/2020.08.05.237818
  | `<https://www.biorxiv.org/content/10.1101/2020.08.05.237818v1>`_

* | Saad ZS, Glen DR, Chen G, Beauchamp MS, Desai R, Cox RW (2009). A
    new method for improving functional-to-structural MRI alignment
    using local Pearson correlation. Neuroimage 44
    839–848. doi: 10.1016/j.neuroimage.2008.09.037
  | `<https://www.ncbi.nlm.nih.gov/pmc/articles/PMC2649831/>`_


Methods: Diffusion, DWI, DTI and HARDI
--------------------------------------

If you use the diffusion/DWI/DTI tools in AFNI, please cite the main
FATCAT paper:

* | Taylor PA, Saad ZS (2013). FATCAT: (An Efficient) Functional And
    Tractographic Connectivity Analysis Toolbox. Brain Connect. 3,
    523–535. doi.org/10.1089/brain.2013.0154
  | `<https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3796333/>`_

\.\.\. and if you use the TORTOISE package for accompanying
diffusion-based processing (such as DIFFPREP, DR_BUDDI, etc.), then
please:

* refer to `the bottom of the TORTOISE homepage
  <https://tortoise.nibib.nih.gov/>`_ for appropriate citations for
  those specific tools

If you use mini-probabilistic tracking and/or SUMA tract
visualization, please cite (as well as the main FATCAT paper, above):

* | Taylor PA, Chen G, Cox RW, Saad ZS (2016). Open Environment for
    Multimodal Interactive Connectivity Visualization and
    Analysis. Brain Connect. 6,
    109–121. doi.org/10.1089/brain.2015.0363
  | `<https://pubmed.ncbi.nlm.nih.gov/26447394/>`_

If you use probabilistic or deterministic tractography in your work
with ``3dTrackID``, please cite (as well as the main FATCAT paper,
above):

* | Taylor PA, Cho K-H, Lin C-P, Biswal BB (2012). Improving DTI
    Tractography by including Diagonal Tract Propagation. PLoS ONE
    7(9): e43415. 
  | `<https://pubmed.ncbi.nlm.nih.gov/22970125/>`_


Methods: Additional applications
----------------------------------

If you use DBSproc (for Deep Brain Stimulation processing), please
cite:

* | Lauro PM, Vanegas-Arroyave N, Huang L, Taylor PA, Zaghloul KA,
    Lungu C, Saad ZS, Horovitz SG (2016). DBSproc: An open source
    process for DBS electrode localization and tractographic
    analysis. Hum Brain
    Mapp. 37(1):422-433. doi:10.1002/hbm.23039
  | `<https://pubmed.ncbi.nlm.nih.gov/26523416/>`_

If you use ALICE (Automatic Localization of Intra-Cranial Electrodes;
an interface for the alignment of datasets, clustering and ordering of
electrodes for ECOG and SEEG and reprojection to the brain surface
using CT and MRI imaging), please cite:

* | Branco MP, Gaglianese A, Glen DR, Hermes D, Saad ZS, Petridou N,
    Ramsey NF (2018). ALICE: a tool for automatic localization of
    intra-cranial electrodes for clinical and high-density
    grids. J. Neurosci. Methods 301, 43–51.  doi:
    10.1016/j.jneumeth.2017.10.022
  | `<https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5952625/>`_

If you use the AFNI-engaged approach for modeling dynamic contrast
enhanced (DCE) MRI for analysis of brain tumors, please cite:

* | Sarin H, Kanevsky AS, Fung SH, Butman JA, Cox RW, Glen D, Reynolds
    R, Auh S (2009). Metabolically stable bradykinin B2 receptor
    agonists enhance transvascular drug delivery into malignant brain
    tumors by increasing drug half-life. J Transl
    Med 7:33. doi:10.1186/1479-5876-7-33
  | `<https://pubmed.ncbi.nlm.nih.gov/19439100/>`_

If you use this numerical method for measuring symmetry in brain FMRI
data, please site:

* | Jo HJ, Saad ZS, Gotts SJ, Martin A, Cox RW (2012). Quantifying
    agreement between anatomical and functional interhemispheric
    correspondences in the resting brain. PLoS One 7:e48847. 
    doi: 10.1371/journal.pone.0048847
  | `<https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3493608/>`_

\.\.\. and if you are still curious about symmetry in the brain, check
out this paper for methodology:

* | Gotts SJ, Jo HJ, Wallace GL, Saad ZS, Cox RW, Martin A (2013). Two
    distinct forms of functional lateralization in the human brain. Proc
    Natl Acad Sci USA. 110(36):E3435-E3444. doi:10.1073/pnas.1302581110
  | `<https://pubmed.ncbi.nlm.nih.gov/23959883/>`_

If you are curious about using multiecho/MEICA FMRI, please see:

* | Kundu P, Brenowitz ND, Voon V, Worbe Y, Vertes PE, Inati SJ, Saad
    ZS, Bandettini PA, Bullmore ET (2013). Integrated strategy for
    improving functional connectivity mapping using multiecho
    fMRI. Proc Natl Acad Sci
    USA. 110(40):16187-16192. doi:10.1073/pnas.1301725110
  | `<https://pubmed.ncbi.nlm.nih.gov/24038744/>`_

Meta-methodology and validations
---------------------------------

If you want to note the good performance of AFNI's time series
autocorrelation modeling compared with other software, you might
consider citing:

* | Olszowy W, Aston J, Rua C, Williams GB (2019).  Accurate
    autocorrelation modeling substantially improves fMRI reliability
    Nature Communications
    10, 1220. doi.org/10.1038/s41467-019-09230-w
  | `<https://www.nature.com/articles/s41467-019-09230-w>`_

If you want to note the good performance of AFNI's defacing/refacing
tool ``@afni_refacer_run``, you can check out those OHBM-2020 poster
that found it the overall best among currently available tools:

* | Theyers A, Arnott SR, Zamyadi M, O'Reilly M, Bartha R, Symons S,
    MacQueen G, Hassel S, Lerch JP, Anagnostou E, Strother SC
    (2020). Comparison of MRI Defacing Software Across Multiple
    Cohorts.  Presented at the Organization for Human Brain
    Mapping, 2020.

If you want to note the good performance of AFNI's volume registration
for motion correction with ``3dvolreg``, you might consider:

* | Oakes TR, Johnstone T, Ores Walsh KS, Greischar LL, Alexander AL,
    Fox AS, Davidson RJ (2005). Comparison of fMRI motion correction
    software tools. Neuroimage. 28(3):529-543. 
    doi:10.1016/j.neuroimage.2005.05.058
  | `<https://pubmed.ncbi.nlm.nih.gov/16099178/>`_

If you want to know about spatial smoothness estimation and resampling
stability in AFNI, have a gander at:

* | Cox RW, Taylor PA (2017). Stability of spatial smoothness and
    cluster-size threshold estimates in FMRI using
    AFNI. https://arxiv.org/abs/1709.07471
  | `<https://arxiv.org/abs/1709.07471>`_

If you use proper statistical testing in your work (two-sided testing
in most cases, or one-sided testing where clearly applicable), you
might consider citing:  

* | Chen G, Cox RW, Glen DR, Rajendra JK, Reynolds RC, Taylor PA
    (2019).  A tail of two sides: Artificially doubled false positive
    rates in neuroimaging due to the sidedness choice with t-tests.  Human
    Brain Mapping 40:1037-1043.
  | `<https://pubmed.ncbi.nlm.nih.gov/30265768/>`_

If you display effect estimates (rather than just stats), and/or if
you scale your data in a voxelwise manner, you might consider citing:

* | Chen G, Taylor PA, Cox RW (2017). Is the statistic value all we
    should care about in neuroimaging?
    Neuroimage. 147:952-959. doi:10.1016/j.neuroimage.2016.09.066
  | `<https://pubmed.ncbi.nlm.nih.gov/27729277/>`_

If you are curious about how to deal with multiplicity issues in your
statistical analysis of MRI, consider this discussion of neighborhood
leverage (*new!*) vs global calibration (*old!*) with a Bayesian
multilevel (BML) approach:

* | Chen G, Taylor PA, Cox RW, Pessoa L. Fighting or embracing
    multiplicity in neuroimaging? neighborhood leverage versus global
    calibration. Neuroimage. 2020;206:116320. 
    doi:10.1016/j.neuroimage.2019.116320
  | `<https://pubmed.ncbi.nlm.nih.gov/31698079/>`_

For work checking out different methods of diffusion/DWI acquisition
and correction, such as prospective motion correction and the TORTOISE
toolbox, particularly in the case where subjects move (kids these
days...), then please check out:

* | Taylor PA, Alhamud A, van der Kouwe A, Saleh MG, Laughton B,
    Meintjes E (2016). Assessing the performance of different DTI
    motion correction strategies in the presence of EPI distortion
    correction. Hum. Brain Mapp. 37, 4405–4424. doi: 10.1002/hbm.23318
  | `<https://pubmed.ncbi.nlm.nih.gov/27436169/>`_

.. _pub_cit_noooo_gsr:

For papers discussing global signal regression (GSR), and several
reasons why not to do it (note: there are many other papers by other
groups that show this as well...), please check out/reference:

* | Saad ZS, Gotts SJ, Murphy K, Chen G, Jo HJ, Martin A, Cox RW (2012).
    Trouble at Rest: How Correlation Patterns and Group Differences
    Become Distorted After Global Signal Regression.  Brain
    Connectivity, 2(1):25-32. doi: 10.1089/brain.2012.0080
  | `https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3484684/`_

* | Saad ZS, Reynolds RC, Jo HJ, Gotts SJ, Chen G, Martin A, Cox RW (2013).
    Correcting Brain-Wide Correlation Differences in Resting-State FMRI.
    Brain Connectivity, 3(4):339-352. doi: 10.1089/brain.2013.0156
  | `<https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3749702/>`_

* | Jo HJ, Gotts SJ, Reynolds RC, Bandettini PA, Martin A, Cox RW, Saad
    ZS (2013).  Effective preprocessing procedures virtually eliminate
    distance-dependent motion artifacts in resting state FMRI.  Journal
    of Applied Mathematics: art.no. 935154.
  | `<https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3886863/>`_

* | Gotts SJ, Saad ZS, Jo HJ, Wallace GL, Cox RW, Martin A (2013).  The
    perils of global signal regression for group comparisons: A case
    study of Autism Spectrum Disorders.
    Front. Hum. Neurosci. 7:356. doi: 10.3389/fnhum.2013.00356
  | `<https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3709423/>`_

* | Gotts SJ, Simmons WK, Milbury LA, Wallace GL, Cox RW, Martin A (2012).
    Fractionation of Social Brain Circuits in Autism Spectrum Disorders.
    Brain, 135: 2711-2725.
  | `<https://pubmed.ncbi.nlm.nih.gov/22791801/>`_

If you want to learn about AFNI+SUMA results on the FIAC dataset,
please see:

* | Saad ZS, Chen G, Reynolds RC, Christidis PP, Hammett KR, Bellgowan
    PSF, Cox RW (2006).  FIAC Analysis According to AFNI and SUMA.
    Human Brain Mapping 27: 417-424. doi: 10.1002/hbm.20247
  | `<https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6871397/>`_

If you want to know more about AFNI and its development and
underpinnings, please see:

* | Cox RW (2012). AFNI: what a long strange trip it's been.
    NeuroImage 62:747-765. doi: 10.1016/j.neuroimage.2011.08.056
  | `<https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3246532/>`_

If you want to know more about SUMA and its development and
underpinnings, please see the pithily titled:

* | Saad ZS, Reynolds RC (2012). SUMA.
    NeuroImage 62:768-773. doi: 10.1016/j.neuroimage.2011.09.016
  | `<https://pubmed.ncbi.nlm.nih.gov/21945692/>`_

Data projects
-------------

For technical reference for the NIFTI data format, please cite:

* | Cox RW, Ashburner J, Breman H, Fissell K, Haselgrove C, Holmes CJ,
    Lancaster JL, Rex DE, Smith SM, Woodward JB, Strother SC (2004). A
    (sort of) new image data format standard: NiFTI-1. Presented at
    the 10th Annual Meeting of the Organization for Human Brain
    Mapping.

*India Brain Template (IBT).* We present a series of five age-specific
brain templates and accompanying atlases (IBTAs), spanning an age
range of 6-60 years.  These templates and atlases were created from a
large number of subjects (total n=466), spanning a large number of
different Indian states and and acquired at multiple 3T MRI sites,
using a new  AFNI tool called ``make_template_dask.py``:

* | Holla B, Taylor PA, Glen DR, Lee JA, Vaidya N, Mehta UM,
    Venkatasubramanian G, Pal P, Saini J, Rao NP, Ahuja C, Kuriyan R,
    Krishna M, Basu D, Kalyanram K, Chakrabarti A, Orfanos DP, Barker
    GJ, Cox RW, Schumann G, Bharath RD, Benegal V (2020).  A series of
    five population-specific Indian brain templates and atlases
    spanning ages 6 to 60 years.  bioRxiv 2020.05.08.077172;
    doi:10.1101/2020.05.08.077172
  | `<https://www.biorxiv.org/content/early/2020/08/10/2020.05.08.077172>`_

*Marmoset atlas v2.* This project provides some of the highest
resolution nonhuman primate MRI templates and atlas for gray and white
matter with multi-modal MRI imaging at 0.150 mm, 0.060 mm, 0.080 mm
and 0.050 mm spatial resolution:

* | Liu C, Ye FQ, Newman JD, Szczupak D, Tian X, Yen CC, Majka P, Glen
    D, Rosa MGP, Leopold DA, Silva AC (2020). A resource for the
    detailed 3D mapping of white matter pathways in the marmoset
    brain. Nat Neurosci 23(2):271-280. doi: 10.1038/s41593-019-0575-0.
  | `<https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7007400/>`_

*Marmoset atlas v1: NIH Marmoset.* This atlas introduces a
high-resolution template and atlas for cortical gray matter at
0.150 mm (see also the marmoset atlas v2, above):

* | Liu C, Ye FQ, Yen CC, Newman JD, Glen D, Leopold DA, Silva AC. A
    digital 3D atlas of the marmoset brain based on multi-modal MRI
    (2018). Neuroimage. 169:106-116. doi:
    10.1016/j.neuroimage.2017.12.004. 
  | `<https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5856608/>`_

*D99 atlas.* Based on the Saleem macaque atlas, this project
introduces a high resolution digital MRI template together with new
meticulous delineations of macaque cortical regions:

* | Reveley C, Gruslys A, Ye FQ, Glen D, Samaha J, E Russ B, Saad Z, K
    Seth A, Leopold DA, Saleem KS (2017). Three-Dimensional Digital
    Template Atlas of the Macaque Brain. Cereb Cortex
    27(9):4463-4477. doi: 10.1093/cercor/bhw248.
  | `<https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6075609/>`_

*NMT v1: Macaque brain group template.* Using the data from 31
macaques, this template provides a high resolution group template for
macaques at 0.250 mm (this is NMT v1; see below for NMT v2):

* | Seidlitz J, Sponheim C, Glen DR, Ye FQ, Saleem KS, Leopold DA,
    Ungerleider L, Messinger A (2018). A Population MRI Brain
    Template and Analysis Tools for the Macaque. NeuroImage 170:
    121–31. doi: 10.1016/j.neuroimage.2017.04.063.
  | `<https://pubmed.ncbi.nlm.nih.gov/28461058/>`_

*NMT v2: Macaque brain group template and hierarchical cortical
atlas.* This project introduces version the macaque template NMT v2
using a stererotaxic (ear-bar-zero) reference frame and a hierarchical
atlas (CHARM) for structural region labels (and see these pages for
more information about the related :ref:`templates and atlases
<nh_macaque_tempatl>` and :ref:`task and rest FMRI Demos
<nh_macaque_demos>`):

* | Jung B, Taylor PA, Seidlitz PA, Sponheim C, Perkins P, Glen DR,
    Messinger A (2020). A Comprehensive Macaque FMRI Pipeline and
    Hierarchical Atlas. doi: 10.1101/2020.08.05.237818
  | `<https://www.biorxiv.org/content/10.1101/2020.08.05.237818v1>`_

*PRIME-RE: the PRIMatE Resource Exchange.* A collaborative online
platform for nonhuman primate (NHP) neuroimaging, including AFNI tools
(such as ``@animal_warper`` and ``afni_proc.py`` applied to macaque
datasets; see al Jung et al., 2020, above, and these pages for more
information about the related :ref:`templates and atlases
<nh_macaque_tempatl>` and :ref:`task and rest FMRI Demos
<nh_macaque_demos>`):

* | Messinger A, Sirmpilatze N, Heuer K, Loh K, Mars R, Sein J, Xu T,
    Glen D, Jung B, Seidlitz J, Taylor P, Toro R, Garza-Villareal E,
    Sponheim C, Wang X, Benn A, Cagna B, Dadarwal R, Evrard H,
    Garcia-Saldivar P, Giavasis S, Hartig R, Lepage C, Liu C, Majka P,
    Merchant H, Milham M, Rosa M, Tasserie J, Uhrig L, Margulies D,
    Klink PC (2020).  A collaborative resource platform for non-human
    primate neuroimaging. bioRxiv 2020.07.31.230185; doi:
    10.1101/2020.07.31.230185 
  | `<https://doi.org/10.1101/2020.07.31.230185>`_
