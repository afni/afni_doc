.. _class_handouts:

************************************
**AFNI Bootcamp handouts**
************************************

.. contents:: :local:

Download all AFNI handouts
===========================

A lot of material about using the AFNI software toolbox are kept
locked in the secret afni_handouts vaults.  Now, for the first time in
history, they are also available from this webpage!  

1. **To download** the handouts directory, do any of the following:

   * *(Fastest!)* Copy+paste to a terminal::

       afni_open -aw afni_handouts.tgz

   * Click this download link: `(current) AFNI handouts directory <https://afni.nimh.nih.gov/pub/dist/edu/data/CD/afni_handouts.tgz>`_

   * Copy+paste to a terminal::

       curl -O https://afni.nimh.nih.gov/pub/dist/edu/data/CD/afni_handouts.tgz

   * Copy+paste to a terminal::

       wget https://afni.nimh.nih.gov/pub/dist/edu/data/CD/afni_handouts.tgz
       
#. **To open+unpack** the directory, copy+paste this to a terminal::

     tar -xvf afni_handouts.tgz

   \.\.\. which should produce a directory called "afni_handouts/" in
   that location.

.. note:: If you are preparing to attend an AFNI Bootcamp, know that
          this afni_handouts directory is also part of the Bootcamp
          data download.  You can download the whole Bootcamp data
          directory from :ref:`here <install_bootcamp>`, or you can do
          it as part of setting up AFNI on your computer, following
          instructions for your particular operating system
          :ref:`listed here <install_page>`).

Download specific AFNI handout(s)
==================================

If you would like to get just an *individual* handout or two from the
directory, you can do that in a straightforward manner. The following
command will download the particular file to your current location,
and open it using an application on your computer.

Copy+paste::

  afni_open -aw FILE_NAME

where ``FILE_NAME`` can be any file in the currently available
afni_handouts directory, listed in the following table. 

.. include:: media/afni_handouts_list.rst
