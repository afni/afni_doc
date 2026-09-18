:tocdepth: 2

.. _writing_programs_main:

########################################
So You Want to Write an AFNI Program
########################################

A developer's handbook for writing new C programs against AFNI's libraries.

This section is written for someone who has cloned the AFNI source tree, can
build it, and now wants to add a new command-line program (or hack on an
existing one) using the same datasets, I/O routines, statistics, and
communication machinery that the rest of AFNI uses.  The emphasis throughout
is on the **existing** API: nearly everything you need already has a function,
a macro, or a whole subsystem written for it, and dozens of shipped programs
show you how it is meant to be called.  Wherever a topic is introduced, we
point at real programs in ``src/`` that use the same calls so you can read a
complete, working example.

The spine of this handbook is :file:`src/3dToyProg.c`, a deliberately
over-commented demonstration program that creates a dataset from scratch,
reads one from disk, walks its coordinate system, and does both volume-wise
and voxel-wise computations.  Read it alongside these pages.

.. toctree::
   :maxdepth: 2

   intro
   datasets_volumes
   surfaces
   communication
   cookbook

.. note::

   This handbook documents C-language internals.  For how to write and format
   the ``-help`` output of a program (so it shows up correctly on the web
   docs and supports tab-completion), see :ref:`help_functions`.  For how to
   get your work merged, see the pull-request walkthrough in the developer
   docs.
