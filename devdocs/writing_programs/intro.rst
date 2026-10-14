.. _wp_intro:

===================================
Anatomy of an AFNI Program
===================================

.. contents:: In this chapter
   :local:

The 30-second version
=====================

Almost every AFNI command-line program is a single ``.c`` file in ``src/``
that:

#. ``#include "mrilib.h"`` (which pulls in essentially the whole AFNI C API);
#. opens one or more datasets with :func:`THD_open_dataset` and loads their
   voxel data with :func:`DSET_load`;
#. does some computation, usually voxel-wise or volume-wise;
#. builds an output ``THD_3dim_dataset`` and writes it with :func:`DSET_write`.

The canonical, heavily commented example is :file:`src/3dToyProg.c`.  If you
read only one file before writing your own program, read that one.  This
chapter describes the scaffolding that every program shares; the following
chapters describe the datasets, surfaces, communication, and utility
functions that go inside it.

The one header to rule them all
===============================

.. code-block:: c

   #include "mrilib.h"

``mrilib.h`` is the master header for the ``mri`` / ``THD`` (the "3D dataset")
world.  It transitively includes ``3ddata.h`` (dataset structures and the
hundreds of ``DSET_*`` / ``THD_*`` / ``EDIT_*`` declarations), ``mcw_malloc.h``,
the NIML headers, the vector/matrix helpers, and the error-message macros.
You rarely need to include anything else for a volume-processing program.  A
few common extras:

===========================  ==================================================
Header                       When you need it
===========================  ==================================================
``matrix.h``                 ``matrix`` / ``vector`` linear-algebra type
``editvol.h``                pulled in by ``mrilib.h``; ``EDIT_*`` dataset editing
``niml.h`` (via ``niml/``)   raw NIML I/O (already available through mrilib)
``suma_suma.h``              SUMA surface objects and surface datasets
===========================  ==================================================

The ``main()`` skeleton
========================

Here is the shape of ``main()`` shared by nearly every program, distilled from
:file:`src/3dToyProg.c`:

.. code-block:: c

   int main( int argc , char *argv[] )
   {
      THD_3dim_dataset *iset=NULL ;
      char *prefix = "toy" ;
      int iarg=1 ;

      mainENTRY("3dToyProg main"); machdep(); AFNI_logger("3dToyProg",argc,argv);

      /*-- parse options --*/
      while( iarg < argc && argv[iarg][0] == '-' ){
         CHECK_HELP(argv[iarg], help_3dToyProg);   /* handles -help/-h/-h_view... */

         if( strcmp(argv[iarg],"-input") == 0 ){
            if( ++iarg >= argc ) ERROR_exit("Need dset after -input") ;
            iset = THD_open_dataset( argv[iarg] ) ;
            if( iset == NULL ) ERROR_exit("Cannot open %s", argv[iarg]) ;
            DSET_mallocize(iset); DSET_load(iset);  /* read voxel data */
            iarg++ ; continue ;
         }

         if( strncmp(argv[iarg],"-prefix",6) == 0 ){
            if( ++iarg >= argc ) ERROR_exit("Need name after -prefix") ;
            prefix = argv[iarg] ; iarg++ ; continue ;
         }

         ERROR_message("ILLEGAL option: %s", argv[iarg]) ;
         suggest_best_prog_option(argv[0], argv[iarg]) ;   /* "did you mean...?" */
         exit(1) ;
      }

      if( argc < 2 ){ help_3dToyProg(TXT,0); exit(0); }  /* no args: print help */
      if( iset == NULL ) ERROR_exit("No input dataset!?") ;

      /* ... do work, build oset ... */

      tross_Copy_History( iset , oset ) ;                 /* provenance */
      tross_Make_History( "3dToyProg", argc, argv, oset ) ;
      DSET_write(oset) ;
      exit(0) ;
   }

The mandatory first line
------------------------

.. code-block:: c

   mainENTRY("3dProgName main"); machdep(); AFNI_logger("3dProgName",argc,argv);

* ``mainENTRY(name)`` sets up the AFNI call-stack traceback machinery and
  installs signal handlers so that a crash prints a readable stack instead of
  a bare segfault.  **All argument parsing must happen after** ``mainENTRY``,
  so that ``-h_view``, ``-h_web`` and friends work correctly (see
  :ref:`help_functions`).
* ``machdep()`` performs machine-dependent setup (byte-order, floating-point
  environment, etc.).
* ``AFNI_logger(name,argc,argv)`` records that the program was run (the
  ``~/.afni.log`` mechanism); harmless and conventional to include.

.. _wp_entry_return:

ENTRY / RETURN: the call-stack traceback
========================================

Throughout the AFNI source you will see functions that begin with ``ENTRY``
and leave through ``RETURN`` instead of the bare ``return``:

.. code-block:: c

   THD_3dim_dataset * New_Dataset_From_Scratch(char *prefix)
   {
      THD_3dim_dataset *oset=NULL ;
      ENTRY("New_Dataset_From_Scratch") ;    /* register this frame */
      ...
      RETURN(oset) ;                          /* pop frame + return value */
   }

* ``ENTRY("name")`` pushes the function name onto a debug stack.
* ``RETURN(value)`` pops it and returns ``value``.
* ``EXRETURN`` is the ``void`` form (pop and ``return;``).
* ``mainENTRY`` is the ``main()`` variant.

The payoff is that when something goes wrong, AFNI can print the whole chain
of functions that were active (``DBG_traceback`` / the ``-DAFNI_TRACE=y``
environment control).  Using them is optional for code that never fails, but
matching the surrounding style is strongly encouraged: if you ``ENTRY`` at the
top you must leave through ``RETURN``/``EXRETURN`` on **every** path, or the
stack gets out of sync.

Talking to the user: message macros
===================================

Do not call ``printf``/``fprintf(stderr,...)`` directly for status and errors.
AFNI has a standard family (declared in ``mrilib.h``) that adds the ``++`` /
``*+`` / ``**`` prefixes users recognize, honors quiet flags, and colorizes
terminals:

============================  =====================================================
Macro                         Meaning
============================  =====================================================
``INFO_message(fmt,...)``     informational (``++``), to stderr
``ININFO_message(fmt,...)``   continuation of a previous INFO line
``WARNING_message(fmt,...)``  warning (``*+``)
``ERROR_message(fmt,...)``    error (``**``) but keep running
``ERROR_exit(fmt,...)``       print error and ``exit(1)``  -- the usual fatal path
============================  =====================================================

Use ``ERROR_exit`` for fatal command-line problems (missing dataset, bad
option) and ``ERROR_message`` when you want to report but continue.  This is
exactly what :file:`src/3dToyProg.c` does when it fails to open the ``-mask``
or ``-input`` dataset.

Help, option-suggestion, and tab-completion
============================================

Two calls in the skeleton above give you AFNI's user-friendliness for free:

* ``CHECK_HELP(arg, help_func)`` intercepts ``-h``, ``-help``, ``-HELP``,
  ``-h_view``, ``-h_web``, ``-h_spx`` etc. and routes them to your help
  function.  **Do not** parse ``-help`` yourself.
* ``suggest_best_prog_option(argv[0], arg)`` prints a "did you mean ...?"
  suggestion when the user gives an unknown option.

Your help function has the prototype ``int help_prog(TFORM targ, int detail)``
and prints with ``sphinx_printf(targ, ...)`` so the same text can render as
plain text or as Sphinx for these web docs.  The full mechanics -- including
how to register your program's options in ``prog_opts.c`` for tab-completion
-- are documented in :ref:`help_functions`.  Program :file:`src/3dToyProg.c`
is the reference implementation.

Provenance: dataset history
===========================

Before writing any output dataset, stamp it so the analysis is reproducible:

.. code-block:: c

   tross_Copy_History( iset , oset ) ;                  /* carry input's log */
   tross_Make_History( "3dProgName", argc, argv, oset ) ;/* append this command */

``tross_Make_History`` records the exact command line into the dataset header;
``3dinfo -history`` will later show it.  Copying the input history first
preserves the full chain back to the raw data.  Every well-behaved AFNI
program does this (grep the tree for ``tross_Make_History`` -- it is nearly
universal).

Overwrite protection
====================

AFNI programs refuse to clobber an existing dataset unless the user passed
``-overwrite`` (or set ``AFNI_DECONFLICT``).  The idiom, straight from
:file:`src/3dToyProg.c`:

.. code-block:: c

   if( !THD_ok_overwrite() && THD_is_ondisk(DSET_HEADNAME(oset)) )
      ERROR_message("Output %s already exists", DSET_HEADNAME(oset)) ;
   else
      DSET_write(oset) ;

Building your program into AFNI
===============================

New programs are compiled by the ``src/Makefile`` machinery.  In practice:

* Add your ``prog.c`` and make sure it links against ``libmri.a`` (the library
  that contains all the ``THD_*`` / ``mri_*`` / ``EDIT_*`` / NIML code).  The
  ``Makefile.INCLUDE`` targets show the standard link line used by the
  ``3d*`` programs; copy an existing program's target as a template.
* For the CMake build, see :ref:`the CMake build docs <devdocs_cmake>`
  in the developer documentation.
* After adding or updating your ``-help`` output, regenerate the
  option-completion table as described in :ref:`prog_opts`::

     apsearch -C_prog_opt_array 3dProgName > prog_opts.c
     touch thd_getpathprogs.c
     make libmri.a gitignore

What to read next
=================

* :ref:`wp_datasets_volumes` -- the ``THD_3dim_dataset``, sub-bricks, brick
  factors, geometry, masks, and creating/writing volumes.
* :ref:`wp_surfaces` -- SUMA surface objects and surface-based datasets.
* :ref:`wp_communication` -- NIML, and the real-time / InstaCorr / GroupInCorr
  machinery for talking to the AFNI and SUMA GUIs.
* :ref:`wp_cookbook` -- a categorized reference of the functions you will reach
  for most: dataset I/O, time-series extraction, correlation, p-value
  conversion, and 1D I/O.
