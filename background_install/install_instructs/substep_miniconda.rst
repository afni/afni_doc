
AFNI has *very* minimal Python requirements---at present, matplotlib
and numpy. For example, for the :ref:`recommended automatic QC output
from afni_proc.py <tut_apqc_help>`, matplotlib is necessary.

You can use any method to install+manage Python and its dependencies.
In fact, your OS might have all the Python+modules needed to run AFNI
already.  Check this by running::

  afni_system_check.py -check_all

\.\.\. and seeing there are no notes in the "Please fix" section at the
end---if there are none about Python, then you are all set!

But if you do still need to setup Python with appropriate modules, or
you want to manage different environments with different package needs
(Python or otherwise), then we note that we have found `Miniconda
<https://docs.conda.io/en/latest/miniconda.html>`_ to be convenient.
It is cross-platform (with occasional OS-specific quirks).  **If** you
are interested in either using it or reading more about it, you can
check out :ref:`this tutorial <install_miniconda>`, which has both
:ref:`verbose <install_miniconda_verbose>` and :ref:`quick
<install_miniconda_quick>` instructions.

But Miniconda is *not* required.
