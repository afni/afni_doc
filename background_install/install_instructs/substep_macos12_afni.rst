

#. **Get+unpack AFNI binaries**::
    
     curl -O https://afni.nimh.nih.gov/pub/dist/bin/misc/@update.afni.binaries
     tcsh @update.afni.binaries -package macos_10.12_local -do_extras

#. Open a new terminal (or source current shell's "rc" file, as
   suggested in finishing text).

**Purpose:** Install AFNI binaries (in default ``~/abin`` location).

.. note:: Upon first ``afni`` or ``suma`` launch, the terminal will
          pop up messages to ask for permissions to access various
          data on your system, such as: Photos, Desktop, Contacts,
          Calendar, Reminders, Documents, Downloads.  I would
          recommend **not** allowing Photos, Contacts, Calendars, and
          Reminders.  But the others will be useful.

.. note:: And if you launch ``afni`` from your home folder, you will
          get a lot of "Operation not permitted" errors/warnings from
          ``afni`` trying to find datasets in restricted folders under
          your home directory, like ``~/Library`` etc. You can safely
          ignore those errors.
