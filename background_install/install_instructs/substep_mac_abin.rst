
1. For ...:

   * *... (default) installing the binaries from online*, copy+paste::

       cd
       curl -O https://afni.nimh.nih.gov/pub/dist/bin/misc/@update.afni.binaries
       tcsh @update.afni.binaries -package macos_10.12_local -do_extras

   * *... (alternative) installing already-downloaded binaries,* you
     can use ``-local_package ..`` (replace "PATH_TO_FILE" with the
     actual path; also, if ``@update.afni.binaries`` has also been
     downloaded, you can skip the ``curl ..`` command), copy+paste::

       cd
       curl -O https://afni.nimh.nih.gov/pub/dist/bin/misc/@update.afni.binaries
       tcsh @update.afni.binaries -local_package PATH_TO_FILE/macos_10.12_local.tgz -do_extras

   **Purpose:** Download and unpack the current binaries in your
   ``$HOME`` directory; set the AFNI binary directory name to
   ``$HOME/abin/``; and add that location to the ``$PATH`` in both
   ``~/.cshrc`` and ``~/.bashrc``.  This command also sets up default
   ``~/.afnirc`` and ``~/.sumarc`` profiles and environment variables.
