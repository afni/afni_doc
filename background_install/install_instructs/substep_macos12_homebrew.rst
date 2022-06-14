
Do *not* use ``sudo`` explicitly with any of these commands.  However,
some *will* prompt you for your admin password).
    
#. **Homebrew**::

     cd
     /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

#. **Privacy Setting** (opt)::

     brew analytics off

#. **Packages**::
    
     brew install python netpbm cmake

#. **XQuartz**::
    
    brew install --cask xquartz

#. **Reboot/restart** your computer (for changes to take effect).

|

.. note:: **XQuartz Suggestion**

    After you restart, open XQuartz and change a preference.  Go to
    the XQuartz menu near the upper left corner of the desktop.  Then
    go to Preferences... -> Windows -> "Click-through Inactive
    Windows".  Also "Focus On New Windows" may be useful.

**Purpose:** Homebrew will install the Xcode command line tools first.
macOS 12.3.1 removed ``python``, so we are installing it here.
``netpbm`` is needed for some image outputs.  ``cmake`` is needed for
compiling some R libraries.  Xquartz is the main desktop manager for
X11 programs like ``afni``.
