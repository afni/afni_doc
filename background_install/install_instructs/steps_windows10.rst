.. _install_steps_windows10:


**Windows 10: Windows Subsystem for Linux (WSL)**
===========================================================================

.. contents:: The essential system setup
   :local:

.. highlight:: none

These setup instructions are for setting up Ubuntu on **Windows 10**,
through **Windows Subsystem for Linux (WSL).** 


Things to note before starting
---------------------------------

0. **Each step** involves either copy+pasting a command, or clicking
   on a download link.

#. **Admin privileges** are needed for some steps: check if you can
   run ``sudo ls``, entering the correct password.  If you can't,
   perhaps ask an administrator to do that step, and you can do the
   others that don't require it.

#. **If** you run into any problems, please just ask a clear question on
   the `AFNI Message Board
   <https://discuss.afni.nimh.nih.gov/>`_.



Install Linux
-----------------------------------

1. | Click here to install **WSL 1** (*noooot WSL 2*), and probably
     select "Ubuntu 20.04" as your desired flavor of Linux:
   | `https://docs.microsoft.com/en-us/windows/wsl/install-manual
     <https://docs.microsoft.com/en-us/windows/wsl/install-manual>`_
   | We list the same steps below, with some (possibly helpful) additional
     comments.
     

   **NB:** It may not be possible to run Windows PowerShell while the
   OS is in "S mode".  Since the PowerShell is needed to install WSL,
   you might have to leave S mode to be able to have Linux on current
   Windows 10.  It may not be possible to re-enter S mode once you
   leave, so please be aware of this choice.

   **How to switch out of S mode** *if you want*:

     Windows Start Menu key -> Settings (or gear icon) -> Update &
     Security -> Activation (in left panel) -> under "Switch to
     Windows 10 Home" select the "Go to the Store" link by the
     shopping bag -> Select the "Get" button under "Switch out of S
     mode".

   **Step 1: Enable the Windows Subsystem for Linux**

      | Open PowerShell *as as administrator*:
      | ``WinKey+r`` -> type "powershell" -> ``Ctrl+Shift+Enter`` ->
        select "Yes" to make changes to your computer
      | \.\.\. and the top bar of the terminal that opens should have
        "Administrator: Windows PowerShell"
      
      | Copy the terminal text:

        .. code::

           dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

      | To be able to paste into the PowerShell terminal: right click
        on PowerShell top bar -> Properties -> under "Options" tab and
        "Edit Options" box, put a check next to "Use Ctrl+Shift+C/V as
        Copy/Paste".  After this, you can use ``Ctrl+Shift+c`` to
        paste the above ``dism.exe ...`` command; then hit ``Enter``
        to run it.

   **Restart Windows device**

   *(jump to)* **Step 6: Install your Linux distribution of choice**

      | Select ``Ubuntu 20.04 LTS``.
      | On next page, click "Get" button under Ubuntu 20.04 LTS.
      | Click on "Install" when asked.
      | Click on "Launch" when asked.

      | Wait for the the installation to finish.
      
      | Create a user account (``UNIX username``) and password when
        prompted in the terminal.

   *Congratulations, Phase One of installation is complete, but there
   is more to go\.\.\.*

   Close the terminal before proceeding to the next step.



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
   | Click/open the downloaded ``vcxsrv*.exe``, and allow permissions
     for it.
   | Use default installation settings.  
   | When the installer finishes, you should have a new ``XLaunch``
     icon on your desktop
   |

#. | *Now and forever when you want to run the WSL terminal:* 
   | **First** doubleclick on the VcXsrv/XLaunch icon
     on your Desktop
   | Select "Next" for all prompts, and then "Finish".
   | **Then** start Ubuntu, for example by selecting WinKey -> Ubuntu,
     or by searching for "Ubuntu" in the search bar. (After opening,
     you can rightclick on the icon that appears in the bottom panel,
     and select "Pin to taskbar", to be able to select more quickly.)
   | *Sorry, this is not our design!*
   |

#. **To enable copy+paste ability in Ubuntu terminal,** right-click on
   the toolbar at the top of the Ubuntu terminal, and select
   "Properties"; in the Options tab, make sure the box next to
   "QuickEdit Mode" is selected.

   | You can then paste into a terminal by either right-clicking or
     hitting the "Enter" key.  (To "copy" text that is *in* the
     terminal, just highlight it, and then you should be able to
     right-click to paste; to "copy" text from *outside* the terminal,
     you probably need to highlight it and hit "Ctrl+c".)
   |

#. Copy+paste::

     echo "export DISPLAY=:0.0" >> ~/.bashrc
     echo "setenv DISPLAY :0.0" >> ~/.cshrc
     echo "export NO_AT_BRIDGE=1" >> ~/.bashrc
     echo "setenv NO_AT_BRIDGE 1" >> ~/.cshrc

   | **Purpose:** First, set DISPLAY properly, so you can open GUIs like
     ``afni``, ``suma``, etc.  Then, avoid having some
     very-non-necessary GTK warnings from programs.
   |

#. Close (exit) Ubuntu terminal, so that changes are effected the next
   time you open it.

More setup tips for Ubuntu+Windows
---------------------------------------------

1. | Install Ubuntu terminal fonts as described `under "Bonus: Install
     the Ubuntu Font for a True Ubuntu Experience" on this page (waaay
     down)
     <https://www.howtogeek.com/249966/how-to-install-and-use-the-linux-bash-shell-on-windows-10/>`_.

#. | The default profile "use colors from system theme" shows an
     all-black terminal.  To adjust this to something nicer: 
   | Go to the terminal's menu bar,
   | Select the ``Edit`` tab, then ``Profile``, 
   | Turn **off** "use colors ...", and just pick a scheme+palette
     that you like.
   |

#. | **Note:**
   | In gnome-terminal, things are similar to other Linux
     implementations. The middle button pastes whatever is
     highlighted in the WSL terminal or other gnome-terminal:
     ``shift-ctrl-c`` copies, and ``shift-ctrl-v`` also pastes.
   |

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


A note on transferring data between Ubuntu and Windows 
---------------------------------------------------------

#. You can "see" your Windows file system from the Ubuntu side, where
   it appears as ``/mnt/c/``.  For example, if your Windows username
   is USERNAME, then the following would copy a file called FILE.pdf
   on your Windows Desktop to your current Ubuntu terminal location::

     cp /mnt/c/Users/USERNAME/Desktop/FILE.pdf .

#. | To mount external devices (e.g., a USB) from the Ubuntu side.
     Let's say your external device appears as the "G:" drive on
     Windows when you plug it into a USB port.  You could mount that
     drive from Ubuntu as follows, where---
   | the first command makes a mount point location ('g' is a 
     convenient label here), and
   | the second mounts the external drive to it::

     sudo mkdir /mnt/g
     sudo mount -t drvfs G: /mnt/g

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
