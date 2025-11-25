
This is the quick form of AFNI setup for Ubuntu 24.04.  It includes
downloading the Bootcamp data and running the system check (don't
forget to do that!).


#. **Download the command scripts.** 

   Copy+paste:

   .. code-block:: none

      cd
      curl -O https://raw.githubusercontent.com/afni/afni/master/src/other_builds/OS_notes.linux_ubuntu_24_64_a_admin.txt
      curl -O https://raw.githubusercontent.com/afni/afni/master/src/other_builds/OS_notes.linux_ubuntu_24_64_b_user.tcsh
      curl -O https://raw.githubusercontent.com/afni/afni/master/src/other_builds/OS_notes.linux_ubuntu_24_64_c_nice.tcsh

   | Feel free to read any of these, for educational purposes.
   |


#. **Run command scripts.**

   Check your shell (``echo $0``), and use the appropriate set of
   commands below.  Running the commands this way creates a text file,
   ``o.ubuntu*.txt``, which can be sent to an AFNI guru for
   troubleshooting, if necessary.

   *For bash users:* 

   A. Copy+paste the following (**requires** ``sudo`` with password)::

        sudo bash OS_notes.linux_ubuntu_24_64_a_admin.txt 2>&1 | tee o.ubuntu_24_a.txt

   #. Copy+paste the following (**no** ``sudo``)::

        tcsh OS_notes.linux_ubuntu_24_64_b_user.tcsh 2>&1 | tee o.ubuntu_24_b.txt

   #. (optional, but useful) To niceify your terminal, copy+paste the
      following (**no** ``sudo``)::

        tcsh OS_notes.linux_ubuntu_24_64_c_nice.tcsh 2>&1 | tee o.ubuntu_24_c.txt

   *For tcsh or csh users:* 

   A. Copy+paste the following (**requires** ``sudo`` with password)::

        sudo bash OS_notes.linux_ubuntu_24_64_a_admin.txt |& tee o.ubuntu_24_a.txt

   #. Copy+paste the following (**no** ``sudo``)::

        tcsh OS_notes.linux_ubuntu_24_64_b_user.tcsh |& tee o.ubuntu_24_b.txt

   #. (optional, but useful) To niceify your terminal, copy+paste the
      following (**no** ``sudo``)::

        tcsh OS_notes.linux_ubuntu_24_64_c_nice.tcsh |& tee o.ubuntu_24_c.txt


#. **Evaluate/check the setup**

   |

   A. Open a new terminal, and run the AFNI system check::

        afni_system_check.py -check_all

      | **Read** the "Please Fix" section at the bottom, to see if
        setup is complete.  
      | **If** there are suggested fixes, please do
        those and re-run the system check.  
      | **Ask** any questions on the
        `Message Board
        <https://discuss.afni.nimh.nih.gov/>`__
      |
        
   #. Open up the AFNI and SUMA GUIs, juuuust to make sure all is
      well::
   
        afni
        suma

      | Report any crashes!  Otherwise, you are all set.
      |

