

.. comment:
   This old set of 3 steps seems to be replaced by the new, single one 

    #. Copy+paste::

         bash

    #. Copy+paste::

         ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null 2> /dev/null

    #. Copy+paste::

       exit

#. Copy+paste::

     /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

#. Copy+paste::

     brew install netpbm

**Purpose:** Install "netpbm", which has functionality for converting
image formats (such as to PNG) and is used in several programs like
``@snapshot_volreg``, ``@chauffeur_afni`` and others.  Uses the
package manager ``homebrew`` to do the installation.
