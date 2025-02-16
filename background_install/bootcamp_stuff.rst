
.. _Bootcamping:

***********************
**Prep for Bootcamp**
***********************

#. **Get the most uptodate AFNI on your computer.**

   |

   + *IF you do not have AFNI installed on your computer system,* then
     please see the step-by-step instructions (which optionally
     include installing the Bootcamp data, so then you will be all
     set) here for operating systems like macOS, Windows (via WSL) and
     a myriad of Linux flavors like Ubuntu, Fedora, Red Hat, CentOS
     and Rocky: :ref:`Operating system selection page <install_page>`.

     Methods for checking/evaluating each setup are also described on
     those pages.  PLEASE make sure you have verified that all is well
     with AFNI on your computer.

     |

   + *IF you already have AFNI installed on your computer,* but you
     are not certain that it is the most up-to-date version, please do
     the following:

     1. Check your AFNI version number::

          afni -ver

        The major number is the year, and you can also compare this with
        the current release version that sits in the upper-left corner
        of this HTML documentation.

        |

     2. In most cases, you can run the following command to update your
        local AFNI version::

           @update.afni.binaries -d

     3. If that doesn't work, you might need to use `build_afni.py` to
        compile locally on your computer. Please see the
        :ref:`Installation instructions for your OS <install_page>`.

   |

   .. _install_bootcamp:

#. **Boot up.**

   *Each page of installation page for AFNI includes instructions on
   downloading+unpacking the AFNI Bootcamp data.  In case you did not
   follow those there, then we repeat them here.*

   .. include:: install_instructs/substep_bootcamp.rst

   |

#. **EVALUATE THE SETUP: an important and useful step in this
   process!**

   *Each page of installation page for AFNI includes instructions on
   running a script to evaluate the setup and comment on any necessary
   fixes.  In case you did not follow those there, then we repeat them
   here.*

   .. include:: install_instructs/substep_evaluate.rst
