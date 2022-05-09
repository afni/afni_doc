
.. _install_miniconda:


**********************************************
**Miniconda: Python(s) in a convenient setup**
**********************************************

.. highlight:: tcsh

.. contents:: 
   :local:

Overview
========

*This page is neither a recommendation to use Conda, nor is it a full
tutorial on using it.  It is just meant to be a helpful starting point
to Conda, if it sounds appealing to you.  Examples here are just for
managing a few Python needs for AFNI.*

Python is increasingly used in the imaging world. Everyone and their
sheepadoodle seems to be writing in it and coming across it in some
part of their daily work. Part of its appeal is that there exist many
useful modules for carrying out tasks (plotting, machine learning,
statistical modeling, writing in XKCD font, etc.).  

Along with the flexibility and broad appeal of Python comes a need for
managing and maintaining dependencies: making sure the necessary
dependencies are installed, adding/updating modules, and using the
requisite version of Python. For example, there were major changes
between Python 2 and 3 (just try evaluating 1/2 in each case), and
occasionally across sub-versions code can break; we can only wait and
see what will happen with Python 4.

Anyway, managing potentially multiple versions of Python, as well as
diferent sets of dependencies can be tricky.  There are different ways
of doing this, but through personal experience I have found using
"Conda" to be (by far) the easiest and most straightforward.  We can
basically set up one or more **environments** (or **envs**) with
specific Python versions, modules and dependencies, and we can swap
back and forth between them fairly easily---they are each separate and
distinct, and don't get in each other's way.  We can set one to be
"on" by default, not really think about it often, and then just change
to another environment if we need to.  Nice.

| We will use the specific installation form of Conda called
  "Miniconda", because it starts of being light-weight, and you can
  then add whatever you need.  Some official reference pages for this
  are:
| `<https://docs.conda.io/projects/conda/en/latest/user-guide/index.html>`_
| `<https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html>`_

These notes apply to either Linux or Mac OS. Miniconda can also be
installed on Windows directly, but since AFNI doesn't run there, who
cares?

These notes are only for setting up Conda for a single user.
Instructions for installing Conda for multiple users is `described on
the conda website here
<https://docs.conda.io/projects/conda/en/latest/user-guide/configuration/admin-multi-user-install.html>`_.

**Very important note:** you should **not** need your ``sudo``
password to install Conda on your system, nor to run later "conda"
commands. Using ``sudo`` with ``conda`` will just cause headaches
later, so don't do it.


.. _install_miniconda_verbose:

Set up Conda (*verbose*)
==========================


Download+install miniconda
--------------------------

1. **To download+install, copy+paste**:
   
   |

   * *\.\.\. for Linux*::

       curl -OL https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
       bash Miniconda3-latest-Linux-x86_64.sh -b

   * *\.\.\. for Mac*::

       curl -OL https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh
       bash Miniconda3-latest-MacOSX-x86_64.sh -b

   The ``curl`` program should be installed on your computer after
   following AFNI setup instructions.  You can also copy+paste the
   link into a browser and download it that way.

   *NB:* The ``-b`` option runs the installer in "batch mode", saying
   yes to all prompts: install into home directory, accept licenses.
   To go through those options manually, don't include that option.

   |


#. **To initialize conda in shells, copy+paste**::
     
     ~/miniconda3/bin/conda init bash tcsh zsh

   This puts conda setup text into each of the above shell's
   ``~/.*rc`` files (the relative path to ``conda`` must be given when
   using the batch mode installation in the previous step).

   *NB:* Conda/miniconda gets setup with path names hardwired into its
   files, so you can\ *not* just move your "miniconda3" directory and
   update these path locations later and still have it work.

   |

#. **Make updates known to terminal**

   Do one of the following:
   
   A. Open a new terminal.  You should now see a text string like
      "(base)" to the left of your terminal prompt. (Below, we show you
      can optionally disable that text.)

      |

   B. Source your shell's ``~/.*rc`` file (to know your current shell,
      type ``echo $0``):

      |

      * \.\.\. *for bash*::

          source ~/.bashrc

      * \.\.\. *for tcsh or csh*::

          source ~/.cshrc

      * \.\.\. *for zsh*::

          source ~/.zshrc

   You should see a string "(base)" string stuck before your terminal
   prompt now.  (Below, you can optionally disable that text.)

   Type ``conda -V`` to see the version number.  *NB:* It should be at
   least 4.6.

   
.. comment out this info? guess so.

   Sidenote
   --------

   What has Conda done to **initialize** things in the terminal?  It has
   stuck some commands into your shell's startup file; in my
   ``~/.bashrc`` file (because I use ``bash`` shell), I can now see the
   following text::


       # >>> conda initialize >>>
       # !! Contents within this block are managed by 'conda init' !!
       __conda_setup="$('/home/${USER}/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
       if [ $? -eq 0 ]; then
      eval "$__conda_setup"
       else
      if [ -f "/home/${USER}/miniconda3/etc/profile.d/conda.sh" ]; then
          . "/home/${USER}/miniconda3/etc/profile.d/conda.sh"
      else
          export PATH="/home/${USER}/miniconda3/bin:$PATH"
      fi
       fi
       unset __conda_setup
       # <<< conda initialize <<<

   \.\.\. where ``${USER}`` is replaced with my actual username.  If you
   chose to install miniconda in a different location than your home
   directory, then the paths shown would be different.  

   Note that conda/miniconda gets setup with path names hardwired into
   its files, so you will **not** just be able to move your "miniconda3"
   directory and update these path locations later and still have it
   work.

Update conda version (opt)
------------------------------------ 

When you run some Conda commands, you might receive promptings to
update your Conda version.  Sometimes explicit commands for
copy+pasting are even provided.  Go ahead and do so.  The following
command can also be used to update your Conda (or to check that you
are update, at least)::

  conda update -n base -c defaults conda

To check your current Conda version, type::

  conda --version


Load/exit basic conda environments
-------------------------------------

To see the list of currently available conda environments, type::

  conda env list

The name of each available environment appears in the first column
(its file location appears in the second).  The currently active
environment has an asterisk ``*`` after its name (one might not be
loaded).

To load or "activate" an environment in that list called ``ENV_NAME``,
type::

  conda activate ENV_NAME

To exit or "deactivate" the current environment, type::

  conda deactivate

Make+check conda environments (e.g., Python for AFNI), 1
------------------------------------------------------------

There are many aspects to creating a new environment.  We only provide
the most basic here.  For example, conda can manage much more
complicated environments, beyond loading just Python+modules.

Here is an example of creating a new environment from a command line,
one that packages Python version 3.9 and a few useful modules (whose
unspecified version numbers will be whatever conda decides, with
Matplotlib being *at least* 2.2.3)::
  
  conda create -y                        \
        -n py39_afni_tiny                \
        python=3.9                       \
        "matplotlib>=2.2.3" numpy scipy

This new environment's name is "py39_afni_tiny"; I called it this
because that is basically the minimal set of modules used within AFNI
(at present).

To make a similar setup for Python 2.7 (no earlier versions of Python
should be used), one could run::

  conda create -y                        \
        -n py27_afni_tiny                \
        python=2.7                       \
        "matplotlib>=2.2.3" numpy scipy  \
        pillow 

Now, if I type ``conda list env``, I will see a list of all my
available environments (where ``${USER}`` would actually be replaced
by my username)::

   # conda environments:
   #
   base                  *  /home/${USER}/miniconda3
   py27_afni_tiny           /home/${USER}/miniconda3/envs/py27_afni_tiny
   py39_afni_tiny           /home/${USER}/miniconda3/envs/py39_afni_tiny

As noted above, to switch to ``py39_afni_tiny``, I would type::

  conda activate py39_afni_tiny

To see what modules are installed in your active environment (and
their version numbers) you can run::

   conda list

\.\.\. which, in the current "py39_afni_tiny" would be as follows (and
you might have slightly different things):

.. hidden-code-block:: none
   :starthidden: True
   :label: - show list output y/n -

   # packages in environment at /home/ptaylor/miniconda3/envs/py39_afni_tiny:
   #
   # Name                    Version                   Build  Channel
   _libgcc_mutex             0.1                        main  
   _openmp_mutex             4.5                       1_gnu  
   blas                      1.0                         mkl  
   brotli                    1.0.9                he6710b0_2  
   ca-certificates           2021.10.26           h06a4308_2  
   certifi                   2021.10.8        py39h06a4308_0  
   cycler                    0.11.0             pyhd3eb1b0_0  
   dbus                      1.13.18              hb2f20db_0  
   expat                     2.4.1                h2531618_2  
   fontconfig                2.13.1               h6c09931_0  
   fonttools                 4.25.0             pyhd3eb1b0_0  
   freetype                  2.11.0               h70c0345_0  
   giflib                    5.2.1                h7b6447c_0  
   glib                      2.69.1               h5202010_0  
   gst-plugins-base          1.14.0               h8213a91_2  
   gstreamer                 1.14.0               h28cd5cc_2  
   icu                       58.2                 he6710b0_3  
   intel-openmp              2021.4.0          h06a4308_3561  
   jpeg                      9d                   h7f8727e_0  
   kiwisolver                1.3.1            py39h2531618_0  
   lcms2                     2.12                 h3be6417_0  
   ld_impl_linux-64          2.35.1               h7274673_9  
   libffi                    3.3                  he6710b0_2  
   libgcc-ng                 9.3.0               h5101ec6_17  
   libgfortran-ng            7.5.0               ha8ba4b0_17  
   libgfortran4              7.5.0               ha8ba4b0_17  
   libgomp                   9.3.0               h5101ec6_17  
   libpng                    1.6.37               hbc83047_0  
   libstdcxx-ng              9.3.0               hd4cf53a_17  
   libtiff                   4.2.0                h85742a9_0  
   libuuid                   1.0.3                h7f8727e_2  
   libwebp                   1.2.0                h89dd481_0  
   libwebp-base              1.2.0                h27cfd23_0  
   libxcb                    1.14                 h7b6447c_0  
   libxml2                   2.9.12               h03d6c58_0  
   lz4-c                     1.9.3                h295c915_1  
   matplotlib                3.5.0            py39h06a4308_0  
   matplotlib-base           3.5.0            py39h3ed280b_0  
   mkl                       2021.4.0           h06a4308_640  
   mkl-service               2.4.0            py39h7f8727e_0  
   mkl_fft                   1.3.1            py39hd3c417c_0  
   mkl_random                1.2.2            py39h51133e4_0  
   munkres                   1.1.4                      py_0  
   ncurses                   6.3                  h7f8727e_2  
   numpy                     1.21.2           py39h20f2e39_0  
   numpy-base                1.21.2           py39h79a1101_0  
   olefile                   0.46               pyhd3eb1b0_0  
   openssl                   1.1.1l               h7f8727e_0  
   packaging                 21.3               pyhd3eb1b0_0  
   pcre                      8.45                 h295c915_0  
   pillow                    8.4.0            py39h5aabda8_0  
   pip                       21.2.4           py39h06a4308_0  
   pyparsing                 3.0.4              pyhd3eb1b0_0  
   pyqt                      5.9.2            py39h2531618_6  
   python                    3.9.7                h12debd9_1  
   python-dateutil           2.8.2              pyhd3eb1b0_0  
   qt                        5.9.7                h5867ecd_1  
   readline                  8.1.2                h7f8727e_0  
   scipy                     1.7.3            py39hc147768_0  
   setuptools                58.0.4           py39h06a4308_0  
   sip                       4.19.13          py39h2531618_0  
   six                       1.16.0             pyhd3eb1b0_0  
   sqlite                    3.37.0               hc218d9a_0  
   tk                        8.6.11               h1ccaba5_0  
   tornado                   6.1              py39h27cfd23_0  
   tzdata                    2021e                hda174b7_0  
   wheel                     0.37.1             pyhd3eb1b0_0  
   xz                        5.2.5                h7b6447c_0  
   zlib                      1.2.11               h7f8727e_4  
   zstd                      1.4.9                haebb681_0  


So, in this environment, I could run a program that imports
matplotlib, whereas in the "base" environment, I couldn't.

Make+check conda environments (e.g., Python for AFNI), 2
----------------------------------------------------------------------

This is the command line style to create a new environment (perhaps
preferable to command line style, for easier saving and sharing),
including both specific and minimal package dependency versions::

* Make a new text file called :download:`environment_ex1.yml`:

  .. include:: environment_ex2.yml
     :literal:
     :code: yaml

  \.\.\. and then run::

    conda env create -f environment_ex1.yml

* Make a new text file called :download:`environment_ex2.yml`:

  .. include:: environment_ex2.yml
     :literal:
     :code: yaml

  \.\.\. and then run::

    conda env create -f environment_ex2.yml

* *(Bonus, because I like IPython, and jupyter-notebooks are
  common)* Make a new text file called
  :download:`environment_ex3.yml`:

  .. include:: environment_ex3.yml
     :literal:

  \.\.\. and then run::

    conda env create -f environment_ex3.yml



Add to+update conda environments
-------------------------------------

To add a new package or module ``NEW_PACK`` to an existing environment
``ENV_NAME``, one can use the following syntax::

  conda install -n ENV_NAME NEW_PACK

\.\.\. so, for example example, you could add the scipy module to one
of the above environments with::

  conda install -n py27_afni_tiny ipython

To update a module or package ``CURR_PACK`` in a currently active
environment, you can use::

  conda update CURR_PACK

\.\.\. for example,::

  conda update matplotlib

So, let's say you want one primary environment on your OS to have all
your packages of interest loaded, so you don't have to hop between
environments when using different programs.  You could make one that
has everything you know you need loaded now, and then in the future
you could simply keep adding to it.  This might be useful with AFNI,
in particular, because there are so few requirements here (modern
Python with a very small number of modules).


Specify default environment for the terminal
-----------------------------------------------

By default, conda will load the "base" environment in any new
terminal.  To instead have a different environment ``ENV_NAME`` loaded
in each new terminal/shell, we can add the line ``conda activate
ENV_NAME`` in the shell's ``~/.*rc`` file somewhere *after* the ``#
>>> conda initialize >>>`` lines.

Since I am running "bash" shell, I have added the following line in my
``~/.bashrc`` \file (by opening that file with a text editor)::

  conda activate py39_afni_tiny

After sourcing that file or opening a new terminal, ``conda env list``
should show that environment loaded, in this and in any new terminals.
If that did *not* work, please check that that the conda version is at
least 4.6 (via ``conda -V``).

If you do choose to automatically activate your own env like this,
then you might also want to run this in a terminal::

  conda config --set auto_activate_base false

so that conda doesn't pre-load the "base" environment unnecessarily
(taking a bit of time).


Disable conda prompt string (opt)
---------------------------------

Personally I **don't** like having the name of the conda environment
always appearing before my prompt, like "(base)" or whatever.  To not
display that text, you can run::
  
  conda config --set changeps1 False

To make your existing terminal recognize this change, source your
shell's ``~/.*rc`` file, e.g. ``source ~/.bashrc`` or ``source
~/.cshrc``. Or open a new terminal.

If in the future you want to **re-enable** this behavior, then you can
always run::
  
  conda config --set changeps1 True

These commands edit a text file called ``~/.condarc``.  You can open
it and see what defaults/settings you have made, if you wish.


.. _install_miniconda_quick:

Set up Conda (*quick*)
==========================

1. **Download and install**

   |

   * *\.\.\. for Linux*::

       curl -OL https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
       bash Miniconda3-latest-Linux-x86_64.sh -b

   * *\.\.\. for Mac*::

       curl -OL https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh
       bash Miniconda3-latest-MacOSX-x86_64.sh -b

#. **Initialize conda in shells**

   ::

     ~/miniconda3/bin/conda init bash tcsh zsh

#. **Make updates known to terminal**

   |
   | Open a new terminal, or source your shell's ``~/.*rc`` file.
   |

#. **Remove annoying prompt string (opt)**

   ::

      conda config --set changeps1 False

#. **Update conda version (opt)**

   ::

      conda update -n base -c defaults conda

   \.\.\. and to display conda version::

     conda --version

#. **Make some new environments (from command line): AFNI minimal Python**

   This is the command line style to create a new environment,
   including both specific and minimal package dependency versions::

      conda create -y                        \
            -n py39_afni_tiny                \
            python=3.9                       \
            "matplotlib>=2.2.3" numpy scipy

      conda create -y                        \
            -n py27_afni_tiny                \
            python=2.7                       \
            "matplotlib>=2.2.3" numpy scipy  \
            pillow 

   See the next section for a slightly better way.
   
   |

#. **Make some new environments (from text file): AFNI minimal Python**

   This is the command line style to create a new environment (perhaps
   preferable to command line style, for easier saving and sharing),
   including both specific and minimal package dependency versions::

   * Make a new text file called :download:`environment_ex1.yml`:

     .. include:: environment_ex1.yml
        :literal:

     \.\.\. and then run::

       conda env create -f environment_ex1.yml

   * Make a new text file called :download:`environment_ex2.yml`:

     .. include:: environment_ex2.yml
        :literal:

     \.\.\. and then run::

       conda env create -f environment_ex2.yml

   * *(Bonus, because I like IPython, and jupyter-notebooks are
     common)* Make a new text file called
     :download:`environment_ex3.yml`:

     .. include:: environment_ex3.yml
        :literal:

     \.\.\. and then run::

       conda env create -f environment_ex3.yml



#. **Load an existing environment**

   Copy+paste::
   
     conda activate ENV_NAME

   For example, from above to setup for AFNI::

     conda activate py39_afni_tiny

#. **Activate an env by default**

   |
   | To activate some env ``ENV_NAME`` by default, put ``conda
     activate ENV_NAME`` in your shell's ``~/.*rc`` file, *after* the
     ``# <<< conda initialize <<<`` line.
   | For example, to set up for AFNI,
     put ``conda activate py39_afni_tiny`` there.

   *NB1:* This assumes your conda version (``conda -V``) is at
   least 4.6.

   *NB2:* If you do automatically activate your own env, then also
   copy+paste the following to not pre-load the "base" env (adding
   unnecessary time)::

     conda config --set auto_activate_base false

   | *NB3:* In general, you don't want to keep appending different
     ``conda activate ...`` commands in a ``~/.*rc`` file, as each one
     takes a bit of time.
   |

#. **Add to an existing environment**

   Once you have built an environment, if you decide you another
   package that you might have forgotten, you can do so with:

   ::

      conda install -n ENV_NAME PACK_NAME


   For example, 

   ::

      conda install -n py27_afni_tiny pandas


Short list of conda commands
=============================

List available modules (starred/asterisked one is active)::

  conda env list

Deactivate current module::

  conda deactivate

Activate/switch to a specific environment/module::

  conda activate ENV_NAME

See module+version list in current env::

  conda list

Update a package in the current environment::

  conda update PACKAGE

Add a package to some environment::

   conda install -n ENV_NAME PACK_NAME

Add a channel to an active environment (with top priority among
channels)::

  conda config --add channels NEW_CHANNEL 

Add a channel to an active environment (with *bottom* priority
among channels)::

  conda config --append channels NEW_CHANNEL 

Remove an existing environment (``ENV_NAME`` cannot be active when
this command is run)::

  conda remove --name ENV_NAME --all

Update conda program version::

  conda update -n base -c defaults conda

A note on making envs, re. AFNI and more
===========================================

It is entirely up to you, Dear User, what modules you install and how
you organize your environments (and if you even *choose* to use
Conda).  At the moment AFNI has very minimal Python requirements. In
fact, the AFNI set of recommended modules might simply fit inside
those requirements that you have for other software/uses, and you
might not need to do anything new.

We certainly don't anticipate or desire a person to set up one
specific environment for running AFNI, then another for running some
other software, and then another for another project\.\.\.  While that
is possible, it seems annoying and inefficient, and often unnecessary.
So, hopefully, you can set up one environment (or a small number of
them) and not have to switch too much.


Fancier things with Conda
=========================

There are a lot of fancy things that can be done with Conda that we
will not describe here.  A good starting point is the `Managing
Environments documentation
<https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html#>`_.

Cloning
-------

One concept with Conda is **cloning environments**: if I can setup a
Conda environment on my laptop with a certain set of modules, each
with a certain version number, then I can "clone" it and use that
exact recipe to setup a duplicate environment on a different computer.
This is a nice concept for reproducibility (as sometimes using
different version numbers of modules can affect outputs/results).

`More on cloning and building identical conda envs can be read
<https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html#cloning-an-environment>`_.

Note that in practice, truly duplicating environments exactly is
actually pretty tough.  Getting very close might be good enough for
most purposes, though, in practice.

View Conda Cheatsheet
----------------------

It's here: `the conda cheatsheet
<https://docs.conda.io/projects/conda/en/4.6.0/_downloads/52a95608c49671267e40c689e0bc00ca/conda-cheatsheet.pdf>`_.


Make conda environments, more generally
-----------------------------------------

The environment builder works a bit like a package manager, where it
can get a lot of common modules from a default, central repository,
but if you want more specialized ones, you might have to add from
another place.  To add new repositories to pull from, you **add a
channel** to your Conda setup.

Let's say you want to add the Sphinx module with cloud-theme support
(I doubt you will, but just as an example). If you try::

  conda create -y                 \
      -n py37_afni_with_sph       \
      python=3.7                  \
      matplotlib numpy scipy      \
      sphinx cloud_sptheme

You will likely get the following message:

.. hidden-code-block:: none
   :starthidden: False
   :label: - show text output y/n -

   Collecting package metadata (current_repodata.json): done
   Solving environment: failed with repodata from current_repodata.json, will retry with next repodata source.
   Collecting package metadata (repodata.json): done
   Solving environment: failed

   PackagesNotFoundError: The following packages are not available from current channels:

     - cloud_sptheme

   Current channels:

     - https://repo.anaconda.com/pkgs/main/linux-64
     - https://repo.anaconda.com/pkgs/main/noarch
     - https://repo.anaconda.com/pkgs/r/linux-64
     - https://repo.anaconda.com/pkgs/r/noarch

   To search for alternate channels that may provide the conda package you're
   looking for, navigate to

       https://anaconda.org

   and use the search bar at the top of the page.

This message: 1) tells us our current channels don't contain this
module; 2) shows us our current channels; and 3) helpfully directs us
to a webpage to search for a new channel that might have it.
   
So, searching for "cloud_sptheme" at https://anaconda.org/, one of the
top package owners appears to be "conda-forge" (and this is a fairly
large platform).  So, to add it to my repository list for getting
modules, I would run::

  conda config --add channels conda-forge

Then, I can retry my ``conda create ..`` command above, which should
result in success this time.

**Thus, if you try to build an environment and get told that some
desired module can't be found, you can search for it amongst available
channels, add that channel to your Conda setup, and try again.**

