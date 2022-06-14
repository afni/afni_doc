
#. **Main R libraries**::
    
     Rscript -e "install.packages(c('afex','phia','snow','nlme','lmerTest'), repos='https://cloud.r-project.org')"


**Purpose:** Installs the R libraries needed for primary AFNI stats
(R-based) programs.  Note that some newer Bayesian stats programs
require other libraries.  Some libraries other libraries are not
available on macOS for R 3.6.3.  (We are working on updating this)
``afni_system_check.py -check_all`` will show some missing libraries.
