.. _sphinx_docs_setup:

.. highlight:: Tcsh

********************************
Setup for building sphinx
********************************

.. contents:: :local:

**Writing: In progress**

This page describes the process of building the AFNI documentation on
your local machine, as well as on the server to push to The World.
This can be done on Linux and Mac systems.

The majority of the AFNI online documentation website (which you are
reading right now\.\.\.) is written using Sphinx.  As part of the
standard build process, some "helper" scripts are run, as well, which
are mainly written in Python. For example, these scripts parse all
current helpfiles in the AFNI binaries directory and make them
available :ref:`here <programs_main>`.  **NB:** For a full docs build,
it is assumed that you have AFNI correctly installed on your system.

Prepare to make Sphinx documentation on local OS
====================================================

#. **Install AFNI on your system.** The directory of AFNI binaries can
   be located anywhere on your system: the Sphinx docs use a ``which
   afni`` in the ``conf.py`` file to find it.  If you haven't already
   installed AFNI, see default installation instructions for various
   OSs :ref:`here <install_main>`.

   |

#. **Download the afni_docs repo.** You can clone the git repo, for
   example to your home directory::

     cd
     git clone https://github.com/afni/afni_doc

#. **Install necessary dependencies.** This can be done with Conda,
   using an included ``environment.yml`` file:

   * Install+setup Conda, e.g., see :ref:`install_miniconda` (note the
     :ref:`quick setup section <install_miniconda_quick>` there).

     |

   * Use the afni_doc's ``*.yml`` file to create an environment with
     all Python-and Sphinx-related dependencies for building::

       cd ~/afni_doc
       conda env create -f environment.yml

     |

   You can set this environment as default, or just switch to it when
   you want to build the Sphinx documentation.

Make Sphinx documentation on local OS
====================================================

#. **Activate the necessary Conda environment**::

     conda activate sphinxdocs

#. **(optional, but recommended) Copy repo files outside git
   directory.** I prefer *not* to build in my git repo.  Therefore, I
   first rsync the repo (without the git stuff) somewhere else, before
   building::

     cd
     rsync -av --exclude=".*" ~/afni_doc/ ~/afni_doc_build

     cd ~/afni_doc_build

#. **Build docs.** There is a ``do_*`` script for building the
   documentation, including running several "helper" scripts (mostly
   Python).  You can choose to build the SUMA docs from scratch (which
   will open+drive SUMA a bit), though most documentation building
   doesn't need that.  There are also options for pushing the docs to
   The World, but that is typically only done on the server::

     tcsh do_doc_build_and_copy.tcsh -build

#. **View docs.** Open the created ``index.html`` file with a specific
   browser, such as Firefox, or let AFNI choose one::

     firefox _build/html/index.html

     afni_open -b _build/html/index.html


Useful links
===================

There are several useful webpages for information about building Sphinx
documentation.

| The AFNI documentation repository is open source and publicly
  available here: 
| `<https://github.com/afni/afni_doc>`_

|

| Help with sphinx: details directives (lists, tables, inserting
  figures, etc.)
| `<https://docutils.sourceforge.io/docs/ref/rst/directives.html>`_

|

| Help with sphinx: general reference notes/building:
| `<https://www.sphinx-doc.org/en/master/contents.html>`_
| `<https://www.sphinx-doc.org/en/master/usage/index.html>`_

|

| Sphinx "Cloud" theme docs (this theme is the starting point of
  documentation, but with an increasing number of style tweaks added
  on top):
| `<https://cloud-sptheme.readthedocs.io/en/latest/cloud_theme.html>`_

|

| "Hidden code blocks" extension (thanks, A. Scopatz!), which is used
  occasionally within these docs:
| `<http://scopatz.github.io/hiddencode/#>`_

