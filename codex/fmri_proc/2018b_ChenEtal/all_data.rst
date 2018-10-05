 
.. begin_title

.. title(s) with links; usually just a single paper here

**Chen GC, Xiao Y, Taylor PA, Riggins T, Geng F, Redcay E, Cox RW
(2018).** `Handling Multiplicity in Neuroimaging through Bayesian
Lenses with Hierarchical Modeling
<https://www.biorxiv.org/content/early/2017/12/22/238998>`_

.. end_title


.. begin_short_tags

:**tags**: task-block, EPI, MPRAGE, human, adult 

.. end_short_tags


.. begin_long_tags

.. full table format of search strings
.. table::
   :column-alignment: left 
   :column-wrapping: true 
   :column-dividers: double single double

   =======================  ===================
   Tag                      Label
   =======================  ===================
   FMRI paradigm:           task-block 
   FMRI dset:               EPI          
   Anatomical dset:         MPRAGE       
   Subject population:      human        
   Subject characteristic:  -      
   Subject age:             adult        
   Template space:          -    
   Template align method:   -    
   Tissue segmentation:     -   
   Tissue regression:       -
   Comments:                
   =======================  ===================

.. end_long_tags


.. NB, nothing needs to be put into this next field-- could just
   remain blank!
.. begin_script_note

   These scripts describe different approaches for processing FMRI
   data with AFNI.  Please read the comments at the tops of the
   scripts carefully, as well as the bioRxiv papers associated with
   each, in order to understand the steps.

.. end_script_note


.. begin_script_table

.. list-table:: 
   :header-rows: 0

   * - |s01|
     - An example of group level analysis with the "Bayesian
       multilevel" (BML) approach. 
   * - |s02|
     - The data table of subject information input into the BML
       analysis.  See the associated paper for full description and
       generation.

.. aliases for scripts, so above is easier to read
.. |s01| replace:: :download:`runBGA.tcsh
                   <fmri_proc/2018b_ChenEtal/runBGA.tcsh>`
.. |s02| replace:: :download:`test_ToMI_1106.txt
                   <fmri_proc/2018b_ChenEtal/test_ToMI_1106.txt>`

.. end_script_table
