
1. Copy+paste::

     curl -O https://afni.nimh.nih.gov/pub/dist/edu/data/CD.tgz
     tar xvzf CD.tgz
     cd CD
     tcsh s2.cp.files . ~
     cd ..

   **Purpose:** Download the Bootcamp class data; untar+unzip it (= open
   it up); move into the newly opened directory; execute a script to copy
   the files to ``$HOME/.``.

   If no errors occur in the above, and your ``afni_system_check.py``
   says things are OK, you can delete/remove the tarred/zipped package,
   using "``rm CD.tgz``".  If you are *really* confident, you can also
   deleted the CD/ directory in the present location.

#. Read+practice with the handy :ref:`Unix documentation/tutorial
   <U_misc_bg0>`.

   **Purpose:** give you a quick lesson/refresher on using basic Linux
   shell commands (e.g., `ls`, `cd`, `less`, etc.). It will *greatly*
   enhance your bootcamp experience-- we promise!

#. **Pro tip:** If you will be attending a Bootcamp, you might want to
   bring a mouse to use with your laptop. It will be easier to follow
   the demos using a mouse than a trackpad.
