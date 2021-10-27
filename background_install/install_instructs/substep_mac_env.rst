
#. Copy+paste the following::

     touch ~/.cshrc
     echo 'if ( $?DYLD_LIBRARY_PATH ) then' >> ~/.cshrc
     echo '  setenv DYLD_LIBRARY_PATH ${DYLD_LIBRARY_PATH}:/opt/X11/lib/flat_namespace' >> ~/.cshrc
     echo 'else' >> ~/.cshrc
     echo '  setenv DYLD_LIBRARY_PATH /opt/X11/lib/flat_namespace' >> ~/.cshrc
     echo 'endif' >> ~/.cshrc

     touch ~/.bashrc
     echo 'export DYLD_LIBRARY_PATH=${DYLD_LIBRARY_PATH}:/opt/X11/lib/flat_namespace' >> ~/.bashrc

   **Purpose:** This adjusts the library format variable for XQuartz
   in both ``tcsh`` and ``bash``.  Sigh.
