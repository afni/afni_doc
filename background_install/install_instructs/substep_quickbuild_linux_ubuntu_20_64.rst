
This is the quick form of AFNI setup for this OS.  It includes
downloading the Bootcamp data and running the system check (so don't
forget to check that!).  You can read each of the downloaded scripts
to see what each does, which might be educational.


#. **Download the command scripts.** Copy+paste:

   .. code-block:: none

      cd
      curl -O https://raw.githubusercontent.com/afni/afni/master/src/other_builds/OS_notes.linux_ubuntu_20_64_a_admin.txt
      curl -O https://raw.githubusercontent.com/afni/afni/master/src/other_builds/OS_notes.linux_ubuntu_20_64_b_user.tcsh
      curl -O https://raw.githubusercontent.com/afni/afni/master/src/other_builds/OS_notes.linux_ubuntu_20_64_c_nice.tcsh

#. **Run command scripts.**

   Check your shell (``echo $0``), and following instructions for
   either bash or csh/tcsh users below.  Each stores the terminal
   output in a text file, ``o.ubuntu*.txt``, which you can provide to
   an AFNI guru for troubleshooting.

   *For bash users:* 

   A. Copy+paste the following, which **requires** having ``sudo
      privilege`` (an admin password)::

        sudo bash OS_notes.linux_ubuntu_20_64_a_admin.txt 2>&1 | tee o.ubuntu_20_a.txt

   #. Copy+paste the following (**no** ``sudo``)::

        tcsh OS_notes.linux_ubuntu_20_64_b_user.tcsh 2>&1 | tee o.ubuntu_20_b.txt

   #. To niceify your terminal (optional, but useful), copy+paste the
      following (**no** ``sudo``)::

        tcsh OS_notes.linux_ubuntu_20_64_c_nice.tcsh 2>&1 | tee o.ubuntu_20_c.txt

   *For tcsh or csh users:* 

   A. Copy+paste the following, which **requires** having ``sudo
      privilege`` (an admin password)::

        sudo bash OS_notes.linux_ubuntu_20_64_a_admin.txt |& tee o.ubuntu_20_a.txt

   #. Copy+paste the following (**no** ``sudo``)::

        tcsh OS_notes.linux_ubuntu_20_64_b_user.tcsh |& tee o.ubuntu_20_b.txt

   #. To niceify your terminal (optional, but useful), copy+paste the
      following (**no** ``sudo``)::

        tcsh OS_notes.linux_ubuntu_20_64_c_nice.tcsh |& tee o.ubuntu_20_c.txt


#. **Evaluate/check the setup**

   |

   A. Open a new terminal, and run the AFNI system check to verify installation::

        afni_system_check.py -check_all

      | **Read** the "Please Fix" section at the bottom, to see if
        setup is complete.  If there are suggested fixes, please do
        those and re-run the system check.  Ask any questions on the
        `Message Board
        <https://afni.nimh.nih.gov/afni/community/board/>`_
      |
        
   #. Open up the AFNI and SUMA GUIs, juuuust to make sure all is well::
   
        afni
        suma

      | Report any crashes!  Otherwise, you are all set.
      |

