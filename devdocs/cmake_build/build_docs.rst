.. _devdocs_cmake:

Cmake for AFNI - making AFNI is a piece of C(m)ake
==================================================

.. contents:: :local:

.. highlight:: None

Overview
---------

In addition to the build systems using make files, you can build the
AFNI project using the CMake build system. This build system offers
several advantages some of which are:

-  Parallel builds can be performed greatly accelerating build time (at
   least an order of magnitude if you have the CPUs)

-  One build to rule them all… it configures itself for Linux or Mac
   systems so you don't have to tweak it for your specific system. This
   works for Clang, icc,gcc (the latter most frequently used)

-  Dependency management: as part of the previous point, you can detect
   and build against dependencies on your system. Alternatively you can
   specify CMake options to directly download, build, and install
   dependencies from source

-  Shared object linking: CMake manages shared object linking (linking
   against .so or .dylib files) in a robust way. Depending on whether
   you have a build directory or have installed the software, the rpath
   of all binaries is set appropriately to link against all
   dependencies.


.. _devdocs_cmake_quickstart:

Quickstart
----------

::

   # change to your home directory, or whatever you would prefer
   cd
   git clone https://github.com/afni/afni
   cd afni
   mkdir build; cd build
   cmake [options] ..
   # can make specific targets like afni,3dDeconvolve,etc
   make

All binaries should now be present in ``./targets_built`` (in build
directory). Note that scripts (tcsh, R, python etc.) will remain in
the source tree until installation.

N.B. For a faster build you can instead use the ninja build system set
the environment variable CMAKE_GENERATOR to "Ninja" and substitute the
make command above for "ninja" (cmake v>3.14). But see\ `Section: Ninja
build system <boring_cmake_ninja>`__.

For a more comprehensive overview see the `Section: Basic approach to
building and installing <boring_cmake_basic_approach>`__.

.. _devdocs_cmake_install_dev:

Installation of development dependencies
----------------------------------------

In order to get a basic working setup on your computer you can try the
suggestions below :

On Debian:

::

   apt-get install ca-certificates curl freeglut3-dev libf2c2-dev               \
                   libglib2.0-dev libglu1-mesa-dev libglw1-mesa-dev             \
                   libgsl-dev libgts-dev libjpeg62 libmotif-dev libnetcdf-dev   \
                   libxi-dev libxmhtml-dev libxmu-dev libxpm-dev libxt-dev      \
                   libvolpack1-dev python-dev python3.6-dev qhull-bi            \
                   r-base tcsh ninja-build

.. note:: GLW breaks our build on ubuntu/debian. Use neurodebian or use the
          cmake option ``-DUSE_SYSTEM_GLW=OFF``.

On macOS:

::

   brew cask install xquartz
   brew unlink python\@2
   brew install                                           \
       llvm cmake ninja pkgconfig                         \
       jpeg gsl gts openmotif netcdf libpng expat         \
       freetype fontconfig gsl netpbm git-annex

Note, for a more comprehensive list of development dependencies it may
be worth checking out the files used for continuous integration
testing: `github.com/afni/.circleci/config.yml
<https://github.com/afni/afni/blob/master/.circleci/config.yml>`__ and
`github.com/afni/.docker/afni_dev_base.dockerfile
<https://github.com/afni/afni/blob/master/.docker/afni_dev_base.dockerfile>`__

.. _devdocs_cmake_basic_approach:

Basic approach to building and installing
-----------------------------------------

Cmake detects all of the details of your system and then generate a
build system (for example it will write Make files) that can
subsequently be executed.

.. _devdocs_cmake_config:

Configuring cmake
~~~~~~~~~~~~~~~~~

When running cmake, it will try to find out the details of your system
based on the options you have passed on the command line. This includes
checking that required compiler properties and other dependencies are
acceptable on the system. The most common errors at this point would be
that you do not have a dependency installed.

.. _devdocs_cmake_gen:

Generating a build system
~~~~~~~~~~~~~~~~~~~~~~~~~

Assuming no errors occur during cmake's configure-time, cmake will try
to generate a build system. This consists of writing a set of build
files (for example Make files) to the build directory that will execute
on the current host.

.. _devdocs_cmake_exec:

Executing a build
~~~~~~~~~~~~~~~~~

After the build system is generated you can build your project in the
conventional way. I.e. for a Make build system you simply execute:

::

   make

This will generate all of the binaries and place them in the
targets_built subdirectory of the build directory (removing any of these
binaries will trigger a rebuild for these specific binaries and any of
their dependents). You can run the executables as expected by simply
typing something like

::

   ./targets_built/afni

.. _devdocs_cmake_ninja:

The ninja build system
~~~~~~~~~~~~~~~~~~~~~~

You can use this by setting the environment variable CMAKE_GENERATOR
to "Ninja" (cmake version > 3.14) or by adding ``-GNinja`` to the
cmake command. There are many performance advantages to using ninja,
the most notable being that a ``no op`` build is close to
instantaneous for "ninja" whereas for "make" the equivalent state
takes approximately a minute to determine that nothing is currently
required of the build system.

One potential issue is that ninja automatically computes the number of
threads it "should" use in parallel. On some Macs this seems to cause
them to crash. This may be a memory issue. It could potentially be
resolved by using ninja's `job pool functionality
<https://ninja-build.org/manual.html#ref_pool>`__. For now the issue
can be fixed using the -j flag to tell ninja to set the number of
threads used for the build. The optimal number of threads to use can
be figured out through experimentation.

.. _devdocs_cmake_install:

Installation
~~~~~~~~~~~~

WARNING: By default an installation will go into /usr/local which you
likely do not want to do. When testing that the installation works this
installation location can be overwritten easily by setting the
environment variable ``DESTDIR``.

For example in **bash**:

::

   DESTDIR=local_install_dir make install

Using **tcsh**:

::

   setenv DESTDIR local_install_dir
   make install

.. _devdocs_cmake_use:

Using an installation
~~~~~~~~~~~~~~~~~~~~~

It is worth noting that a build target (pytest) exists to do inplace
testing on the build. As one might expect it uses the pytest software to
run these tests. This setup may obviate any need to do an install as
part of your development workflow. This has the advantage that it always
checks that the project is up to date before running any tests, it
manages test data, and it temporarily modifies the PATH in order to have
all AFNI executables available for testing (both built binaries and
scripts in the source tree). For further details have a look at the
`Section: Running tests <boring_cmake_other_run_test>`__.

The bin subdirectory of an installation should be added to one's path to
make use of the "installed" AFNI. Note that this does not necessarily
have to be installed into system directories. Once on the path, you
should have access to all of the executables expected from a full AFNI
installation (as in tcsh, R… with a cmake option, and python executables
are not available following a build but they are available after an
install). If you observe any behavior that deviates from a standard AFNI
install please raise an issue on github.

.. _devdocs_cmake_mod_targ:

Modifying targets in the cmake build
------------------------------------

This section is for when you have added a new software tool and you wish
to incorporate it into the cmake build.

.. _devdocs_cmake_add_targ:

Adding new targets
------------------

In brief if I want to add a new executable, my_new_binary, using my new
source code in ``src/new_exec.c`` then I would add the cmake code:

::

   add_afni_executable(my_new_binary new_exec.c)

Executables, libraries, or plugins are added by using the cmake
functions ``add_afni_executable``, ``add_afni_library``, and
``add_afni_plugin``, respectively. These are wrappers around the
standard equivalents of cmake
(`cmake.org/cmake/help/latest/command/add_executable.html
<https://cmake.org/cmake/help/latest/command/add_executable.html>`__).
As with the make build system, CMake refers to all of these entities
that require compilation as "targets".

The cmake files for adding targets all follow the pattern
``CMake*.txt``. It is usually fairly obvious which CMake file you
should use for your new program (this is purely convention). For
example, in general for adding new binary programs use the
CMake_binaries.txt file. This will help to keep things more structured
and typically there are many examples in the appropriate files to help
you deal with tricky details. An attempt at an index of such details
is in `Section: Examples <boring_cmake_other_ex>`_.

Once you have correctly added a new target you will have to consider
updating the list of expected targets (see `Section: List of expected
targets <boring_cmake_other_det_targs>`__)

.. _devdocs_cmake_link_targ:

Linking against targets
-----------------------

The pattern to use for linking is target_link_libraries(target_name
PRIVATE external_library). See the `Section: Examples
<boring_cmake_other_ex>`__ to handle some of the trickier details.

The ``PRIVATE`` keyword could also be ``PUBLIC`` and ``INTERFACE``
(the latter is more nuanced, less common, and won't be covered
here). This keyword triggers the behavior for transitive dependencies
(the keyword is also relevant for include directories,compile
definitions and link options).

We will use a generic example with libraries A, B, and C. Library B
links against A. Library C links against B. If C needs to link against
A because it has linked against B, we say that A is a transitive
dependency of C. Typically if you are not sure you should likely be
using ``PRIVATE``. I.e. B's linking to A is private. The implication
of this is that library C does not necessarily link against A to
function. If this is not the case and we know that any library linking
against library B could not work without also linking against A we
could consider using:

::

   target_link_libraries(B PUBLIC A)

.. _devdocs_cmake_link_ext:

Linking against external software
---------------------------------

When linking against external software the pattern is very similar. The
only difference is that library A described in the previous section will
not exist unless we find the system dependency. CMake finds such
dependencies and populates the appropriate targets using find modules,
something like FindExpat.cmake. Many find modules are directly
incorporated into CMake (eg
`Expat <https://cmake.org/cmake/help/v3.10/module/FindEXPAT.html>`__).
This can be great because using expat now becomes as simple as finding
and then linking against the target that it has made available:

::

   find_package(EXPAT REQUIRED)
   target_link_library(my_library PRIVATE EXPAT::EXPAT)

The not so great bit is sometimes the behavior of these built in modules
change across cmake versions. Awareness of this helps (use your own
frozen version of it). In some cases the changes are not relevant and do
not need to be worried about. In other case they make the build too
fragile. Additionally, sometimes such a handy find module just doesn't
exist. In this case one has to write their own find module. I have
resorted to this solution many times
(`github.com/afni/afni/tree/master/cmake <https://github.com/afni/afni/tree/master/cmake>`__).
Sometimes you can find one elsewhere if you google and you can just
coopt it for your own evil purposes, or just copy the pattern you
observe in the cmake directory of that afni repo.

One more caveat regarding what you are linking against and the pattern
you use. CMake has changed a lot over the years and it is important to
follow the above pattern and not some of the older patterns. Some
examples of antipatterns that you will see and should be fervently
avoided are:

- Representing targets as variables (``${EXPAT_LIBRARIES}`` instead of
  ``EXPAT::EXPAT``)

- Not adding the appropriate code to find the dependency before you
  use it.

.. _devdocs_cmake_repr_targ:

Representing targets as variables (bad)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Sometimes this is present because it's old cmake code or the find module
is old cmake code. For example the `X11 find
module <https://cmake.org/cmake/help/v3.17/module/FindX11.html>`__ has
lots of variables. Rewriting such a find module would be foolish, so
just accepting their inferior module for older cmake versions is the
solution here. Or using the find module from a newer version by adding
it to your own source code (it works sometimes). In general using these
variables is a bad idea because if they are wrong -- as in silly typo on
your part-- or the variable doesn't exist they expand to nothing, you
link incorrectly, you have a slightly confusing error in linking
(missing symbol) or a missing header when you try to include it.

.. _devdocs_cmake_no_find:

Not using a find module for dependencies (bad)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This is a result of the sad fact that if I say something like the
following it may just work:

::

   target_link_libraries(A PRIVATE expat)

It works in a really uncontrolled way. You have not found the system
dependency, populated all of the details of that dependency
(transitive linking details, compile definitions, include directories,
and link options). Instead you have just dropped ``-lnifti`` as an
option to the linker. If your system is set up to work in this case,
you don't realise that the build will now fail to work for all the
people who do not have this system. You have also failed to take
advantage of the convenient encapsulation of all of the details that
are handled under the hood by the metadata associated with cmakes
targets.

.. _devdocs_cmake_other:

Other details
-------------

.. _devdocs_cmake_other_troubshoot:

Troubleshooting missing dependencies
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The most common error will be missing dependencies. I have currently
attempted to mitigate this by setting the defaults to just work.
Failures in this should be reported. In attempting to resolve this
yourself you can attempt the following.

1. Try to install the missing software. Hopefully, the missing package
   will be fairly self-explanatory from the error message. The base
   dockerfile should give you an idea of the dependencies that need to
   be satisfied in order to fully build and test AFNI.

#. You can try to use a build of the dependency from the AFNI
   repo/cmake driven source code download. At the end of the cmake
   options file (`github.com/afni/cmake/afni_cmake_build_options.cmake
   <https://github.com/afni/afni/blob/master/cmake/afni_cmake_build_options.cmake>`__)
   you can see many packages that can be installed using this
   alternative strategy. The basic approach is to add a flag to the
   cmake command to avoid trying to find the system installed version
   of the software\.\.\. ``-DUSE_SYSTEM_<PACKAGE_NAME>=OFF``.

There are situations in which the dependency resolution can be a lot
more difficult. Getting help in those situations is probably best. The
main issue would be that some software is in fact installed on the
system but it is not detected. This is would be a bug in the cmake
system and should be fixed.

.. _devdocs_cmake_other_det_targs:

Details of the expected targets
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The cmake system has "targets" for the various programs and libraries.
The cmake build is set up to attempt build all targets to achieve
feature parity with the Make build. There are fairly aggressive
safeguards to try to enforce synchronization of the two builds. If
targets are built that are not expected, or expected targets are not
built, the cmake system will raise an error at configure time. This can
be frustrating but will hopefully be relaxed in the future when a full
transition to the cmake build has occurred.

There are three ways of keeping track of the targets in the AFNI
project:

#. Extracting a list of targets build by the pre-existing Make build
   system

#. Checking the contents of `packaging/installed_components.txt
   <https://github.com/afni/afni/blob/master/packaging/installation_components.txt>`__

#. Extracting a list of targets built by the cmake generated build
   system

During the cmake build the contents of the category 3 is compared with
that of category 2 and an error occurs if the two lists do not match. 3
is compared to 1 and a report of the differences are detailed in the
cmake output to help determine divergence in the two build systems.

.. _devdocs_cmake_other_run_test:

Running tests
^^^^^^^^^^^^^^

Warning: The details of this section are encapsulated in the
run_afni_tests.py script in the tests directory. You may not wish to
read this.

A more extensive/up-to-date description can be found `at this link
<https://docs.google.com/document/d/1j8DxfA215sxC77Spcn_Ap0Xd8QYY3CBFCeL6jkxA-RU/edit>`__.

A build target (pytest) exists to do inplace testing on the build. This
target uses the pytest software to run these tests. This setup may
obviate any need to do an install as part of your development workflow.
This has the advantage that it always checks that the project is up to
date before running any tests, it manages test data, and it temporarily
modifies the PATH in order to have all AFNI executables available for
testing (both built binaries and scripts in the source tree). For
further details have a look at the running tests section

The ARGS environment variable can be set to modify the behavior of this
target. Examples:

::

   export ARGS='scripts --workers 3 -k mask'
   ninja pytest

The bin subdirectory of a build should be added to one's path to make
use of the "installed" AFNI. Note this may not be installed into system
directories. This will give access to all of the executables expected
from a full AFNI installation (as in tcsh, R, and python executables are
installed into bin but they do not get copied into the build output
directory).

.. _devdocs_cmake_other_refs:

Essential references
^^^^^^^^^^^^^^^^^^^^

The basic system setup on neurodebian for both make and cmake builds can
be seen here (it is the instructions used to build the base docker image
for both builds):
`github.com/afni/.docker/afni_dev_base.dockerfile <https://github.com/afni/afni/blob/master/.docker/afni_dev_base.dockerfile>`__

The cmake build on neurodebian can be seen in the cmake dockerfile:
`github.com/afni/afni/.docker/cmake_build.dockerfile <https://github.com/afni/afni/blob/master/.docker/cmake_build.dockerfile>`__

A build on MacOS occurs on CircleCI:
`github.com/afni/.circleci/config.yml <https://github.com/afni/afni/blob/master/.circleci/config.yml>`__

The books *Professional CMake* and *CMake Cookbook* are both
excellent. The former serves as an in-depth advanced reference. The
latter has many useful examples that are carefully explained.

Testing documentation is `at this link
<https://docs.google.com/document/d/1j8DxfA215sxC77Spcn_Ap0Xd8QYY3CBFCeL6jkxA-RU/edit>`__.


.. _devdocs_cmake_other_ex:

Examples
^^^^^^^^^^

Sorted somewhat by order of frequency it is required:

#. Adding targets whose .h files do not match the name of the .c files:

   https://github.com/afni/afni/blob/a823c647f491cfd2ad9bbf91c2d2fa99e49f0ee1/src/niml/CMakeLists.txt#L28

#. Installing scripts and other files:

   https://github.com/afni/afni/blob/a882698ac88333055c1bee44ce36a0aeac89f5c4/src/scripts_install/CMakeLists.txt#L1

#. Specifying settings with default values that can be used throughout
   the build:

   https://github.com/afni/afni/blob/68e469cb8953adde4a21876c6b8b2e81f03ecad2/cmake/afni_cmake_build_options.cmake#L1

#. Linking against external libraries:

   https://github.com/afni/afni/blob/68e469cb8953adde4a21876c6b8b2e81f03ecad2/src/ptaylor/CMakeLists.txt#L85

#. Setting compile time definitions for targets:

   https://github.com/afni/afni/blob/23d6f34b4d67efced8c6ca0f5ec4febc9e34ecda/src/leej3/CMakeLists.txt#L10

#. Setting compile time definitions for specific source files:

   https://github.com/afni/afni/blob/a882698ac88333055c1bee44ce36a0aeac89f5c4/src/CMakeLists_mri.txt#L59

#. Specifying public and private dependencies of libraries to
   conveniently propagate compilation/link settings to dependent
   libraries/executables

   https://github.com/afni/afni/blob/8e6dbf7aaad26964127d23b40238dc4288c88a31/src/ptaylor/CMakeLists.txt#L18

#. Adding headers that are needed at compilation but shouldn't be
   distributed elsewhere:

   https://github.com/afni/afni/blob/a823c647f491cfd2ad9bbf91c2d2fa99e49f0ee1/src/CMakeLists_binaries.txt#L419

#. Using INTERFACE libraries to establish compile definitions, headers
   etc but doesn't actually get created by the build system:

   https://github.com/afni/afni/blob/2a093556a98ae83c5acae9a49a12561ef287206b/src/Audio/CMakeLists.txt#L1

#. Writing custom commands for configure time

   https://github.com/afni/afni/blob/a882698ac88333055c1bee44ce36a0aeac89f5c4/src/CMakeLists_mri.txt#L123

#. Writing custom commands for build time

   https://github.com/afni/afni/blob/a882698ac88333055c1bee44ce36a0aeac89f5c4/cmake/afni_project_dependencies.cmake#L130

#. Creating "object" libraries (a collection of .o files for convenience
   that can be reused across binaries)

   https://github.com/afni/afni/blob/23d6f34b4d67efced8c6ca0f5ec4febc9e34ecda/src/leej3/CMakeLists.txt#L3

#. Dealing with targets whose source files span several directories

   https://github.com/afni/afni/blob/23d6f34b4d67efced8c6ca0f5ec4febc9e34ecda/src/CMakeLists_x_dependent.txt#L5

#. Specifying linking in a conditional way dependending on system, build
   configuration:

   https://github.com/afni/afni/blob/a882698ac88333055c1bee44ce36a0aeac89f5c4/src/SUMA/CMakeLists.txt#L61

#. Plugins:

   https://github.com/afni/afni/blob/23d6f34b4d67efced8c6ca0f5ec4febc9e34ecda/src/CMakeLists_plugins.txt#L1

#. Treating .c files as similar to header files in that they are
   included and dependent targets should also be able to include them:

   https://github.com/afni/afni/blob/a882698ac88333055c1bee44ce36a0aeac89f5c4/src/CMakeLists_binaries.txt#L392

#. Using external libraries that have diverged slightly from versions
   now distributed by package-managers:

   https://github.com/afni/afni/blob/68e469cb8953adde4a21876c6b8b2e81f03ecad2/cmake/afni_project_dependencies.cmake#L77

   https://github.com/afni/afni/blob/68e469cb8953adde4a21876c6b8b2e81f03ecad2/src/SUMA/CMakeLists.txt#L54

   https://github.com/afni/afni/blob/68e469cb8953adde4a21876c6b8b2e81f03ecad2/cmake/afni_project_dependencies.cmake#L163

#. Encapsulating code in functions, despite the weird scoping rules of
   the cmake language:

   https://github.com/afni/afni/blob/68e469cb8953adde4a21876c6b8b2e81f03ecad2/cmake/get_build_macros_and_functions.cmake#L38

#. Running build time checks on compiled binaries: TODO, would use
   add_custom_command:

#. Running build time check for missing symbols

   https://github.com/afni/afni/blob/68e469cb8953adde4a21876c6b8b2e81f03ecad2/cmake/FindGLw.cmake#L72

#. Building with OMP support:

   https://github.com/afni/afni/blob/68e469cb8953adde4a21876c6b8b2e81f03ecad2/src/ptaylor/CMakeLists.txt#L85

#. Modifying the toolchain to deal with switching compilers:

   https://github.com/afni/afni/blob/68e469cb8953adde4a21876c6b8b2e81f03ecad2/.circleci/config.yml#L391
