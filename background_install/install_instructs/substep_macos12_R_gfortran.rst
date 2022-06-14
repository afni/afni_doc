
#. **Get R v3.6.3 gfortran v6.1**::
    
     cd
     curl -s -L -o R-3.6.3.nn.pkg "https://cran.r-project.org/bin/macosx/el-capitan/base/R-3.6.3.nn.pkg"
     curl -s -L -o gfortran-6.1.pkg "https://cloud.r-project.org/bin/macosx/tools/gfortran-6.1.pkg"

#. **Install R**::

     sudo installer -pkg R-3.6.3.nn.pkg -target /

#. **Install gfortran**::

     sudo installer -pkg gfortran-6.1.pkg -target /

#. **Cleanup**::

     \rm gfortran-6.1.pkg
     \rm R-3.6.3.nn.pkg

**Purpose:** This downloads the installer packages and runs the
install from the command line (then removes the downloaded
installers).  This slightly older R version is **needed** (at present)
to match the AFNI build.  ``gfortran is`` is used to compile some R
libraries.
    
