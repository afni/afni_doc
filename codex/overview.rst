.. _codex_overview:

********
Overview
********

.. contents:: :local:

Introduction
==========================================

Publications in the Codex are listed in (approximate) reverse
chronological order. 

Some programs from other software are listed here, because they were
included in the processing.  In such cases, the other software package
is noted, for example with FreeSurfer: ``recon-all`` (FS).

Many thanks to the authors who have made their coding/scripting work
available for general benefit.
 

Program names and keywords for searching
==========================================

Below are lists of main programs used in Codex scripts (some of the
smaller/incidental programs are not used here) and also study
keywords.  Searching with these might/should make it easier to find
examples of interest.  These lists will likely grow over time.

**Main Program List** 

   .. hlist:: 
      :columns: 3

      * ``afni_proc.py``
      * ``@SSwarper``
      * ``3dClusterize``
      * ``3dclust``
      * ``3dClustSim``          
      * ``3dmask_tool``
      * ``BayesianGroupAna.py`` 
      * ``recon-all`` (FS)    
      * ``@SUMA_Make_Spec_FS``
      * ``gen_group_command.py``
      * ``3dttest++``
      * ``3dMEMA``              
      * ``3dANOVA2``


**Study keywords by category**

   .. list-table::
      :header-rows: 0
      :widths: 25 75
      :stub-columns: 0

      * - **FMRI paradigm**
        - task-block, task-event, resting, naturalistic
      * - **FMRI dset**
        - EPI, dual phase (AP-PA)
      * - **Anatomical dset**
        - MPRAGE, T1w, T2w, T1ma
      * - **Subject population**
        - human, nonhuman primate, macaque, rat, simulation
      * - **Subject characteristic**
        - patient, control
      * - **Subject age group**
        - prenatal, newborn, infant, child, juvenile, adult, senior
      * - **Template space**
        - MNI, Talairach, Haskins-ped, native,
      * - **Template align method**
        - linear, nonlinear
      * - **Geometry of final analysis**
        - volumetric (default), surface
      * - **Tissue segmentation method**
        - 3dSeg, FreeSurfer
      * - **Tissue regression**
        - ANATICOR, fANATICOR, PCA, WM+Vent





.. comment: 
   
   old/original list


   .. table::
      :column-alignment: left left
      :column-wrapping: true true 
      :column-dividers: double single double

      ========================  ===============================================
      Tag (study descriptors):  Label (for searchability)
      ========================  ===============================================
      FMRI paradigm:            task-block, task-event, resting, naturalistic, 
                                par-other
      FMRI dset:                EPI, dual phase (AP-PA), fmri-other
      Anatomical dset:          MPRAGE, T1w, T2w, T1map, T2map, FLAIR, FLASH, 
                                PD, SWI, Angio, none, anat-other
      Subject population:       human, nonhuman primate, macaque, rat, 
                                simulation, pop-other
      Subject characteristic:   patient, control, char-other
      Subject age:              prenatal, newborn, infant, child, juvenile, 
                                adult, senior, age-other
      Template space:           MNI, Talairach, Haskins-ped, native, sp-other
      Template align method:    linear, nonlinear, al-other
      Tissue segmentation:      3dSeg, FreeSurfer, seg-other
      Tissue regression:        ANATICOR, fANATICOR, PCA, WM+Vent, reg-other
      ========================  ===============================================





