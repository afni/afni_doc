

Copy+paste::

  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

Copy+paste::

  brew update

Copy+paste::

  brew install  libpng jpeg expat freetype fontconfig openmotif  \
                libomp libxt gsl glib pkg-config gcc

**Purpose:** Install the Homebrew package manager and then use it to
install some necessary dependencies (for ``gcc``, ver=10 is used here
by default, though actually at the moment ``gcc`` is just Mac's
``clang``).
