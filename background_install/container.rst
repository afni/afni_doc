
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

| The list of AFNI-build containers that are distributed on Docker Hub
  is here:
| `<https://hub.docker.com/u/afni>`_
| Below, we show an example using the ``afni_make_build`` container;
  this is the best starting point at present, while
  ``afni_cmake_build`` could be reasonable (if not essentially the
  same), as well.


Pre-built Dockerfile
======================

The continuous integration set up on AFNI's Github uses CircleCi and
pushes to a Docker Hub account when it succeeds (*thanks, Dylan and
Jakub!*). It is built with the Dockerfile in the base directory of the
AFNI codebase and uses the CircleCi yml file `here
<https://github.com/afni/afni/blob/master/.circleci/config.yml>`_.

To use the container, copy+paste::

  docker pull afni/afni_make_build

  docker run --rm -ti  afni/afni_make_build

 
To develop using that build environment, run the following from the
afni repository::

  docker run --rm -ti  -v $PWD:/opt/afni afni/afni_make_build

and there you have it.

Neurodocker
==============

Please also check out **Neurodocker** for examples of commands to
build Dockerfiles and Singularity with AFNI (*thanks, Jakub!*):

`https://github.com/ReproNim/neurodocker
<https://github.com/ReproNim/neurodocker>`_


