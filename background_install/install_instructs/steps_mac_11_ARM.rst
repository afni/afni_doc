
.. _install_steps_mac_11_ARM:

**Mac OS 11, ARM architecture** *(via command line)*
=========================================================

.. contents:: The essential system setup
   :local:

.. highlight:: none

What to do?
-----------

These setup instructions are for **Mac OS versions 11-12 with ARM
architecture**.

.. include:: substep_intro.rst

#. To open a text file, you can type ``open -t FILENAME``.  For
   example, to open the bash "rc" file::

     open -t ~/.bashrc 

Setup terminal
--------------

.. include:: substep_mac_setup_term.rst

Install Xcode and XQuartz
-------------------------

.. include:: substep_mac_11_xcode_xquartz.rst

Terminal security preferences
---------------------------------

.. include:: substep_mac_11_term_sec.rst

Install Homebrew+packages
---------------------------------

.. include:: substep_mac_11_homebrew.rst

Install R
---------

.. include:: substep_mac_R.rst

Update/create symbolic links
-----------------------------

**Revisit this**

These links all existed already on my computer::

  ln -s /opt/homebrew/Cellar/gsl/2.7.1/lib/libgsl.dylib                  \
        /opt/homebrew/lib/libgsl.dylib  
  ln -s /opt/homebrew/Cellar/openmotif/2.3.8_1/lib/libXm.4.dylib         \
        /opt/homebrew/lib/libXm.4.dylib

  # if XQuartz doesn't include libXm (as it used to), then use this:
  ln -s /opt/homebrew/Cellar/openmotif/2.3.8_1/lib/libXm.a               \
        /opt/homebrew/lib/libXm.a
  ln -s /opt/homebrew/Cellar/jpeg/9e/lib/libjpeg.a                       \
        /opt/homebrew/lib/libjpeg.a

Copy+paste these::

  ln -s /opt/homebrew/Cellar/jpeg/9e/lib/libjpeg.a                       \
        /opt/homebrew/lib/libjpeg.9.a
  ln -s /opt/homebrew/Cellar/netpbm/10.86.18/include/netpbm/pgm.h        \
        /opt/homebrew/include/pgm.h



Compile AFNI binaries
---------------------

**Revisit this**

* | have to download the code (and copy it? or just build in it?)
  | **need to provide specific command**

* | cd into the src directory 
  | **need to provide specific command**

* Copy+paste (**Question:** should the string 'ARM' be included in the
  ``Makefile.macos_11_clang`` filename?  the names below are messy and
  do not match: Makefile.macos_11_clang, macos_11.5_ARM_M1_clang,
  make_mac11_ARM_clang.  We can/should make the string more
  consistent, such as always have 'macos_11_ARM_clang' be used in
  each)::

    cp Makefile.macos_11_clang Makefile

  Note either clang or gcc10, gcc11 or later should all work
  (**Question:** for whom is this note? I don't see any other
  Makefiles with those names of other compilers)

* Copy+paste::

    bash -c "make vastness 2>&1 | tee log_make_mac11_ARM_clang.txt"


* (**Question:** how do we want users to do the following
  verification?) make sure the installation all worked okay, and there
  are no missing programs, usually because of missing dependencies

* copy installation directory to standardish afni binary directory::

    mkdir -P ~/abin
    cp -rp macos_11.5_ARM_M1_clang/* ~/abin/.

* get atlases and templates.  Copy+paste::

    cd
    curl -O https://afni.nimh.nih.gov/pub/dist/atlases/afni_atlases_dist.tgz
    tar xvf afni_atlases_dist.tgz

* (**Question:** how should we be more specific here?) either put the
  atlases in the abin directory with the executables or set the
  ``AFNI_ATLAS_PATH` to include the afni_atlases_dist directory::

    cp afni_atlases_dist/* ~/abin/.




Setup Mac env variables
-------------------------

.. include:: substep_mac_env.rst


Reboot
------

.. include:: substep_mac_reboot.rst


Install Netpbm
--------------

.. include:: substep_mac_netpbm.rst

.. ---------- HERE/BELOW: copy for all installs --------------

Setup Python (opt)
---------------------------------

.. include:: substep_miniconda.rst

Prepare for Bootcamp
------------------------------------

.. include:: substep_bootcamp.rst

Evaluate setup/system (**important!**)
-----------------------------------------

.. include:: substep_evaluate.rst

Niceify terminal (optional, but goood)
--------------------------------------

.. include:: substep_rcfiles_mac.rst

Install extras (optional, but recommended for Bootcamp prep)
-----------------------------------------------------------------

.. include:: substep_extra_packs.rst

Keep up-to-date (remember!)
---------------------------

.. include:: substep_update.rst

Enable more SUMA keypresses (recommended)
----------------------------------------------------------

.. include:: substep_mac_keyshortcuts.rst





.. NO LONGER RECOMMEND PyQt4 STUFF

   Install PyQt4, via JDK and fink (optional)
   ------------------------------------------

   **Note:** at present, this step is only necessary if you want to have
   some of the Python-based GUI programs in AFNI.  However, we don't
   really use these much, and certainly if you are here for
   ``uber_subject.py``, we would **strongly** recommend that you just
   build an ``afni_proc.py`` command from existing examples in the
   :ref:`afni_proc.py help <ahelp_afni_proc.py>`, instead!

   1. | Click on this link: http://www.oracle.com/technetwork/java/javase/downloads
      | and then click on the ``Java`` icon.

      **Purpose:** Install Java SE (standard edition) JDK.

   #. Copy+paste::

        curl -O https://afni.nimh.nih.gov/pub/dist/bin/misc/save/install.fink.bash
        bash install.fink.bash

      **Purpose:** This runs an install script to download+install the
      package manager ``fink``.  

      This takes perhaps 30 minutes to finish **and** the user gets asked
      many questions (sorry, no way around it).  One can simply keep
      hitting the ``ENTER`` key to accept the useful defaults (**note:**
      you can respond with 'n' for the Xcode installation prompt if
      prompted otherwise, as you should have it from an earlier step).

   #. Do each of the following (installs PyQt4):

      i. Open a new terminal window.

      #. Copy+paste::

           fink --version

      #. If no errors, copy+paste::

           sudo fink install pyqt4-mac-py27

      #. Copy+paste::

           sudo ln -s /sw/bin/python2.7 /sw/bin/python
           echo 'setenv PYTHONPATH /sw/lib/qt4-mac/lib/python2.7/site-packages' >> ~/.cshrc

   #. To test your PyQt4, copy+paste::

        uber_subject.py

      Does a GUI open?  Or is there a crash??

      |


