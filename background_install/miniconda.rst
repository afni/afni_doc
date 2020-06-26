
.. _install_miniconda:


**********************************************
**Miniconda: Python(s) in a convenient setup**
**********************************************

.. contents:: 
   :local:

Overview
========

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
basically set up one or more **environments** with specific Python
versions, modules and dependencies, and we can swap back and forth
between them fairly easily---they are each separate and distinct, and
don't get in each other's way.  We can set one to be "on" by default,
not really think about it often, and then just change to another
environment if we need to.  Nice.

This page is neither a recommendation to use Conda, nor is it a full
tutorial on using it.  It is just meant to be a helpful starting point
to Conda, *if it sounds appealing to you*, to manage your Python
needs.

We will use the specific installation form of Conda called
"Miniconda", because it starts of being light-weight, and you can then
add whatever you need.

.. _install_miniconda_verbose:

Set up Conda (verbose)
==========================

Whether you are using Linux---either directly or through the Windows
Subsystem Linux---or Mac, the setup will basically follow the same
steps.  (Miniconda can also be installed on Windows directly, but
since AFNI doesn't run there, who cares?)

This example is for setting up Conda for a single user system.
Instructions for installing Conda for multiple users is `described
on the conda website here
<https://docs.conda.io/projects/conda/en/latest/user-guide/configuration/admin-multi-user-install.html>`_.  We don't discuss it further.

**Note** that you should **not** need your ``sudo`` password to
install Conda on your system, nor to run later "conda" commands.

Download+install miniconda
--------------------------

1. **Click here and select installer to download (e.g., to home
   directory):**

   * `Linux installers <https://docs.conda.io/en/latest/miniconda.html#linux-installers>`_

   * `Mac installers <https://docs.conda.io/en/latest/miniconda.html#macosx-installers>`_

   **Note on selection:** Most computers now are 64-bit, and selecting
   the "Python 3.7" version makes sense (you can still use it to set
   up Python 2.* environments on your system).  For Macs, I used the
   bash script version (rather than pkg), just because the former is
   more similar to what is done on Linux.

2. **Run the downloaded installer script:**

   Type ``bash SCRIPT_NAME``, such as:

   * *For Linux*::
       
       bash Miniconda3-latest-Linux-x86_64.sh

   * *For Mac*::
       
       bash Miniconda3-latest-MacOSX-x86_64.sh

   You will be prompted for various things:

   * hit ``Enter`` to read agreement; hit spacebar to navigate through
     it quickly; type ``yes`` to agree to it.

   * when prompted about installation directory, I just left it in the
     default "home".

   * did I wish to initialize Miniconda3? I typed: yes
     
   I then got a message that I was successfully set up; and also a
   "conda: Command not found message". So I did...

3. **Make updates known to terminal:**

   Open a new terminal.  You should see a text string like "(base)" to
   the left of your terminal prompt, and it will be to the left of
   every prompt (though you can optionally turn that off, which I do).

   You can also source the ``~/.*rc`` file for your shell, which
   should update your current terminal.  (To know what type of shell
   you are using, you can type ``echo $0``.) 
   
   * *For bash*::

       source ~/.bashrc

   * *For tcsh*::

       source ~/.cshrc

   You should see a string "(base)" string stuck before your terminal
   prompt now.  Typing ``conda -V`` should also show you your version
   number.

   **Note:** your conda version should be at least 4.6.

   
Sidenote
--------

What has Conda done to **initialize** things in the terminal?  It has
stuck some commands into your shell's startup file; in my
``~/.bashrc`` file (because I use ``bash`` shell), I can now see the
following text::

  
    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/home/USERNAME/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
	eval "$__conda_setup"
    else
	if [ -f "/home/USERNAME/miniconda3/etc/profile.d/conda.sh" ]; then
	    . "/home/USERNAME/miniconda3/etc/profile.d/conda.sh"
	else
	    export PATH="/home/USERNAME/miniconda3/bin:$PATH"
	fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<

\.\.\. where ``USERNAME`` is replaced with my actual username.  If you
chose to install miniconda in a different location than your home
directory, then the paths shown would be different.  

Note that conda/miniconda gets setup with path names hardwired into
its files, so you will **not** just be able to move your "miniconda3"
directory and update these path locations later and still have it
work.


Disable conda prompt string (opt)
---------------------------------

I **do** want to have a conda environment up and running in each new
terminal by default (so that Python is immediately available), but I
**don't** like having "(base)" appearing before my prompt all the
time.  To turn it off, you can just run::
  
  conda config --set changeps1 False

and then in each new terminal, you won't have that appear anymore.
(To make your existing terminal recognize this change, source your
shell's ``~/.*rc`` file, e.g. ``source ~/.bashrc`` or ``source
~/.cshrc``.)

If in the future you want to **re-enable** this behavior, then you can
always run::
  
  conda config --set changeps1 True

Make basic conda environments
---------------------------------

To see what conda environments are currently available on your
computer, you can type::

  conda env list

The name of all available environments will appear in the first
column, as well as their locations in the second.  The environment
which is currently loaded will have an asterisk ``*`` after its name.

To create a new environment, at its simplest you can specify a Python
version and a set of modules to install, such as::
  
  conda create -y                 \
        -n py37_afni_tiny         \
        python=3.7                \
        matplotlib numpy

where the new environment's name will be "py37_afni_tiny"; I called it
this because that is basically the minimal set of modules used within
AFNI (and even those aren't used very often).

To make a similar setup for Python 2.7 (no earlier versions of Python
should be used), one could run::

   conda create -y                 \
         -n py27_afni_tiny         \
         python=2.7                \
         matplotlib numpy 

Now, if I type ``conda list env``, I will see a list of all my
available environments::

   # conda environments:
   #
   base                  *  /home/USERNAME/miniconda3
   py27_afni_tiny           /home/USERNAME/miniconda3/envs/py27_afni_tiny
   py37_afni_tiny           /home/USERNAME/miniconda3/envs/py37_afni_tiny

To turn off a Conda environment, you can run::

  conda deactivate

To activate a particular environment, you can run ``conda activate
NAME``, such as::

    conda activate py27_afni_tiny

To see what modules are installed in your active environment (and
their version numbers) you can run::

   conda list

\.\.\. which, in the current "py27_afni_tiny" would be as follows (and
you might have slightly different things):

.. hidden-code-block:: None
   :starthidden: True
   :label: - show list output y/n -

   # packages in environment at /home/testuser/miniconda3/envs/py27_afni_tiny:
   #
   # Name                    Version                   Build  Channel
   _libgcc_mutex             0.1                        main  
   backports                 1.0                        py_2  
   backports.functools_lru_cache 1.6.1                      py_0  
   backports_abc             0.5                      py27_0  
   blas                      1.0                         mkl  
   ca-certificates           2020.1.1                      0  
   certifi                   2019.11.28               py27_0  
   cycler                    0.10.0                   py27_0  
   dbus                      1.13.12              h746ee38_0  
   expat                     2.2.6                he6710b0_0  
   fontconfig                2.13.0               h9420a91_0  
   freetype                  2.9.1                h8a8886c_1  
   functools32               3.2.3.2                  py27_1  
   futures                   3.3.0                    py27_0  
   glib                      2.63.1               h5a9c865_0  
   gst-plugins-base          1.14.0               hbbd80ab_1  
   gstreamer                 1.14.0               hb453b48_1  
   icu                       58.2                 he6710b0_3  
   intel-openmp              2020.0                      166  
   jpeg                      9b                   h024ee3a_2  
   kiwisolver                1.1.0            py27he6710b0_0  
   libedit                   3.1.20181209         hc058e9b_0  
   libffi                    3.2.1                hd88cf55_4  
   libgcc-ng                 9.1.0                hdf63c60_0  
   libgfortran-ng            7.3.0                hdf63c60_0  
   libpng                    1.6.37               hbc83047_0  
   libstdcxx-ng              9.1.0                hdf63c60_0  
   libuuid                   1.0.3                h1bed415_2  
   libxcb                    1.13                 h1bed415_1  
   libxml2                   2.9.9                hea5a465_1  
   matplotlib                2.2.3            py27hb69df0a_0  
   mkl                       2020.0                      166  
   mkl-service               2.3.0            py27he904b0f_0  
   mkl_fft                   1.0.15           py27ha843d7b_0  
   mkl_random                1.1.0            py27hd6b4f25_0  
   ncurses                   6.2                  he6710b0_0  
   numpy                     1.16.6           py27hbc911f0_0  
   numpy-base                1.16.6           py27hde5b4d6_0  
   openssl                   1.1.1g               h7b6447c_0  
   pcre                      8.43                 he6710b0_0  
   pip                       19.3.1                   py27_0  
   pyparsing                 2.4.6                      py_0  
   pyqt                      5.9.2            py27h05f1152_2  
   python                    2.7.18               h02575d3_0  
   python-dateutil           2.8.1                      py_0  
   pytz                      2019.3                     py_0  
   qt                        5.9.7                h5867ecd_1  
   readline                  8.0                  h7b6447c_0  
   setuptools                44.0.0                   py27_0  
   singledispatch            3.4.0.3                  py27_0  
   sip                       4.19.8           py27hf484d3e_0  
   six                       1.13.0                   py27_0  
   sqlite                    3.31.1               h62c20be_1  
   subprocess32              3.5.4            py27h7b6447c_0  
   tk                        8.6.8                hbc83047_0  
   tornado                   5.1.1            py27h7b6447c_0  
   wheel                     0.33.6                   py27_0  
   xz                        5.2.5                h7b6447c_0  
   zlib                      1.2.11               h7b6447c_3  


So, in this environment, I could run a program that imports
matplotlib, whereas in the "base" environment, I couldn't.

To add a module to an existing environment, you can use the following
syntax::

  conda install -n <env_name> <package>

\.\.\. so, for example example, you could add the scipy module to one
of the above environments with::

  conda install -n py27_afni_tiny scipy

To update a module or package in a currently active environment, you
can use::

  conda update <package>

\.\.\. for example,::

  conda update matplotlib



Specify default environment for the terminal
-----------------------------------------------

From the Conda initialization, the "base" environment is the default
one running in any new terminal.  We might prefer to make one of our
newly made environments the default.  To do so, I will include a line
``conda activate NAME`` in my shell's ``~/.*rc`` file somewhere
*after* the "conda initialize" lines.

Thus, since I am running "bash" shell, I have the following line in my
``~/.bashrc`` \file::

  conda activate py37_afni_tiny

Once you source that ``~/.*rc`` file again or open a new terminal, you
should see that specific environment loaded (look for the asterisked
env in the output of ``conda env list``).  If it *didn't* work,
please check that your conda version is at least 4.6 (via ``conda
-V``).

If you do choose to automatically activate your own env like this,
then you might also want to run this in a terminal::

  conda config --set auto_activate_base false

so that conda doesn't pre-load the "base" environment unnecessarily
(taking a bit of time).

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
      matplotlib numpy            \
      sphinx cloud_sptheme

You will likely get the following message:

.. hidden-code-block:: None
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

.. _install_miniconda_quick:

Set up Conda (quick)
==========================

1. **Download and install**

   At ensuing prompts, I mostly type "yes" and/or accept default
   options; see verbose description above.

   * *For Linux and tcsh*::

       set script_file = Miniconda3-latest-Linux-x86_64.sh
       curl -O https://repo.anaconda.com/miniconda/${script_file}
       bash ${script_file}

     when done::

       source ~/.cshrc

   * *For Linux and bash*::

       script_file=Miniconda3-latest-Linux-x86_64.sh
       curl -O https://repo.anaconda.com/miniconda/${script_file}
       bash ${script_file}

     when done::

       source ~/.bashrc

   * *For Mac and tcsh*::

       set script_file = Miniconda3-latest-MacOSX-x86_64.sh
       curl -O https://repo.anaconda.com/miniconda/${script_file}
       bash ${script_file}

     when done::

       source ~/.cshrc

   * *For Mac and bash*::

       script_file=Miniconda3-latest-MacOSX-x86_64.sh
       curl -O https://repo.anaconda.com/miniconda/${script_file}
       bash ${script_file}

     when done::

       source ~/.bashrc

#. **Remove annoying prompt string (opt)**

   ::

      conda config --set changeps1 False

#. **Add any channels, if needed (opt)**

   Many standard modules are default channels, but one can add more as
   necessary, e.g.::

      conda config --add channels conda-forge --add channels anaconda

   To find out what channel has your module of interest, use the
   searchbar at the top of this page: https://anaconda.org

#. **Make some new environments**

   ::

      conda create -y                 \
            -n py37_afni_tiny         \
            python=3.7                \
            matplotlib numpy

      conda create -y                 \
            -n py27_afni_tiny         \
            python=2.7                \
            matplotlib numpy 

#. **Add to an existing environment**

   ::

      conda install -n py27_afni_tiny scipy

#. **Activate an env by default**

   Specify the env to activate in your ``~/.*rc`` file. 

   Open up the ``~/.bashrc`` or ``~/.cshrc`` text file and put
   ``conda activate NAME`` **after** the conda-initialization lines
   in that file, or, e.g. copy+paste:

   * *For tcsh*::

       echo "" >> ~/.cshrc
       echo "conda activate py37_afni_tiny" >> ~/.cshrc
       echo "" >> ~/.cshrc

   * *For bash*::

       echo "" >> ~/.bashrc
       echo "conda activate py37_afni_tiny" >> ~/.bashrc
       echo "" >> ~/.bashrc

   **Note:** This assumes your conda version (``conda -V``) is at
   least 4.6.

   If you do automatically activate your own env, then you might also
   want to do this::

     conda config --set auto_activate_base false

   so that conda doesn't pre-load the "base" environment unnecessarily
   (taking a bit of time).

#. **Quicktasks with Conda**

   List modules (starred/asterisked one is active)::

     conda env list

   Deactivate current module::

     conda deactivate

   Activate/switch to a specific module::

     conda activate NAME

   See module+version list in current env::

     conda list

   Update a package in the current environment::

     conda update PACKAGE


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

It's here: `the conda cheatsheet <https://docs.conda.io/projects/conda/en/4.6.0/_downloads/52a95608c49671267e40c689e0bc00ca/conda-cheatsheet.pdf>`_.


A note on making envs and choosing modules
===========================================

It is entirely up to you, Dear User, what modules you install and how
you organize your environments (and if you even *choose* to use
Conda).  At the moment AFNI-land has pretty minimal Python
requirements. In fact, the AFNI set of recommended modules might
simply fit inside those requirements that you have for other
software/uses, and you might not need to do anything new.

We certainly don't anticipate or desire a person to set up one
specific environment for running AFNI, then another for running some
other software, and then another for another project... While that is
possible, it seems annoying and inefficient.  And unnecessary.  So,
hopefully, you can set up one environments (or maybe two, because of
the Python-2.7 and Python-3.* split), and not have to switch too much.

