.. _edu_shell_script:


**************************************
**Shell script and command line tips**
**************************************

.. highlight:: tcsh

.. contents:: :local:


Overview
========

This page contains a random assortment of useful tips and tricks for
shell scripting and command line usage.  It assumes that you are
comfortable with basic shell syntax and commands, such as with things
contained :ref:`in this Unix tutorial <U_all>`.

We expect this page to be broadly useful across **all** shell
usage. Many of the features presented are available in all shells
(such as using ``seq``, ``awk``, ``grep``, etc.).  Some features are
purely for ``tcsh`` shell---that just tends to be the shell we prefer
for our own scripting (mainly for readability).  But in such cases,
there might be equivalent features in ``bash`` or ``zsh`` to seek out
utilize, and learning about them here can be useful.  Some sections
describe both general shell functionality and tcsh-specific items.

If you have further suggestions or examples, please let us know and we
can add to the stash.

Some useful (outside) references for further shell and script learning
might be:

* `<https://en.wikibooks.org/wiki/C_Shell_Scripting>`_

* `<https://docstore.mik.ua/orelly/linux/lnut/ch08_09.htm>`_

The numbers in this section are not purposeful, and they might change
over time.  In general, we try to accummulate features downwards in
the listing: that is, some commands get used together, but we try to
assume that if you read the page from top to bottom (as you surely
will, right?) then topics should be sensical.

Here we go---*le deluge*\.\.\.

Know your shell type
=====================

To find out what kind of shell you have, type::

  echo $0

in a terminal and it should tell you something like ``tcsh``, ``csh``,
``bash``, ``zsh``, etc.  If there is a minus sign at the start of the
output, that just means it is your login shell.  

For most practical purposes here, ``tcsh`` and ``csh`` are treated as
the same.

If you want to change your shell to be, say, ``tcsh``, then you can
just type::

  tcsh

\.\.\. in the terminal.  That should switch you over to that format
for making/using variables, etc.  When you are done, you can type::

  exit

\.\.\. and leave that shell.

Make and run a shell script
==================================

To make a ``tcsh`` script, open a text file and make the first line
look like one of the following:

* ::

    #!/bin/tcsh

* ::

    #!/usr/bin/env tcsh

\.\.\. which is called a **shebang**.  There should be no spaces at
the start.  

After this line, you can put whatever commands you want for your
devious purposes.  For *most* considerations, spacing and indentation
does not matter within the script (of course, we will mention some
exceptions below; for example, when setting a variable one *needs*
spaces around the assignment operator ``=``).  However, it is a good
idea to indent your code consistently, to help yourself or other
people see where loops and conditionals end.

To run or execute the script, you can type::

  tcsh SCRIPTNAME

Note that ``SCRIPTNAME`` does not *need* to end with a ".tcsh"
extension, but it might help you stay organized and recognize your
script.  You can add a ``-e`` option when you run the script to have
it exit the first time a command in it fails::

  tcsh -e SCRIPTNAME

You can run a tcsh script in this way from *any* shell variety (tcsh,
zsh, bash, etc.).

Some further, convenient features:

* Scripts typically dump text in the terminal.  You might want to keep
  a copy or log of that for future reference, debugging or
  question-asking. You can do this as follows for a script called
  "SCRIPTNAME" and a logfile called "LOGNAME" (each of which can
  include path information, etc.):

  * \.\.\. from a ``bash`` shell, run the script as::

      tcsh SCRIPTNAME 2>&1 | tee LOGNAME

  * \.\.\. from a ``tcsh`` shell, run the script as::

      tcsh SCRIPTNAME |& tee LOGNAME

  You can also use this feature *within* a script, to send the
  terminal output of a particular program to a text file.

  **NB:** I can't stress enough how useful this feature is! You should
  *always, always, always* use it.  You're welcome.

* If you want to keep track of the amount of time something runs, you
  can start the command line with the Unix program ``time``.
  Consider either of the following::

    time tcsh SCRIPTNAME

    time tcsh SCRIPTNAME |& tee LOGNAME

  etc.



Check if a variable exists (tcsh)
==================================

To find out if a particular variable has been defined, use ``?`` as
``$?NAME`` or ``${?NAME}``.  The shell will return ``1`` if it has,
and ``0`` if it hasn't.  For example, I suspect this will return
``0`` on most systems::

   echo $?CALL_ME_ISHMAEL
   
This can be useful to check if variable name is free or not.  It
can also be useful in scripting in an if condition: if a variable
has been defined, then use that value; otherwise, define your own
value.  For example::

  if ( $?CALL_ME_ISHMAEL ) then
      echo "++ CALL_ME_ISHMAEL is already set to: $CALL_ME_ISHMAEL"
  else
      set CALL_ME_ISHMAEL = "Moby_01"
      echo "+* CALL_ME_ISHMAEL was undefined; it is now: $CALL_ME_ISHMAEL"
  endif
  

Store array in a variable (tcsh)
==================================

Shell variables can hold multiple values, acting as arrays.
Consider::

  set arr = ( alpha beta gamma delta epsilon zeta eta theta iota )

To find out the number of elements, use ``#`` as follows::

  echo "The number of elements in the array is:  ${#arr} (= $#arr)"

You can select the whole array by providing its name::

  echo $arr

You can select individual elements, which are indexed starting with
``1``, up to the number of elements:

  echo $arr[1]
  echo ${arr[3]}

You can select "slices" (or intervals), by placing boundaries in
square brackets and separating with a dash ``-``; note both
boundaries are included in the interval::

  echo ${arr[3-6]}    # out:  gamma delta epsilon zeta

You can leave off the start or stop of the boundary when specifying
a slice, and the default first or last element of the array,
respectively, will be used::

  echo ${arr[-6]}     # out: alpha beta gamma delta epsilon zeta
  echo ${arr[6-]}     # out: zeta eta theta iota
  echo ${arr[-]}      # out: alpha beta gamma delta epsilon zeta eta theta iota


Extract parts of filenames and/or paths (tcsh)
===============================================

There are common conventions on many operating systems: 

* Directory paths are separated by the ``/`` character (at least in
  Linux and Mac).  For example, someone's home directory might be:
  ``/home/alincoln``.

* Filenames use ``.`` as a character to two components: the "base
  name" (or "handle"), which tells about the specific file's
  identity; and the "extension", which tells about its general type
  (so you/your computer knows what program to use to open it).  The
  extension is placed at the end of the filename, and it is
  separated from the base by ".".  For example, in the file
  "assignment_v1.pdf", the extension is "pdf" and the base is
  "assignment_v1".  Note that in the file "assignment.v1.pdf", we
  can still recognize "pdf" as the extension and "assignment.v1".
  Using "." in the basename is fine: we treat the rightmost
  "."-separated part as the extension, and the rest is a basename.

The ``tcsh`` has useful modifiers to recognize these
features. These are applied as ``$var:MOD`` or ``${var:MOD}``,
where ``MOD`` can be:

* ``e`` : get file extension

* ``r`` : get path+basename (the "root"), or non-extension part

* ``h`` : get directory of path (the "head")

* ``t`` : get filename at the end of a path (the "tail")

So, ``e`` and ``r`` complement each other, as do ``h`` and ``t``.
And they can be applied multiple times, as well, as
``$var:MOD1:MOD2``, ``${var:MOD1:MOD2:MOD3}``, etc.  Consider the
following examples::

  set fff = /home/gtokeefe/Documents/painting.v1.pdf

  echo $fff:e    
  echo $fff:r
  echo $fff:h
  echo $fff:t

  echo $fff:h:t
  echo $fff:t:r
  echo $fff:e:e
  echo $fff:r:r

\.\.\. will output::

  pdf
  /home/gtokeefe/Documents/painting.v1
  /home/gtokeefe/Documents
  painting.v1.pdf

  Documents
  painting.v1
  # an empty string is returned in this case
  /home/gtokeefe/Documents/painting

Note that the last one (``echo $fff:r:r``) might not really be what
we want, since the ``v1`` is not really an extension to be
removed. The shell can't read our minds (yet!), so always check the
outputs as you go. 


Finding paths of programs (shell/tcsh)
=========================================

Get the full path for a program in your $PATH::

    which PROGRAM

You could store this in a variable with::

    set var = `which PROGRAM`

This could be useful if you want to get the directory location of a
program. Say you want the file containing your AFNI binaries: first
by finding the ``afni`` program, and then selecting the directory
containing it::

     set loc_afni = `which afni`
     set loc_abin = ${loc_afni:h}
     echo ${loc_afni}                # ex out: /home/mgandhi/abin/afni
     echo ${loc_abin}                # ex out: /home/mgandhi/abin


Make uniformly spaced numbers (shell/tcsh)
===========================================

Generate uniformly-spaced numbers with the ``seq`` command.  This
program requires either 1, 2 or 3 arguments after.  

Here are examples of each, where we name each argument by how it
will be interpreted, and describe its output (though there are no
commas in the actual output, just a list of numbers)::

  seq STOP               # out: 1, 2, 3, ..., STOP
  seq START STOP         # out: START, START+1, START+2, ..., STOP
  seq START STEP STOP    # out: START, START+1*STEP, START+2*STEP, ..., STOP

Note that the default ``START`` is 1, and ``STOP`` is included in
the interval (unlike, say, typical Python syntax of boundaries).
The ``STEP`` can be negative. 

Examples::

  seq 5               # out: 1 2 3 4 5
  seq -3 3            # out: -3 -2 -1 0 1 2 3
  seq 4 2 11          # out: 4 6 8 10
  seq 11 -3 -2        # out: 11 8 5 2 -1

Outputs can also be stored as an array in a shell variable::

  set var = `seq 4 2 11`

It can be useful to make a counter or iterator in a loop::

  foreach ii ( `seq 10` )
      echo "++ The counter is:  ${ii}"
  end

.. hidden-code-block:: none
   :starthidden: True
   :label: - show output y/n -

   ++ The counter is:  1
   ++ The counter is:  2
   ++ The counter is:  3
   ++ The counter is:  4
   ++ The counter is:  5
   ++ The counter is:  6
   ++ The counter is:  7
   ++ The counter is:  8
   ++ The counter is:  9
   ++ The counter is:  10

This can also combine usefully with arrays and using ``#`` to get
the number of elements in it.  Consider::

  set aaa = ( omega psi chi phi upsilon tau )

  foreach ii ( `seq ${#aaa}` )
      echo "++ The [$ii]th value is:  ${aaa[$ii]}"
  end

.. hidden-code-block:: none
   :starthidden: True
   :label: - show output y/n -

   ++ The [1]th value is:  omega
   ++ The [2]th value is:  psi
   ++ The [3]th value is:  chi
   ++ The [4]th value is:  phi
   ++ The [5]th value is:  upsilon
   ++ The [6]th value is:  tau


String-formatting with ``printf`` (shell/tcsh)
===============================================

The string formatting syntax is quite to that of C programs in
print statements (of which Python borrows most for its own
str.format() method).  You print a string, ``printf "...."``, and
for each value you want to insert into a string, you a percent
symbol and then a descriptor of the type:

* ``%d`` : integer-valued numbers

* ``%f`` : floating point numbers

* ``%g`` : scientific notation (``1.23e+15``, ``4.56e-12``, etc.)

* ``%G`` : scientific notation (``1.23E+15``, ``4.56E-12``, etc.)

* ``%s`` : strings

After listing your string with spaces created for values, you
specify the values to be inserted in the same order.  So, consider
the following::

  printf "%d %f %s" 10 100.1 banana   # out: 10 100.100000 banana


You can control lots of features for each entry.  We demonstrate some
of these for the "float" type, but relevant features apply to all
other types (the vertical line characters have no special meaning;
they are just there to show the boundaries around the space created
for the inserted value)::

  printf "|%12f|"    15.1     
  printf "|%-12f|"   15.1    
  printf "|%-12.3f|" 15.1  
  printf "|%12.5d|"  15     

.. hidden-code-block:: none
   :starthidden: True
   :label: - show output y/n -

   |   15.100000|    # (all) make 10 empty spaces, and put the value inside
   |15.100000   |    # (all) as above, and left justify the value inside
   |15.100      |    # (flt) as above, and specify 3 decimal places
   |       00015|    # (int) make 10 empty spaces, zeropad the number 
                     #       to 5 spaces, and put the value inside

Note that ``printf`` does *not* put a newline character ``\n`` at
the end of a line (``echo`` does), so you would have to do that
yourself::

  printf " %.5d %10.6f %-10s\n" 3 -21 banana 

\.\.\. which outputs::

  00003 -21.000000 banana

Consider the following example of generating zeropadded numbers,
for a filename::

  foreach ii ( `seq 10` )
     set jj    = `printf "%.3d" ${ii}`
     set fname = name_${jj}.txt
     printf "++ The [%3d ]th filename is:  %s\n" ${ii} ${fname}
  end

.. hidden-code-block:: none
   :starthidden: True
   :label: - show output y/n -

   ++ The [  1 ]th filename is:  name_001.txt
   ++ The [  2 ]th filename is:  name_002.txt
   ++ The [  3 ]th filename is:  name_003.txt
   ++ The [  4 ]th filename is:  name_004.txt
   ++ The [  5 ]th filename is:  name_005.txt
   ++ The [  6 ]th filename is:  name_006.txt
   ++ The [  7 ]th filename is:  name_007.txt
   ++ The [  8 ]th filename is:  name_008.txt
   ++ The [  9 ]th filename is:  name_009.txt
   ++ The [ 10 ]th filename is:  name_010.txt


Simple math operations (tcsh)
=========================================

You can do simple math operations like adding, subtracting,
multiplying and dividing integers with the ``@``
functionality. Consider::

  @  aa = 10 + 5
  @  bb = 10 - 5
  @  cc = 10 * 5
  @  dd = 10 / 5
  @  ee = 10 / 3

\.\.\. and echoing the outputs produces, respectively::

  15
  5
  50 
  2 
  3

Note how these are *only* integer operations---note what happens in
the case of ``$ee`` (no remainder).  This can also be useful for
incrementing in place::

  set vv = 1
  @   vv+= 1 
  echo $vv

\.\.\. which outputs ``2``.  One can also use ``-=``, ``*=`` and
``/=``.

This is useful, for example counting things in a loop::

  set count = 0

  set letters = ( a b c d e d A s a w e v s d c e w Q a )

  foreach ll ( ${letters} )
      if ( "${ll}" == "a" ) then
          @ count+= 1
      endif
  end

  echo "++ I found ${count} instances of 'a' in this set."

But for more complicated expressions or those involving decimals
(floating point numbers), we need something different---see the ``bc``
operation, below.

   
More general math operations, via ``bc`` (shell)
=================================================

*Go, Eagles!*

This program allows you to write an expression with some pretty
general functionality, and have it evaluated as a calculator (that
is what the "c" in ``bc`` stands for) would.  The general syntax we
will use this is: ``echo "MATH EXPRESSION" | bc``.  By default, the
expressions will be considered to be integer-based, but we can
specify a "scale" for the number of decimals to output. Consider
the following::

  echo "10 + 15" | bc    
  echo "10 / 15" | bc    
  echo "10. / 15" | bc    
  echo "scale = 5; 10. / 15" | bc    

\.\.\. which outputs::

  25
  0
  0
  .66666

Note how even using decimal points did nothing to change output type
(like they might in some programming languages), *without* the
``scale`` being set.  Note also how the scale *truncates* the output,
not *rounding* it: we would expect the last value to be ``.66667``,
typically.

You can save the output directly by using the fun backticks::

  set output1 = `echo "10. / 15" | bc`
  set output2 = `echo "scale = 5; 10. / 15" | bc`

etc.

There are lots of operators that can be included in the expression.
You can also use parentheses to control order of operations,
following usual math rules.  You can use variables inside the
expression. Some examples::

  set  mm = 18
  echo "5 % 3" | bc                       # calc remainder
  echo "${mm} % 3" | bc                   # calc remainder
  echo "2^5" | bc                         # calc power
  echo "scale = 4 ; (3.14^5) + 2" | bc    # calc power
  echo "scale = 3 ; sqrt( 35 )" | bc      # calc sq root

.. hidden-code-block:: none
   :starthidden: True
   :label: - show output y/n -

   2                     
   0                     
   32                    
   307.2447              
   5.916

You can also have comparative expressions, checking for equality
``==``, inequality ``!=``, greater than ``>``, less than or equal
``<=``, etc.  (Though note that checking for strict inequality of
floating point numbers is not advised!)  Boolean operators can be
used, as well: or ``||``, and ``&&``, not ``!``.  If a logical
expression evaluates to True, the output is 1; False outputs to 0.
Consider these examples::

   set val = 100

   echo "50 < ${val}" | bc
   echo "50 < ${val} && ${val} < 200" | bc
   echo "10^2 == ${val}" | bc
   echo "! $val % 7 || ! $val % 3" | bc

\.\.\. outputs::

   1               # 50 is less than 100
   1               # 50 is less than 100 AND 100 is less than 200
   1               # 10-squared is equal to 100
   0               # it is not true that: either 7 or 3 is a factor of 100

See the help ``man bc`` for more information.

Display blocks of text with ``cat << EOF ... EOF``
====================================================

You can ``echo`` or ``printf`` text line by line, which is often good
enough.  But what if you have a *block* of text?  You could just have
several ``echo`` commands::

  echo "# Program author:  A. Lovelace"
  echo "# Program version: G"
  echo "# Program date:    Aug 1, 1843"
  echo "" 
  echo ""
  echo "# Comment on line 1 ..."
  echo ""

This quickly becomes unwieldy.  A better way to go is to use the
following syntax of the ``cat`` program (no silly, feline puns allowed
here, unless the are about *fat*\ cats)::

  cat << EOF
  # Program author:  A. Lovelace
  # Program version: G
  # Program date:    Aug 1, 1843


  # Comment on line 1 ...

  EOF

Three things to note:  

* Spacing and empty line within the blocks are preserved, both at the
  start of lines and within lines.

* The ``EOF`` is just a commonly used syntax, and you could use
  another string there.  However, don't use something that might occur
  at the start of a line in that block of text.

* This is a case where spacing **does** matter.  The closing string
  ``EOF`` must occur at the start of the line.  It cannot be indented.
  Otherwise, the shell interpreter won't find the closing of the block.

You can include variables that have been defined outside the block in
the block, just by referring to them as usual::

  set N = 25

  cat << EOF

     echo "The value of N is: ${N}"

  EOF

You can redirect the block into a text file, as well.  This might be
useful if you are creating a script.  This is done as follows::

  set N = 25

  cat << EOF >> SOME_FILE

     echo "The value of N is: ${N}"

  EOF

This puts the three lines of text that appear in the block into
``SOME_FILE``; this was done in "append" mode, so the text file
just gets longer if text were there previously.  Changing ``>>
SOME_FILE`` to ``> SOME_FILE`` puts the operation in
"overwrite" mode, instead.

You can even define (or set) new variables inside the block of text.
This might occur if you are generating a script file in this way, for
example.  However, you will have to "escape" the usage of any of these
variables within the text block.  Consider the following::

  set N = 25

  cat << EOF > SOME_OTHER_FILE

     echo "The value of N is: ${N}"

     set Nsq = N * N

     The value of Nsq is: \${Nsq}


  EOF

After this, ``SOME_OTHER_FILE`` looks like the following::

   echo "The value of N is: 25"

   set Nsq = N * N

   The value of Nsq is: ${Nsq}

If we hadn't put a backslash ``\`` before the *usage* (not definition)
of ``$Nsq``, then we would have gotten an error.  Note that we only
did this with the variable set *inside* the block (``$Nsq``), not the
one set *outside* it (``$N``), because it was already evaluated before
getting to the block.

A final note: if you are going to dump in a shebang, you do *not* need
to escape the exclamation point in it.  Thus, the following would be
correct::

  set N = 25

  cat << EOF > SOME_LAST_FILE.tcsh
  #!/bin/tcsh

  echo "The value of N is: ${N}"

  set Nsq = N * N

  The value of Nsq is: \${Nsq}

  EOF

However, if you were using ``echo`` to dump a shebang into a file, you
*would* need to escape the exclamation point::

  echo "#!/bin/tcsh"   > BAD_SCRIPT.tcsh

  echo "#\!/bin/tcsh"  > GOOD_SCRIPT.tcsh

You can verify this in each case.


Replace chars in strings (e.g., rename files)
========================================================

Systematic renaming of files can be useful, such as replacing one set
of characters with another.  There can be some gotchas with this
(e.g., a shell "list" of file spaces might get interpreted as a longer
list of partial filenames, each original item split at the space).  We
examine a couple.  But typically I start programming these kinds of
things by just displaying the old and new names, rather than replacing
each, to be sure I have things correct.  I can always add a copy or
move afterwards, once I have the names I want in each variable.

There are a couple replacement options: within ``tcsh``, you can use
the ``:gas/AAA/BBB/`` syntax to replace "AAA" within a variable with
"BBB". For example::

  set iname  = "This is some exAAAmple for chAAAraaacter replAcement"
  set oname1 = "${iname:gas/AAA/BBB/}"
  
  echo "++ OLD: ${iname}"
  echo "++ NEW: ${oname1}"

This produces::

  ++ OLD: This is some exAAAmple for chAAAraaacter replAcement
  ++ NEW: This is some exBBBmple for chBBBraaacter replAcement

Note the case sensitivity in replacement of an entire string.

To remove a string, one just replaces with an empty string::

  set iname  = "This is some exAAAmple for chAAAraaacter replAcement"
  set oname2 = "${iname:gas/AAA//}"
  
  echo "++ OLD: ${iname}"
  echo "++ NEW: ${oname2}"

\.\.\. producing::

  ++ OLD: This is some exAAAmple for chAAAraaacter replAcement
  ++ NEW: This is some exmple for chraaacter replAcement

There is also the "translate" program ``tr`` on most Linux or Mac
systems.  You can use this in different ways, but piping the display
of a string through it is a fairly convenient ones for scripts.  The
following matches ``${oname1}`` above::

  set oname3 = `echo "${iname}" | tr 'AAA' 'BBB'`

One could replace spaces using either, for example with an
underscore::

  set oname4 = "${iname:gas/ /_/}"
  set oname5 = `echo "${iname}" | tr ' ' '_'`

  echo "${oname4}"
  echo "${oname5}"

\.\.\. equivalently producing::

  This_is_some_exAAAmple_for_chAAAraaacter_replAcement
  This_is_some_exAAAmple_for_chAAAraaacter_replAcement

We could loop over a set of strings and replace each one in any of the
above manners (below, we use ``tr``, but the ``:gas`` route works
equivalently).  One difficulty occurs if the filenames contains
spaces.  Consider a directory that contains 3 screenshots, named
``Screenshot 1.png``, ``Screenshot 2.png`` and ``Screenshot 3.png``.
If we make a variable to store their array of names, then loop over
that array to make new names with the annoying space replaced, such as
here::

  set all_files = ( Screen*png )
  
  foreach iname ( ${all_files} )
      set oname = `echo "${iname}" | tr ' ' '_'`
      echo "${iname} -> ${oname}"
  end

\.\.\. we don't get 3 lines output (one for each filename, which we
might expect), but instead get::

  Screenshot -> Screenshot
  1.png -> 1.png
  Screenshot -> Screenshot
  2.png -> 2.png
  Screenshot -> Screenshot
  3.png -> 3.png

That is, the spaces were used to split each filename into two strings
before we even got there (that is, the quotes around each name are not
passed along to keep the element as a single entity), and so we
couldn't do what we wanted.  Enclosing the ``${all_files}`` variable
in quotes in the for-loop line won't work: that will lead to the array
of separate items being treated like a single, giant string. However,
we can ask the shell to put a quote around each word, so that those
are not separated within the loop by putting ``:q`` as a modifier::

  set all_files = ( Screen*png )
  
  foreach iname ( ${all_files:q} )
      set oname = `echo "${iname}" | tr ' ' '_'`
      echo "${iname} -> ${oname}"
  end

\.\.\. producing the desired::

  Screenshot 1.png -> Screenshot_1.png
  Screenshot 2.png -> Screenshot_2.png
  Screenshot 3.png -> Screenshot_3.png

Another way around this is to do the following: don't make a separate
array that will get interpreted again.  Directly loop over the
filenames::

  foreach iname ( Screen*png )
      set oname = `echo "${iname}" | tr ' ' '_'`
      echo "${iname} -> ${oname}"
  end

That makes the same 3 renamings as immediately above.  Finally, one
could iterate over the number of elements in the array::

  set all_files = ( Screen*png )

  foreach ii ( `seq 1 1 ${#all_files}` )
      set iname = "${all_files[$ii]"
      set oname = `echo "${iname}" | tr ' ' '_'`
      echo "${iname} -> ${oname}"
  end
