# afni_doc
Documentation for the AFNI package (mainly RST to build HTML docs)

## Building docs locally

See here for notes about setting up your OS to build the documentation on a local machine:

https://afni.nimh.nih.gov/pub/dist/doc/htmldoc/devdocs/build_sphinx/main_toc.html

As described on that webpage, there is an ``environment.yml`` file distributed in this 
repo that should contain all the additional dependencies for your OS (beyond having AFNI 
installed and the ``afni_doc`` repo downloaded).  That ``*.yml`` file can be used to create
a conda environment directly, and then you are all set;  alternatively, you can install those same
dependencies with a package manager and ``pip``, if you prefer.

## Building docs for The World

Run the ``distall_DOC`` script on the server/build machine.
