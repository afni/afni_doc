.. _apqc_browsing:

Browsing APQC outputs
=========================================

.. contents:: :local:

.. highlight:: Tcsh

Overview
------------------------

It may be that you would like to open up one (or more) subject's
APQC-HTML files and jump to a certain block or image.  What wizardry
can accomplish this goal?  That is the topic of this page.

IDs in the HTML page
---------------------------------------

Basically, most elements or objects in an HTML page can have an tag or
"ID" attached to it.  Using that ID within your browser's address bar,
you can jump to that location in the page.

For files on your computer, the address bar just contains the full
path of that file, starting with ``file://`` (in place of ``http://``
or ``https://``, which would be used for content on non-local
servers).  That instructs the browser to load that specific file
(usually an HTML-formatted one, ending with the extension ``.html``).
For example, the following could be the address bar for the
QC-directory's ``index.html`` file for a subject:

.. code-block:: none

   file:///data/cereal_study/sub-001/sub-001.results/QC_sub-001/index.html

That will typically load a file in the browser at the top of the page.

You can then specify a place to jump within that page by including the
element's ID in the address bar, separated by a hash symbol ``#`` from
the file name.  For example:

.. code-block:: none

   file:///data/cereal_study/sub-001/sub-001.results/QC_sub-001/index.html#id_of_interest

Now the question becomes: *how do you discover the key to this puzzle,
the element's ID?*

**Answer:** mostly, in one of two ways:

#. Each QC block's label is also that block's HTML page ID.  So, you
   could use:

   .. code-block:: none

      file:///data/cereal_study/sub-001/sub-001.results/QC_sub-001/index.html#ve2a

   or

   .. code-block:: none

      file:///data/cereal_study/sub-001/sub-001.results/QC_sub-001/index.html#mot

   etc. to jump to the top of the given block.


#. Check this list of QC block labels and images/text sections (which
   hopefully is kept uptodate\.\.\.).  The QC block IDs and individual
   image/text IDs are delimited slightly by column.

   .. list-table:: Table of most QC-block and item IDs
      :header-rows: 1
      :widths: 15 15 45

      * - Block ID
        - Item ID
        - (*item type*) title string
      * - **vorig**
        -
        - Check: vols in orig space
      * - 
        - **EPI**
        - (*image*) EPI in original space
      * - 
        - **anat**
        - (*image*) Anatomical in original space
      * - **ve2a**
        -
        - (*image*) Check: vol alignment (EPI-anat)
      * - 
        - **epi2anat**
        - (*image*) ulay: \.\.\., olay: \.\.\.
      * - **va2t**
        -
        - Check: vol alignment (anat-template)
      * - 
        - **anat2temp**
        - (*image*) ulay: \.\.\., olay: \.\.\.
      * - **vstat**
        -
        - Check: statistics vols
      * - 
        - **fstat**
        - (*image*) olay: \.\.\.
      * - **mot**
        -
        - Check: motion and outliers
      * - 
        - **enormoutlr**
        - (*image*) Motion Euclidean norm (enorm) and outlier fraction
      * - 
        - **VR6**
        - (*image*) 6 volume registration motion parameters
      * - **regr**
        -
        - Check: regressors (combined and individual)
      * - 
        - **stims**
        - (*image*) regressors of interest \.\.\.
      * - 
        - **df**
        - (*text*) Summary of degrees of freedom (DF) usage
      * - 
        - **grayplot**
        - (*image*) Grayplot ('-peelorder') of residuals dset
      * - **warns**
        -
        - Check: all warnings from processing 
      * - 
        - **xmat**
        - (*text*) regression matrix correlation warnings
      * - 
        - **press**
        - (*text*) pre-steady state warnings
      * - 
        - **TENT**
        - (*text*) TENT warnings from timing_tool.py
      * - **qsumm**
        -
        - Check: summary quantities from @ss_review_basic
      * - 
        - **ssrev**
        - (*text*) basic summary quantities from processing



Command line examples to view HTML output
--------------------------------------------

Firstly, when modern ``afni_proc.py`` finishes, it will show users the
``@ss_review_basic`` output per usual, but then also (hopefully) note
that the APQC HTML finished building successfully.  It will directly
prompt you with a command to open+view that hot-off-the-press file,
namely with something like::

   afni_open -b sub-001.results/QC_sub-001/index.html

*Boom!* The ``afni_open -b`` means that the following HTML file will
be opened in your default browser.  

You can also specify your own browser.  For example, using ``firefox``
and utilizing either the absolute or relative path your QC-directory's
``index.html`` file, respectively::

  firefox /data/cereal_study/sub-001/sub-001.results/QC_sub-001/index.html

  firefox sub-001.results/QC_sub-001/index.html

You can explicitly instruct firefox to open the file in either a new
browser window or tab with the following (respectively)::

  firefox -new-window sub-001.results/QC_sub-001/index.html

  firefox -new-tab sub-001.results/QC_sub-001/index.html


To jump to a certain location in the page, you can include that in the
command line call directly, by including the desired element's ID and
the hash symbol::

  firefox sub-001.results/QC_sub-001/index.html#vstat

  firefox sub-001.results/QC_sub-001/index.html#enormoutlr

etc.

Any combination of the above (with/without ID hash, absolute/relative
path, and ``-new-window``/``-new-tab``/blank) can be used.


Using a script to load many APQC-HTML files
------------------------------------------------

If you have several subjects that you have processed, you might want
to view them all together quickly. In particular, you might want to:

* open several subjects' APQC HTML files;

* have those files be in their own cluster of browser tabs so that you
  can use the Tab and ctrl+Tab keys too circulate through them
  forwards and backwards, respectively;

* jump to a certain QC-block or QC-item for each HTML file, to be able
  to flip through the same image(s) easily.

This set of action items can be accomplished with the following
scripts.

#. **Ex. 1.**

   Jump to a particular QC block for all subjects.

   .. code-block:: Tcsh
      :linenos:

      #!/bin/tcsh

      # Construct a list of all subjects to view
      set all_files = `\ls sub*/*.results/QC_*/index.html`

      # Loop over all the subjects in the list
      foreach ii ( `seq 1 1 $#all_files` )

          set ff = ${all_files[$ii]}
          echo "++ Opening: $ff"

          # Open the first HTML a new window, the rest in a new tab
          if ( $ii == 1 ) then
              firefox -new-window ${ff}\#vstat
          else 
              firefox -new-tab    ${ff}\#vstat
          endif

      end


#. **Ex. 2.**

   Jump to a particular QC item for all subjects (identical to the
   previous example, just a different ID used after the ``#``).

   .. code-block:: Tcsh
      :linenos:

      #!/bin/tcsh

      # Construct a list of all subjects to view
      set all_files = `\ls sub*/*.results/QC_*/index.html`

      # Loop over all the subjects in the list
      foreach ii ( `seq 1 1 $#all_files` )

          set ff = ${all_files[$ii]}
          echo "++ Opening: $ff"

          # Open the first HTML a new window, the rest in a new tab
          if ( $ii == 1 ) then
              firefox -new-window ${ff}\#enormoutlr
          else 
              firefox -new-tab    ${ff}\#enormoutlr
          endif

      end

Closing browser tabs
-----------------------------

Because information can be saved for each tab/index.html file (e.g.,
comments and ratings), there is a little bit of standard browser
security in place so that changes might not get inadvertently lost.
Sometimes, this might be helpful, while at other times, annoyanceful.
We propose approaches to reduce the latter and increase convenience
(hopefully).

.. note:: NB: the suggestions provided here refer to using a modern
          ``firefox`` browser (~63-5), where most of this has been
          tested.  I don't know if this behavior changes much over
          time or across browsers.  Please be aware of your own
          browser's behavior and/or quirks in order to prevent loss of
          work.

If you open+view a QC HTML page and then try to close it, you will
likely get this message (along with a couple buttons):
  *This page is asking you to confirm that you want to leave - data
  you have entered may not be saved.*

As noted above, this feature is to prevent loss of any
entered-but-not-saved information in the QC buttons of the page (at
present, even if there is no information entered-- sorry!).  If you
have a lot of tabs open, this can be a bit annoying, moving a mouse
back and forth.

However, in reality, you don't have to move your mouse around to
verify that you want to close the tab.  That would be highly
inefficient and unfortunate.  Instead, you can proceed as follows:

* If you are clicking the 'x' on the tab to close it, just click that
  again, and the tab should close.

* If you are using a keyboard shortcut to close the tab (mine is
  ``ctrl+w``), then just type that same shortcut again, and the tab
  should close.


Some comments on browsing
-----------------------------

You, Dear Reader, might want to know, *How many of these browser tabs
could/should be opened at one time before causing computational woe?*

**Answer:** The author of this webpage doesn't know.

Said author has personally used this for 108 subjects in a group, with
two sets of tabs open (i.e., 216 of the APQC HTML documents open),
while also having a fair number of other firefox tabs open. This
amount did not crash or really even slow down the desktop used for
this task. However, an exact maximum is probably unascertainable
(until that subtly unhappy point when aaallll memory is used up on a
computer) and surely varies per machine.  So, as ever, *caveat
browsor!*

**To select subsets of a group,** one can use useful shell command
line tricks.  For example, let's say that the subjects are named in
the following style: sub-001, sub-002, sub-003, ... sub-999. One could
glob over a subset of subjects, say the first 99, by replacing line 4
in one of the examples above with::

  set all_files = `ls sub-0*/*.results/QC_*/index.html`

Or, one could get subjects 120-149, inclusively, with::

  set all_files = `ls sub-1[2-4]*/*.results/QC_*/index.html`

And there are surely other such "tricks", too, but I don't want to rob
you of the pleasure of finding them.

.. _apqc_browsing_newtab: 

Opening images in a new tab
----------------------------------

Each individual image can be opened in a separate tab (for example, to
zoom in a bit, potentially).  Users can either:

* right-click on an image and select "Open Link in New Tab", or

* middle-click on the image.

If you just left-click on the image, it would try to open in the
current tab, thereby leaving that page.

**Bonus fun fact:** the file name of each image contains the HTML
page's ID for jumping to that location. So, if you ever forget that ID
while offline or something, you can open the image in a new tab (as
learnt above), and check out the file name at the end of the web
address.  Take the last part of the filename between the last
underscore ``_`` and extension ``.jpg``, and there you have it!

For example, if the image's address in the new tab is

.. code-block:: none

   file:///data/cereal_study/sub-001/sub-001.results/QC_sub-001/media/qc_05_mot_enormoutlr.jpg

we would see that the image's file name is
``qc_05_mot_enormoutlr.jpg``, and therefore its ID would be
"enormoutlr".
