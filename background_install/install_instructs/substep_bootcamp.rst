
1. Copy+paste (to download+upack Bootcamp data to your home directory)::

     cd
     curl -O https://afni.nimh.nih.gov/pub/dist/edu/data/CD.tgz
     tar xvzf CD.tgz
     cd CD
     tcsh s2.cp.files . ~
     cd ..

   |

#. Copy+paste (to download+upack data for investigating QC in FMRI)::

     cd
     curl -O https://afni.nimh.nih.gov/pub/dist/edu/data/boot_qc/bootcamp_qc_sub_rest_A.tgz
     curl -O https://afni.nimh.nih.gov/pub/dist/edu/data/boot_qc/bootcamp_qc_sub_rest_B.tgz
     curl -O https://afni.nimh.nih.gov/pub/dist/edu/data/boot_qc/bootcamp_qc_sub_task_A.tgz
     tar -xf bootcamp_qc_sub_task_A.tgz
     tar -xf bootcamp_qc_sub_rest_A.tgz
     tar -xf bootcamp_qc_sub_rest_B.tgz

#. If no errors occur in the above, and your ``afni_system_check.py``
   says things are OK, you can delete/remove the tarred/zipped
   package, using::

     cd 
     rm CD.tgz
     rm bootcamp_qc_sub_task_A.tgz
     rm bootcamp_qc_sub_rest_A.tgz
     rm bootcamp_qc_sub_rest_B.tgz

   | If you are confident in the downloads+unpacking, you can also
     deleted the ``CD/`` directory in the present location.
   |

#. | **!Pro tip!:** Bring a computer mouse to use at the Bootcamp. It
     is muuuuch easier to follow the demos that way.
   |

#. **Read+practice** the handy :ref:`Unix documentation/tutorial
   <U_misc_bg0>`. This will give you a quick lesson/refresher on using
   basic Linux shell commands (e.g., `ls`, `cd`, `less`, etc.). It
   will *greatly* enhance your bootcamp experience-- we promise!

