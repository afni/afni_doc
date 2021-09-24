.. _install_steps_windows10:


**Windows 10: Windows Subsystem for Linux (WSL)**
===========================================================================

.. contents:: The essential system setup
   :local:

.. highlight:: none

What to do?
-----------

These setup instructions are for setting up Ubuntu on the **"Fall
Creators Update" (FCU) version of Windows 10**, known as the **Windows
Subsystem for Linux (WSL).** This FCU was released in Windows version
1709 around October, 2017.

See `this "What's New" page
<https://blogs.msdn.microsoft.com/commandline/2017/10/11/whats-new-in-wsl-in-windows-10-fall-creators-update/>`_
for more information about the Windows updates since their earlier
beta version of having Ubuntu.  Mainly, the present installation is a
lot easier now.  Yippee.

#. **The user must have admin privileges** (can run ``sudo ...``).
   Some steps require an internet connection.

Install Linux
-----------------------------------

1. | Click here to install **WSL 1** (*noooot WSL 2*), and probably
     select "Ubuntu 20.04" as your desired flavor of Linux:
   | `https://docs.microsoft.com/en-us/windows/wsl/install-manual
     <https://docs.microsoft.com/en-us/windows/wsl/install-manual>`_


.. older: this guides people to WSL 2, which is not very good at the moment

   1. | Click here to install WSL, selecting "Ubuntu" as your desired flavor
        of Linux:
      | `https://docs.microsoft.com/en-us/windows/wsl/install-win10
        <https://docs.microsoft.com/en-us/windows/wsl/install-win10>`_

.. _install_windows_VcXsrv:

Install VcXsrv Windows X Server
---------------------------------------------

1. | Click here to start automatic download:
   | `https://sourceforge.net/projects/vcxsrv/files/latest/download
     <https://sourceforge.net/projects/vcxsrv/files/latest/download>`_
   | Use default installation settings.  

#. *Now and forever,* **first** doubleclick on the VcXsrv icon on your
   Desktop, and **then** start Ubuntu, for example by typing "ubuntu"
   in the Windows search bar.  (Sorry, not our design!)

#. **To enable copy+paste ability in Ubuntu terminal,** right-click on
   the toolbar at the top of the Ubuntu terminal, and select
   "Properties"; in the Options tab, make sure the box next to
   "QuickEdit Mode" is selected.

   You can then paste into a terminal by either right-clicking or
   hitting the "Enter" key.  (To "copy" text that is *in* the
   terminal, just highlight it, and then you should be able to
   right-click to paste; to "copy" text from *outside* the terminal,
   you probably need to highlight it and hit "Ctrl+c".)

#. Copy+paste::

     echo "export DISPLAY=:0.0" >> ~/.bashrc
     echo "setenv DISPLAY :0.0" >> ~/.cshrc
     echo "export NO_AT_BRIDGE=1" >> ~/.bashrc
     echo "setenv NO_AT_BRIDGE 1" >> ~/.cshrc

   **Purpose:** First, set DISPLAY properly, so you can open GUIs like
   ``afni``, ``suma``, etc.  Then, avoid having some
   very-non-necessary GTK warnings from programs.
    
#. Close (exit) Ubuntu terminal, so that changes are effected the next
   time you open it.

More setup tips for Ubuntu+Windows
---------------------------------------------

1. Install Ubuntu terminal fonts as described `under "Bonus: Install
   the Ubuntu Font for a True Ubuntu Experience" on this page (waaay
   down)
   <https://www.howtogeek.com/249966/how-to-install-and-use-the-linux-bash-shell-on-windows-10/>`_.

#. | The default profile "use colors from system theme" shows an
     all-black terminal.  To adjust this to something nicer: 
   | Go to the terminal's menu bar,
   | Select the ``Edit`` tab, then ``Profile``, 
   | Turn **off** "use colors ...", and just pick a scheme+palette
     that you like.

#. | **Note:**
   | In gnome-terminal, things are similar to other Linux
     implementations. The middle button pastes whatever is
     highlighted in the WSL terminal or other gnome-terminal:
     ``shift-ctrl-c`` copies, and ``shift-ctrl-v`` also pastes.

Transferring data between Ubuntu and Windows 
---------------------------------------------

#. You can "see" your Windows file system from the Ubuntu side, where
   it appears as ``/mnt/c/``.  For example, if your Windows username
   is USERNAME, then the following would copy a file called FILE.pdf
   on your Windows Desktop to your current Ubuntu terminal location::

     cp /mnt/c/Users/USERNAME/Desktop/FILE.pdf .

#. To mount external devices (e.g., a USB) from the Ubuntu side.
   Let's say your external device appears as the "G:" drive on Windows
   when you plug it into a USB port.  You could mount that drive from
   Ubuntu as follows::

     sudo mkdir /mnt/g                # make a mount point location; 'g' is a convenient label here
     sudo mount -t drvfs G: /mnt/g    # mount the external drive to it

   If you had a file FILE.nii on the "G:" drive USB, you could now
   copy it to your present location with::

     cp /mnt/g/FILE.nii .

   **To safely unmount the USB before unplugging it**, type::

     sudo umount /mnt/g

   *Bonus note:* you can mount/unmount network shares in a similar way::

     sudo mkdir /mnt/share
     sudo mount -t drvfs '\\server\share' /mnt/share

     ...

     sudo umount /mnt/share

Install prerequisite: AFNI and package dependencies
----------------------------------------------------

0. Start a new Ubuntu session.  To check your version, copy+paste::

     lsb_release -a

#. For ... 

   * | *... Ubuntu 20.04 users,* follow the setup instructions
       through "Make AFNI/SUMA profiles" here:
     | :ref:`Link to Ubuntu 20 setup instructions for AFNI <install_steps_linux_ubuntu20>`

   * | *... Ubuntu 18.04 users,* follow the setup instructions
       through "Make AFNI/SUMA profiles" here:
     | :ref:`Link to Ubuntu 18 setup instructions for AFNI <install_steps_linux_ubuntu18>`

   * | *... Ubuntu 16.04 users,* follow the setup instructions
       through "Make AFNI/SUMA profiles" here:
     | :ref:`Link to Ubuntu 16 setup instructions for AFNI <install_steps_linux_ubuntu16>`

   **Purpose:** Complete your life's ambition to have working AFNI on
   your Windows computer (though, realize it is Linux that makes this
   happen!).

.. ---------- HERE/BELOW: copy for all installs --------------

Setup Python (opt)
---------------------------------

.. include:: substep_miniconda.rst

Prepare for Bootcamp
--------------------

.. include:: substep_bootcamp.rst

Evaluate setup/system (important!)
----------------------------------

.. include:: substep_evaluate.rst

Niceify terminal (optional, but goood)
--------------------------------------

.. include:: substep_rcfiles.rst

Install extras (optional, but recommended for Bootcamp prep)
-----------------------------------------------------------------

.. include:: substep_extra_packs.rst

Keep up-to-date (remember!)
---------------------------

.. include:: substep_update.rst

.. figure:: media/AFNI_on_Windows10_2ways.jpg
   :align: center
   :figwidth: 70%
   :name: media/AFNI_on_Windows10_2ways.jpg
   


