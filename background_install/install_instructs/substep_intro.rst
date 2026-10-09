.. NTS:
   This file is basically the intro for Linux files. 

0. **Each step** involves either copy+pasting a command or clicking
   on a download link.

#. **Copy and paste:** In most terminals, use ``Ctrl+Shift+c`` and
   ``Ctrl+Shift+v``.  (In WSL terminals, one might first enable this
   functionality: rightclick on the panel's taskbar, select
   "Properties" and put a checkmark by this option.)

#. **Admin privileges:** can you run ``sudo ls`` and enter the correct
   password?  If you can't, ask an administrator to do the steps that
   start with `sudo`, and you can do the rest.

#. **Terminal type:** To see your terminal shell type (``bash``,
   ``zsh``, ``tcsh``, etc.), run this command::

     echo $0

#. **Installation check:** Run the system check in the "Evaluate"
   stage.  **Try** any recommendations in its "Please Fix" section.

#. **Getting help:** if you run into any problems, please just ask a
   clear question on the `AFNI Message Board
   <https://discuss.afni.nimh.nih.gov/>`_.


#. **To open a text file,** use any text editor you like, and/or you
   can type ``gedit FILENAME``, such as either::

     gedit ~/.bashrc 

     gedit ~/.bashrc &
