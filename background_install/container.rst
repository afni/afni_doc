
.. _install_container_build:


*******************************************
**Work with Docker/Containerized AFNI**
*******************************************

.. contents:: 
   :local:

Install the Docker Engine
==========================

| Notes on installing the Docker Engine on various OSs/platforms are
  available here:
| `<https://docs.docker.com/engine/install/>`_
| For example, I have followed the installation steps for Ubuntu here:
| `<https://docs.docker.com/engine/install/ubuntu/>`_
| \.\.\. and my computer did not burst into flames (*yet!*).


Use pre-built dockerfile
===========================

The continuous integration set up on AFNI's Github uses CircleCi and
pushes to a Docker Hub account when it succeeds (*thanks, Dylan and
Jakub!*). It is built with the Dockerfile in the base directory of the
AFNI codebase and uses the CircleCi yml file `here
<https://github.com/afni/afni/blob/master/.circleci/config.yml>`_.

**Get the image**

   To get the image from the online repository (here, Docker Hub), run::

     docker pull afni/afni_make_build

   This should only have to be done once.

   | *Sidenote:* the list of AFNI-built containers that are distributed on
     Docker Hub is here:
   | `<https://hub.docker.com/u/afni>`_
   | Here, we show an example using the ``afni_make_build`` container;
     this is the best starting point at present, while
     ``afni_cmake_build`` could be reasonable (if not essentially the
     same), as well.

**Start the container environment**

   To use the contents of the container, copy+paste::

     docker run --rm -ti  afni/afni_make_build

   After that, the docker environment should be up and running in that
   terminal, and ``which afni`` should output a value under
   ``/opt/...``.  The non-GUI programs should work fine.

   To do that while also mounting your home directory (to access those
   files), you can run::

     docker run --rm -ti  -v ${HOME}:/opt/home  afni/afni_make_build

   \.\.\. after which everything in your typical home directory would
   be accessible under ``/opt/home/``.

   Finally, to do both of those things *and* to have the ability to
   open up the ``afni`` and ``suma`` GUIs (see :ref:`this note
   <install_container_build_mac12_Sili>` if using macOS 12 with an
   Apple Silicon CPU), you could run::

     docker run --rm -ti                  \
         --user=`id -u`                   \
         -v /tmp/.X11-unix:/tmp/.X11-unix \
         -e DISPLAY=${DISPLAY}            \
         -v ${HOME}:/opt/home             \
         afni/afni_make_build

   Note that to be able to use the above command, your local computer
   itself must be set up to open the GUIs.

   .. another example

      docker run --rm -ti                  \
          --user=`id -u`                   \
          -v /tmp/.X11-unix:/tmp/.X11-unix \
          -e DISPLAY=${DISPLAY}            \
          -v /Users:/home                  \
          --env HOME=/home/${USER}         \
          afni/afni_make_build

   *(Thanks, Vinai, for many helpful pointers with this!)*

**Exit the container**

   Select the terminal and hit ``Ctrl+d``, or type the command
   ``exit``.

.. _install_container_build_mac12_Sili:

A note if you are using macOS 12 
----------------------------------------------------------

Things are slightly more complicated to be able to run the GUIs
through Docker. The following still assumes you have already installed
XQuartz on your computer following :ref:`the AFNI install instuctions
<install_steps_mac12_Silicon>`.

First, set your XQuartz security preferences as follows (which should
only have to be done once):

1. Launch XQuartz, open its menu, and select **Preferences**
#. Go to the **Security** tab, and ensure "Allow connections from
   network clients" is checked.

Then, you can run your docker container as follows (yes, two commands)::
 
  xhost + `hostname`

  docker run --rm -ti                    \
      --user=`id -u`                     \
      -v /tmp/.X11-unix:/tmp/.X11-unix   \
      -e DISPLAY=host.docker.internal:0  \
      -v ${HOME}:/opt/home               \
      afni/afni_make_build

The above is derived from notes and further discussion `here
<https://gist.github.com/cschiewek/246a244ba23da8b9f0e7b11a68bf3285>`_.
The original instructions suggested the first command should be
``xhost + ${hostname}``, but that did not apply to ``tcsh``/\ ``csh``
shells, while the above version does, as well as for ``zsh``/\
``bash``.

Neurodocker
==============

Please also check out **Neurodocker** for examples of commands to
build Dockerfiles and Singularity with AFNI (*thanks, Jakub!*):

`https://github.com/ReproNim/neurodocker
<https://github.com/ReproNim/neurodocker>`_


