
AFNI has a small number Python requirements, like Numpy, Matplotlib,
flask and flask_cors.

You can use any method to install+manage Python and its dependencies.
In fact, your OS might have all the Python+modules needed to run AFNI
already.  Check this by running::

  afni_system_check.py -check_all

\.\.\. and check for any notes in the "Please fix" section at the
end. If there are none about Python, then you are all set!

But if you still need to install some Python modules, you might
consider using `Miniconda
<https://docs.conda.io/en/latest/miniconda.html>`_.  It is a
convenient, cross-platform way to setup Python (and other packages)
and manage environments. If you want to use it or learn more, check
out this tutorial for both quick and detailed instructions.  We have
tutorial notes :ref:`here <install_miniconda>` for both installing
Miniconda and using it to get the necessary Python libraries for AFNI.

