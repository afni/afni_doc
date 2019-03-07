
.. _install_container_build:


************************
**Containerized AFNI**
************************

.. contents:: 

   :local:

Pre-built Dockerfile
======================

The continuous integration set up on AFNI's Github uses CircleCi and
pushes to a Docker Hub account when it succeeds (*thanks, Dylan and
Jakub!*). It is built with the Dockerfile in the base directory of the
AFNI codebase and uses the CircleCi yml file `here
<https://github.com/afni/afni/blob/master/.circleci/config.yml>`_.

To use the container, copy+paste::

  docker pull afni/afni

  docker run --rm -ti  afni/afni

 
To develop using that build environment, run the following from the
afni repository::

  docker run --rm -ti  -v $PWD:/opt/afni afni/afni

and there you have it.

Neurodocker
==============

Please also check out **Neurodocker** for examples of commands to
build Dockerfiles and Singularity with AFNI (*thanks, Jakub!*):

`https://github.com/kaczmarj/neurodocker <https://github.com/kaczmarj/neurodocker>`_


