

This is a briefer form of the above setup instructions.
It includes downloading the Bootcamp data and running
the system check (so don't forget to check that!).


There are 3 scripts to run.
To download them, copy+paste:

.. code-block:: none

   cd
   curl -O https://raw.githubusercontent.com/afni/afni/master/src/other_builds/OS_notes.linux_ubuntu_20_64_a_admin.txt
   curl -O https://raw.githubusercontent.com/afni/afni/master/src/other_builds/OS_notes.linux_ubuntu_20_64_b_user.tcsh
   curl -O https://raw.githubusercontent.com/afni/afni/master/src/other_builds/OS_notes.linux_ubuntu_20_64_c_nice.tcsh

Then run each of them, as described below.
(Each creates a log file, for checking and/or asking questions.)


#. To install packages requiring admin privileges ('sudo' password required)...

   * *... From bash shell*::

        sudo bash OS_notes.linux_ubuntu_20_64_a_admin.txt 2>&1 | tee o.ubu_20_a.txt

   * *... From tcsh shell*::

        sudo bash OS_notes.linux_ubuntu_20_64_a_admin.txt |& tee o.ubu_20_a.txt


   .. hidden-code-block:: none
      :starthidden: True
      :label: - show script y/n -
   
      # Quick build setup script 1/3.
      # From bash shell:
      #   sudo bash OS_notes.linux_ubuntu_20_64_a_admin.txt 2>&1 | tee o.ubu_20_a.txt
      # From tcsh shell:
      #   sudo bash OS_notes.linux_ubuntu_20_64_a_admin.txt |& tee o.ubu_20_a.txt
      
      sudo add-apt-repository universe
      
      # for R-package brms 
      sudo add-apt-repository -y "ppa:marutter/rrutter4.0"
      sudo add-apt-repository -y "ppa:marutter/c2d4u3.5"
      
      sudo apt-get update
      
      # main deps
      sudo apt-get install -y tcsh xfonts-base libssl-dev       \
                              python-is-python3                 \
                              python3-matplotlib                \
                              gsl-bin netpbm gnome-tweak-tool   \
                              libjpeg62 xvfb xterm vim curl     \
                              gedit evince eog                  \
                              libglu1-mesa-dev libglw1-mesa     \
                              libxm4 build-essential            \
                              libcurl4-openssl-dev libxml2-dev  \
                              libgfortran-8-dev libgomp1        \
                              gnome-terminal nautilus           \
                              gnome-icon-theme-symbolic         \
                              firefox xfonts-100dpi             \
                              r-base-dev
      
      # for R-package brms
      sudo apt-get install -y libgdal-dev libopenblas-dev       \
                              libnode-dev libudunits2-dev       \
                              libgfortran4
      
      # for package GSL
      sudo ln -s \
              /usr/lib/x86_64-linux-gnu/libgsl.so.23            \
              /usr/lib/x86_64-linux-gnu/libgsl.so.19
      
      
      echo "++ Done with sudo-required part"


   |
#. To install other dependencies (**don't** use 'sudo' here)...

   * *... From bash shell*::

        tcsh OS_notes.linux_ubuntu_20_64_b_user.tcsh 2>&1 | tee o.ubu_20_b.txt

   * *... From tcsh shell*::

        tcsh OS_notes.linux_ubuntu_20_64_b_user.tcsh |& tee o.ubu_20_b.txt


   .. hidden-code-block:: none
      :starthidden: True
      :label: - show script y/n -
   
      #!/bin/tcsh
      
      # Quick build setup script 2/3.
      # From bash shell:
      #   tcsh OS_notes.linux_ubuntu_20_64_b_user.tcsh 2>&1 | tee o.ubu_20_b.txt
      # From tcsh shell:
      #   tcsh OS_notes.linux_ubuntu_20_64_b_user.tcsh |& tee o.ubu_20_b.txt
      
      echo "++ Get AFNI binaries"
      
      cd
      curl -O https://afni.nimh.nih.gov/pub/dist/bin/misc/@update.afni.binaries
      tcsh @update.afni.binaries -package linux_ubuntu_16_64 -do_extras
      
      source ~/.cshrc
      
      
      echo "++ Download Bootcamp data"
      
      curl -O https://afni.nimh.nih.gov/pub/dist/edu/data/CD.tgz
      tar xvzf CD.tgz
      cd CD
      tcsh s2.cp.files . ~
      cd ..
      
      
      echo "++ Prepare to install R and its packages (will take a while)"
      
      setenv R_LIBS $HOME/R
      mkdir  $R_LIBS
      echo  'export R_LIBS=$HOME/R' >> ~/.bashrc
      echo  'setenv R_LIBS ~/R'     >> ~/.cshrc
      
      rPkgsInstall -pkgs ALL
      
      # in case R's brms didn't install first time
      Rscript -e "install.packages(c('Rcpp','brms'), dependencies = TRUE, INSTALL_opts = '--no-lock')"
      
      set asc  = ~/o.afni_system_check.txt
      echo "++ Run system check, saving to: ${asc}"
      
      afni_system_check.py -check_all > ${asc}
      
      echo "++ Done with 2nd part of install"


   |
#. To niceify your terminal (optional, but useful)...

   * *... From bash shell*::

        tcsh OS_notes.linux_ubuntu_20_64_c_nice.tcsh 2>&1 | tee o.ubu_20_c.txt

   * *... From tcsh shell*::

        tcsh OS_notes.linux_ubuntu_20_64_c_nice.tcsh |& tee o.ubu_20_c.txt


   .. hidden-code-block:: none
      :starthidden: True
      :label: - show script y/n -
   
      # Quick build setup script 3/3.
      # From bash shell:
      #   tcsh OS_notes.linux_ubuntu_20_64_c_nice.tcsh 2>&1 | tee o.ubu_20_c.txt
      # From tcsh shell:
      #   tcsh OS_notes.linux_ubuntu_20_64_c_nice.tcsh |& tee o.ubu_20_c.txt
      
      
      
      echo ""             >> ~/.cshrc
      echo 'set filec'    >> ~/.cshrc
      echo 'set autolist' >> ~/.cshrc
      echo 'set nobeep'   >> ~/.cshrc
      
      echo 'alias ls ls --color=auto' >> ~/.cshrc
      echo 'alias ll ls --color -l'   >> ~/.cshrc
      echo 'alias ltr ls --color -ltr'   >> ~/.cshrc
      
      echo ""                         >> ~/.bashrc
      echo 'alias ls="ls --color"'    >> ~/.bashrc
      echo 'alias ll="ls --color -l"' >> ~/.bashrc
      echo 'alias ltr="ls --color -ltr"' >> ~/.bashrc

   |
