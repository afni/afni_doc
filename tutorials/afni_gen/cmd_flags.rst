

.. _tut_afni_gen_flags:

*************************************
General options for AFNI programs
*************************************

.. contents:: :local:

.. highlight:: Tcsh

Overview and note on default settings
===================================================

The following is a description of some generally applicable options
when running AFNI programs.  Each should be applicable in most AFNI
program.

As part of the default AFNI setup, you (are supposed to) generate the
file of default environment variables (envs) for AFNI.  This file is
called ``~/.afnirc``, meaning that it lives in your home directory,
and is "hidden" in the sense that it is not shown with a default
``ls`` (because of the ``.`` at the start of its name).  See if
``\ls -a ~/.afnirc`` shows the name of a file for you.  If not, run
``afni_system_check.py -check_all``, and follow the copy+paste
instruction at the bottom to generate the default one.

The page listing all AFNI environment variables and their descriptions
is here: :ref:`AFNI environment variables <edu_env_vars>`.

Whenever you run an AFNI program, the ``~/.afnirc`` file of
environment variables gets sourced.  So, if you want to change
behavior of something in a semi-static way, set the environment
variable there.

You can also set environment variables in scripts you write.  This is
a more "task-specific" way of setting behavior.

The first section here will show you how to set an env via an option
for that command.  This setting only has effect for the duration of
that command's execution.  


Environment variables per-command:  ``-Dname=val``
===================================================

You can set an environment variable to be used just for a particular
program call by adding an option with the syntax ``-Dname=val``, where
'name' is an environment variable, and 'val' is the value you want it
to take.

For example, the following sets the line width to a desired value and
green color (ignoring whatever the default in ``~/.afnirc`` is)::

  1dplot                                 \
      -DAFNI_1DPLOT_COLOR_01=rgbi:0/1/0  \
      -DAFNI_1DPLOT_THIK=.04             \
      '1D: 3 4 5 3 2 1'

This is quite general.  You can use this with the AFNI gui, say
``afni -Dname=val``, etc.  Enjoy the freedom!

Checking environment variable settings:  ``afni -Vname=``
============================================================

As noted above, you *should* have default environment variables
set. And hopefully you have altered them to your heart's content.  

To find out what an environment variable is set to, you could open up
the ``~/.afnirc`` file.  But you might change things in a script or
just hate opening text files.  To find out the current value of an
environment variable ``name`` from the command line, you can run the
main ``afni`` program with the following option specification::

  afni -Vname=

Yes, the actual variable name needs to be sandwiched between ``V`` and
``=``.  So, for example, to check out the default thickness of lines
drawn in the 1dplot-style windows, you could run::

  afni -VAFNI_1DPLOT_THIK=

There might be some other text displayed at the same time, so you
might turn on quiet mode and the ``-no_detach`` option for just
getting the specific output::

  afni -q -no_detach -VAFNI_1DPLOT_THIK=

Overwriting: ``-overwrite``
===================================

Most AFNI programs will not destroy existing datasets.  Including this
option tells them that it is OK to write over an existing dataset file
if necessary.

For example::

  3dcalc                        \
      -a DSET                   \
      -expr 'a**2'              \
      -prefix OUTPUT            \
      -overwrite

\.\.\. will write OUTPUT whether there was a pre-existing dset there
or not.

Ignore the default env vars: ``-skip_afnirc``
==============================================================

Including this option leads to skipping the processing of your
``~/.afnirc`` file.  That file, if present, is be used to set
environment variables to affect AFNI programs; so, this basically
ignores any of those defaults.

Consider this::

  1dplot                                 \
      -skip_afnirc                       \
      '1D: 3 4 5 3 2 1'

\.\.\. which would skip any color/line thickness/etc. settings in your
``~/.afnirc`` file.

Sometimes you might want to run an AFNI program and not have your
settings applied; this option provides an easy way to skip such
settings.

Program help: ``-hview`` (and other opts)
==============================================================

If you type the name of an AFNI program in the terminal and hit Enter
(with *no* options), the help should be displayed in the terminal.  

Similarly, most programs also have the simple option ``-help`` or
``-h`` to display the help in the terminal (a few programs actually
*require* such an explicit plea for help).

If you want, you can redirect the help into a file, such as with::

  1dplot > file1.txt

  1dplot -help > file2.txt

You can then open it in a text editor, or email it as a special
Valentine's Day card.

My favorite way to view the help, though, is to have it open in a text
editor directly, using the ``-hview`` option::

  1dplot -hview

Your text editor automatically moves the background, too, so you can
keep typing.  You can set the text editor being used with the
``AFNI_GUI_EDITOR`` environment variable (e.g., in your ``~/.afnirc``
file).  For example, I have the following line in my settings file::

  AFNI_GUI_EDITOR = /usr/bin/emacs

Yaaaaaay, ``emacs``!  But whatever you choose is up to you (default on
Linux is probably ``gedit``;  whooooo knows what Mac chooses?).

