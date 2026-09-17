.. _devdocs_cmake:

##########################################
CMake builds for AFNI developers
##########################################

.. contents:: :local:

.. default-role:: literal

This page describes the CMake build as it exists in the AFNI source
repository.  It is for contributors who are compiling, testing, or extending
AFNI; it is not a replacement for normal user-installation instructions.

AFNI has two maintained build systems.  CMake is the preferred system for new
development work.  The traditional Makefile system remains important: it is
used for established platform-specific builds and as a reference when the two
systems' compiled-target inventories are compared.


Build systems and their roles
=============================

The traditional build is configured *in* `src/`.  A developer selects a
platform Makefile, copies it to `src/Makefile`, edits compiler, library-path,
and installation settings as needed, and invokes targets such as `make
vastness`.  Platform Makefiles and the shared `Makefile.INCLUDE` explicitly
carry many compiler flags and library names.

The CMake build is configured *out of source*.  CMake detects the selected
compiler and platform, discovers or builds dependencies, and writes a backend
build system (usually Ninja or Unix Makefiles) into a separate build directory.
It also records linking, installation, and dependency information on individual
targets.  Do not mix the two systems in one directory: use a fresh CMake build
directory instead of placing CMake output in `src/`.

For new code, add the CMake definition and retain the corresponding Makefile
entry when the program belongs to the legacy build.  AFNI's CMake configuration
checks its expected installed targets against the package-component list and
reports the difference from the legacy Makefile target list.


How the CMake project is organized
==================================

The build starts at `CMakeLists.txt` in the AFNI repository root::

   CMakeLists.txt
       |-- cmake/afni_cmake_build_options.cmake
       |-- cmake/afni_project_dependencies.cmake
       |-- doc/
       |-- src/
       |     |-- core libraries and ordinary binaries
       |     |-- X11/AFNI GUI targets and plugins
       |     |-- SUMA targets
       |     |-- tcsh, Python, and R scripts
       |-- tests/
       `-- packaging/installation_components.txt

`cmake/afni_cmake_build_options.cmake` defines the public configuration
switches and installation locations.  `cmake/afni_project_dependencies.cmake`
finds system packages, selects in-tree dependencies, and uses `FetchContent`
where AFNI can download a dependency.  The project-wide target helpers live in
`cmake/get_build_macros_and_functions.cmake`.  In particular,
`add_afni_executable()`, `add_afni_library()`, and `add_afni_plugin()`
register targets for installation and expected-target checks.

Within `src/`, ordinary non-GUI executables are primarily registered in
`CMakeLists_binaries.txt`; X-dependent executables in
`CMakeLists_x_dependent.txt`; and plugins in `CMakeLists_plugins.txt`.
Subsystems with their own target graph, such as `SUMA`, `niml`, and
`python_scripts`, have their own `CMakeLists.txt` files and are added by
`src/CMakeLists.txt`.


Quick start: full developer build
=================================

Install CMake, a C and C++ compiler, Ninja (recommended), and the development
packages required by the features you plan to build.  The minimum CMake version
is declared by the root `CMakeLists.txt`; use a current CMake where possible.

AFNI expects `CC` and `CXX` to identify the compiler pair during its first
configuration.  Set them before creating a build directory.  Changing a
compiler, generator, architecture, or toolchain afterwards requires a new build
directory (or a deliberate cache reset), not merely another build command.

The following is an explicit full-suite developer configuration.  It enables
every normal program family, R statistics, Python and tcsh scripts, OpenMP,
tests, and all plugins.  It deliberately does *not* download distribution
atlases; see :ref:`devdocs_cmake_atlases`.

::

   cd /path/to/afni
   CC="$(command -v gcc)" CXX="$(command -v g++)" \
   cmake -S . -B build/full -G Ninja \
     -DCMAKE_BUILD_TYPE=RelWithDebInfo \
     -DCMAKE_INSTALL_PREFIX="$PWD/install" \
     -DCOMP_COREBINARIES=ON \
     -DCOMP_GUI=ON -DCOMP_PLUGINS=ON -DCOMP_ALL_PLUGINS=ON \
     -DCOMP_SUMA=ON -DCOMP_TCSH=ON -DCOMP_PYTHON=ON \
     -DCOMP_RSTATS=ON \
     -DUSE_OMP=ON -DENABLE_TESTS=ON

   cmake --build build/full --parallel
   cmake --install build/full

`RelWithDebInfo` is a useful developer default.  Choose `Debug` for debugging
or `Release` for an optimized local build.  `cmake --build` is portable across
Ninja and Makefile generators; `--parallel` lets CMake choose a suitable
parallel build count.  A specific target can be built with, for example,
`cmake --build build/full --target 3dDeconvolve`.

If you do not need R, omit `-DCOMP_RSTATS=ON`.  R is disabled by default
because it requires a discoverable R installation.  Likewise, build only the
core C libraries with `-DCOMP_CORELIBS_ONLY=ON`.  Component options are
dependency-aware: disabling the GUI also disables its plugins and SUMA.

The compiler guard can be bypassed with `-DAFNI_COMPILER_CHECK=OFF`, but
setting a real compiler pair is preferred.  Use that bypass only when a
toolchain file has already established the compilers.


Build output, installation, and tests
=====================================

Compiled executables and libraries are written to `targets_built` inside the
build directory.  This permits direct development use, for example::

   ./build/full/targets_built/afni

Shell and R scripts remain in the source tree until installation.  The Python
part of the project has a development-install step by default so that the
`pytest` target can use the selected Python interpreter and AFNI's Python
package.  That step needs `setuptools` in that interpreter.  Set
`-DSTANDARD_PYTHON_INSTALL=OFF` when that behavior is inappropriate for a
particular build.

To exercise AFNI's in-tree test setup, use::

   cmake --build build/full --target pytest

The target rebuilds AFNI as needed and sets `PATH` so tests see compiled
binaries plus source-tree scripts.  Test selection can be passed through the
`ARGS` environment variable, for example::

   ARGS='scripts --workers 3 -k mask' \
     cmake --build build/full --target pytest

Use `cmake --install build/full` to install at the configured prefix.  A
staged package-style installation can be made without changing that prefix::

   DESTDIR="$PWD/stage" cmake --install build/full

Choose an explicit `CMAKE_INSTALL_PREFIX` for developer builds.  CMake's
default is normally `/usr/local`.


Configuration reference
=======================

The component switches select what AFNI builds and installs:

`COMP_CORELIBS_ONLY`
   Build only the foundational C libraries and models.

`COMP_COREBINARIES`
   Build the large set of non-GUI C executables.

`COMP_GUI`, `COMP_PLUGINS`, `COMP_ALL_PLUGINS`
   Build the AFNI X11 GUI, its plugin framework, and respectively the complete
   plugin set.  Plugins currently require the GUI.

`COMP_SUMA`
   Build SUMA and other OpenGL-dependent programs.  Requires `COMP_GUI`.

`COMP_TCSH`, `COMP_PYTHON`, `COMP_RSTATS`
   Install tcsh scripts, manage AFNI's Python package/scripts, and install
   R-based statistics programs.  The R component is off by default.

`COMP_ATLASES`
   Fetch and install AFNI distribution data and atlases.  This is opt-in and
   requires extra command-line tools and network access.

`ENABLE_TESTS` and `RUN_PLUGIN_CHECK`
   Enable the CTest tree and, respectively, build an additional link-time
   plugin-symbol check.

`CMAKE_BUILD_TYPE`, `CMAKE_INSTALL_PREFIX`, and `BUILD_SHARED_LIBS`
   Select build optimization/debugging, the install tree, and shared-library
   behavior.  AFNI defaults to a Debug build type if none is specified.

`USE_OMP`
   Request OpenMP.  If it is not specified, AFNI enables it only when CMake
   finds a working C OpenMP implementation.  Explicitly requesting it without
   a usable runtime is an error.

`COMP_INSTALL_RESTRICTED_LIST`
   Install only selected already-built components, for packaging workflows.
   It does not turn on the corresponding build components.

.. _devdocs_cmake_atlases:

Atlases and distribution data
-----------------------------

`COMP_ATLASES=ON` is intentionally separate from the normal full build.  At
configuration time AFNI requires `datalad` and `rsync`; the build then uses
DataLad to obtain AFNI's distribution data.  Enable it only when producing or
testing an installation that must contain these data::

   cmake -S . -B build/with-atlases -G Ninja \
     -DCOMP_ATLASES=ON ...


Where dependencies enter the build
==================================

The following table maps AFNI's top-level dependency decisions.  It points
developers to the place to modify when adding a dependency or diagnosing why an
optional feature changed the configure result.

.. list-table:: CMake dependency map
   :header-rows: 1
   :widths: 25 35 40

   * - Build condition
     - Dependencies
     - Mechanism and location
   * - Always
     - Zlib; Python 3.6+ interpreter; f2c support
     - Zlib and Python are required through `find_package`.
       `src/f2c` is selected through AFNI's `optional_bundle` helper.
   * - OpenMP requested or available
     - C OpenMP runtime
     - `find_package(OpenMP COMPONENTS C)`; `USE_OMP` is derived from the
       result unless explicitly set.
   * - Non-core build
     - QHull; dcm2niix
     - QHull can be system-provided or built from `src/qhulldir`.  AFNI's
       dcm2niix source is added from `src/crorden` when appropriate.
   * - AFNI GUI
     - X11, Motif, JPEG, XmHTML
     - X11, Motif, and JPEG are found as system dependencies.  XmHTML is
       selected as a system dependency or AFNI's in-tree source.
   * - SUMA
     - OpenGL/XQuartzGL, GLUT, GLib2, GSL, GLw, GTS
     - Linux and other non-macOS builds use OpenGL and may build GLUT in-tree;
       macOS uses XQuartzGL.  GTS can be a system package or fetched with
       `FetchContent`.  The default GLw handling avoids system GLw because
       common system versions are incompatible with AFNI's needs.
   * - R statistics
     - R headers and libraries
     - AFNI's `FindLibR.cmake` runs only when `COMP_RSTATS=ON`.
   * - AFNI data formats
     - NIFTI and GIFTI libraries
     - Use system packages when requested; otherwise CMake fetches and builds
       `nifti_clib` and `gifti_clib`.
   * - Atlas installation
     - DataLad and rsync
     - Checked when `COMP_ATLASES=ON`; DataLad obtains the data at build time.

`USE_SYSTEM_ALL` provides a coarse policy for several optional dependencies.
Individual `USE_SYSTEM_*` cache variables override the policy for applicable
libraries.  Use the system route for a controlled environment where all
development packages are installed.  Use AFNI's bundled/fetched route when a
specific library is absent or unsuitable.  This is a configuration decision:
after changing it, rerun CMake so it can regenerate the target graph.

`FetchContent` can require network access on the first configuration.  For
offline or reproducible builds, pre-populate a source checkout and point CMake
at it with the relevant `FETCHCONTENT_SOURCE_DIR_*` variable, or use the
corresponding system library.  Inspect the declarations in
`cmake/afni_project_dependencies.cmake` for the current dependency names and
revisions.


macOS CMake builds
==================

macOS builds need three decisions made in order: select a compiler/toolchain,
allow CMake to discover matching dependencies, then select AFNI components.
Choose the toolchain before CMake's first `project()` call; do not change it
inside an existing build tree.

For Apple Silicon, AFNI provides current Homebrew GCC and Homebrew LLVM
toolchain files under `cmake/`.  With Xcode command-line tools, XQuartz,
Homebrew dependencies, and Ninja available, a typical GCC build is::

   cd /path/to/afni
   cmake -S . -B build/macos-arm64 -G Ninja \
     -DCMAKE_TOOLCHAIN_FILE=cmake/macos_homebrew_gcc13_arm64_toolchain.cmake \
     -DAFNI_HOMEBREW_GCC_VERSION=13 \
     -DCOMP_COREBINARIES=ON \
     -DCOMP_GUI=ON -DCOMP_PLUGINS=ON -DCOMP_SUMA=ON \
     -DCOMP_TCSH=ON -DCOMP_PYTHON=ON
   cmake --build build/macos-arm64 --parallel

The GCC toolchain accepts another installed Homebrew GCC version through
`AFNI_HOMEBREW_GCC_VERSION`.  The analogous LLVM build replaces the toolchain
path with `cmake/macos_homebrew_llvm_arm64_toolchain.cmake`.  For AppleClang,
set `CC=/usr/bin/clang` and `CXX=/usr/bin/clang++` before configuration;
set `CMAKE_OSX_ARCHITECTURES=arm64` as well when building under Rosetta or
cross-compiling.

SUMA on macOS uses XQuartz for X11 and GLUT.  AFNI's macOS dependency hints add
Homebrew search prefixes and, for Apple Silicon SUMA builds, can discover Mesa
and mesa-glu.  Set `AFNI_MESA_ROOT` and `AFNI_GLU_ROOT` explicitly if the
automatic Homebrew locations are unsuitable.  AppleClang requires Homebrew's
`libomp` to build with `USE_OMP=ON`; otherwise configure with
`-DUSE_OMP=OFF`.  Homebrew LLVM supplies its own OpenMP runtime.

Set `CMAKE_OSX_DEPLOYMENT_TARGET` before the first configure only when you
need a specific minimum macOS release.  It must be compatible with every
Homebrew library linked by the build.  The toolchain files choose a suitable
default from the active SDK for their local-development use case.

For detailed ARM guidance, dependency discovery, and distribution caveats, see
`AFNI's macOS arm64 CMake notes
<https://github.com/afni/afni/blob/master/cmake/README.macos-arm64.md>`__.


.. _devdocs_cmake_mod_targ:

Adding a program, library, or plugin
====================================

Adding a C or C++ target has four parts: put its declaration in the correct
CMake file, express its dependencies, assign its installation component, and
verify its result against the existing build systems.

.. _devdocs_cmake_add_targ:

1. Choose the target definition file
------------------------------------

Use `src/CMakeLists_binaries.txt` for a normal executable,
`src/CMakeLists_x_dependent.txt` for an X-dependent executable, and
`src/CMakeLists_plugins.txt` for a plugin.  If the new code is a coherent
subsystem, create a local `CMakeLists.txt` and add it from
`src/CMakeLists.txt`.  Follow nearby examples, especially where a program
uses object libraries or sources from more than one directory.

2. Register the target with AFNI's wrapper
------------------------------------------

For a simple new executable in `src/new_exec.c`::

   add_afni_executable(my_new_binary new_exec.c)
   target_link_libraries(my_new_binary
     PRIVATE
       AFNI::mri
       NIFTI::nifti2
       m
   )

Use `add_afni_library()` for an AFNI library and `add_afni_plugin()` for a
runtime AFNI plugin.  The wrappers set AFNI-specific link behavior and arrange
installation.  AFNI libraries have aliases such as `AFNI::mri`; use those
targets rather than constructing `-l` flags by hand.

Declare dependencies with `target_link_libraries()`,
`target_include_directories()`, `target_compile_definitions()`, and
`target_compile_options()` on the target that needs them.  Use `PRIVATE`
when a dependency is an implementation detail.  Use `PUBLIC` only when
consumers of a library must also inherit its headers, compile definitions, or
link requirements.  Prefer imported CMake targets such as `NIFTI::nifti2` to
unstructured library variables whenever the dependency provides one.

If an external package is new to AFNI, add its discovery at the appropriate
feature gate in `cmake/afni_project_dependencies.cmake` before linking it.
Use a maintained CMake find module where available; otherwise add an AFNI
`Find<Package>.cmake` module under `cmake/`.  Do not rely on a bare linker
name happening to work on one developer's machine.

3. Assign the installation component
------------------------------------

Add the target and component to `packaging/installation_components.txt`, for
example::

   my_new_binary, corebinaries

Valid component categories reflect the feature partition: `corelibs`,
`corebinaries`, `gui`, `suma`, `plugins`, `python`, `tcsh`, and
`rstats`.  The target wrapper uses this mapping to choose the CMake install
component.  The mapping is also a safety check: an unmapped compiled target
causes a configuration error.  The mapping can be regenerated for packaging
workflows with `packaging/define_installation_components.py`, but review its
output rather than treating it as a substitute for assigning the correct
feature family.

4. Verify the target and build parity
-------------------------------------

Reconfigure after changing a `CMakeLists.txt` file, then build the exact
target and run its help or focused test::

   cmake -S . -B build/full
   cmake --build build/full --target my_new_binary
   ./build/full/targets_built/my_new_binary -help

At configuration, AFNI compares targets registered by CMake with
`packaging/installation_components.txt`.  It also obtains legacy target
lists from `src/Makefile.INCLUDE` and prints a Make-versus-CMake difference
report.  Treat a parity failure as a prompt to update the right target list or
component.  `REMOVE_BUILD_PARITY_CHECKS=ON` is an internal temporary
diagnostic escape hatch, not a normal solution for a new target.


Traditional Makefile build in brief
===================================

The Makefile system remains the reference for legacy target coverage and for
some release environments.  From `afni/src`, choose the platform definition
closest to the host, copy it to `Makefile`, inspect values such as
`INSTALLDIR`, compiler commands, library paths, OpenMP flags, and SUMA
settings, and then run the intended target.  The repository README identifies
`make vastness` as the traditional full build target; individual Makefiles
and `Makefile.INCLUDE` determine exactly which programs that includes.

Unlike CMake, the Makefile setup does not centrally discover dependencies or
preserve configuration in an isolated build directory.  That is why CMake is
usually the more convenient choice for new development.  Do not remove legacy
Makefile entries merely because a CMake target has been added: CMake's parity
report is useful only while both target inventories remain meaningful.


Troubleshooting and useful references
======================================

Most CMake configure failures are missing development dependencies, an
incompatible compiler/runtime pair, or a stale cache.  Read the first relevant
`find_package` failure, then either install the required system development
package or select an AFNI bundled/fetched alternative where one exists.  If the
compiler, generator, architecture, or toolchain changed, remove only the
specific build directory and configure again.

Useful source references are:

* `AFNI CMake entry point <https://github.com/afni/afni/blob/master/CMakeLists.txt>`__
* `Build options <https://github.com/afni/afni/blob/master/cmake/afni_cmake_build_options.cmake>`__
* `Dependency configuration <https://github.com/afni/afni/blob/master/cmake/afni_project_dependencies.cmake>`__
* `AFNI target helpers <https://github.com/afni/afni/blob/master/cmake/get_build_macros_and_functions.cmake>`__
* `Current macOS ARM guidance <https://github.com/afni/afni/blob/master/cmake/README.macos-arm64.md>`__
* `CI macOS build <https://github.com/afni/afni/blob/master/.circleci/config.yml>`__
