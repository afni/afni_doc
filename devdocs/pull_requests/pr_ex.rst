.. _devdocs_pr_pr_ex:

*****************************************
Make a pull request to the **afni** repo
*****************************************

.. contents:: :local:

Introduction
============

| AFNI is part of the open source neuroimaging community and has >40
  code contributors to date. Our code is publicly downloadable via
  github: 
| `<https://github.com/afni/afni>`_
| If you have a contribution that you would like to make, then you can
  make a **pull request (PR)**.  This documentation page describes how
  to do so, and thanks in advance for your interest+contribution.

| NB: this is not a tutorial on using the **git** package, because we
  don't have as many days as there are grains of sand on the
  beach. Their main official documenation page is here:
| `<https://git-scm.com/docs>`_
| \.\.\. which also has some "cheatsheet" guides at the top.  An
  online search engine and Stack Overflow might also be your
  friend---such a combination has been the light of Earendil's star in
  many a dark version control place.

You do not need a github account to download (= **clone**) the code,
but you will need one to be able to make a PR.

Comment
^^^^^^^^

This page describes how to make a PR in several steps.  But, following
the proud tradition of several online tutorials, it doesn't describe
what to do when things go wrong. (Our reason, at least, is that there
are too many ways for things to go awry.)

However, don't panic.  Some things to note: 

* It's useful to keep a backup of your changes outside the git repo.
  That way, if things go awry, you shouldn't lose your hard work.

* Everything before the ``git commit ..`` command has only happened on
  *your* computer, and has not been recorded with git yet.  Nothing
  has been sent elsewhere.  So problems arising before that point can
  be fixed locally (e.g., if you delete something you didn't mean to,
  you can re-clone the repo in another directory and copy things
  over).  If worse comes to worst, you can move/remove the current
  cloned repo, clone a new one, and start over.

* Everything before the ``git push ..`` command has only happened on
  your computer, and has not been pushed to the remote repo.
  Therefore, you can still fix things locally and make commits to fix
  something before pushing it globally. If worse comes to worst, you
  can again move/remove the current cloned repo, clone a new one, and
  start over.

* Even if you did something you didn't want to, **and** committed it,
  **and** pushed to the remote realm\.\.\. well, it's still "just" a
  forked branch, and you don't have to make a PR out of it.  You can 
  delete your branch and start over.

We don't mean to be too pessimistic here.  There are also lots of
``git`` commands for fixing changes at various stages of
committing/pushing/etc., and feel free to use those if the need
arises.  Those might keep you from losing a lot of work, and they are
valuable to learn.  But ``git`` syntax *is* challenging, and takes a
while to get comfortable with.  So, we might suggest just using
``git`` in the best way possible to help your work flow.

|

How to make a pull request 
===========================

#. **Clone the repo.**  You can do this by going to the AFNI
   source code webpage `here <https://github.com/afni/afni>`_ and
   clicking on the large green "Code" button: 

   .. list-table:: 
      :header-rows: 0

      * - .. image:: media/img_00_get_clone_link.png
             :width: 90%   
             :align: center

   This shows you a link to copy.  In a terminal, type ``git clone``
   and then include that link, as follows::

     git clone https://github.com/afni/afni.git

   .. list-table:: 
      :header-rows: 0

      * - .. image:: media/img_00_term.png
             :width: 90%   
             :align: center

#. **Make a new branch.** Right now, the body of code you downloaded
   is the "main" (or "master") branch.  To make a pull request, you
   will make a new branch, that can be named whatever you want
   (perhaps something meaningful to your project).  

   Move into the repository, and use the following to make a new
   branch (note the ``-b`` option here, which means we are *making* a
   new branch; without this option, ``git`` assumes you are moving
   into a pre-existing branch)::


     cd afni/
     git checkout -b test_ramus

   .. list-table:: 
      :header-rows: 0

      * - .. image:: media/img_01_checkout-b.png
             :width: 90%   
             :align: center

#. (opt) **Check your current branch.** To see what branch you are in
   (and current one has asterisk)::

     git branch 

   .. list-table:: 
      :header-rows: 0

      * - .. image:: media/img_02_check_branch.png
             :width: 90%   
             :align: center

#. **Add/make changes in the branch.** Now, make your desired
   change(s) in your branch.  This can include adding a new file,
   editing an existing one, etc.  Here are just a couple examples of
   copying in a new file, and opening and editing (not shown; use any
   text editor or just copy in an already tweaked copy) an existing
   file, respectively::

     cd src/scripts_install/
     cp ~/SurfLayers .   

     emacs ../python_scripts/scripts/1dplot.py

   .. list-table:: 
      :header-rows: 0

      * - .. image:: media/img_03_cp_edit.png
             :width: 90%   
             :align: center

#. (opt; recommended) **Check changed files.** It is useful to see how
   many changed files you have before making the PR.  This helps
   ensure that you have made all the changes you want---and aren't
   about to accidentally push in changes that you *didn't*::

     git status

   .. list-table:: 
      :header-rows: 0

      * - .. image:: media/img_04_status.png
             :width: 90%   
             :align: center

   **Note** how the new file is untracked---we haven't *add*\ ed it to
   to local repo yet.  

#. (opt) **Add a file to the repo.** As noted from the previous step,
   just because a file sits in this directory, that does *not* mean
   git will track it.  If we are adding a new file as one of our
   changes to the repo, then we have to instruct git to take note of
   it (we can add one or more files in this way; using paths within
   the repo is fine)::

     git add SurfLayers 

   It is possible to ``git remove ..`` one or more files, too, in the
   same way.  

   And let's check the new status of the repo::

     git status

   .. list-table:: 
      :header-rows: 0

      * - .. image:: media/img_05_add_and_status.png
             :width: 90%   
             :align: center

   Great, now that file is no long 'untracked', so it will be part of
   our git-world.

#. **Commit changes.** Let's say that that is all of the business for
   the pull request.  Now we will ``commit`` **a**\ ll those changes, with a
   descriptive **m**\ essage (hence the ``-am`` here)::

     git commit -am "SurfLayers: new prog;  1dplot.py: new opt '-solve_the_brain'"


   .. list-table:: 
      :header-rows: 0

      * - .. image:: media/img_06_commit.png
             :width: 90%   
             :align: center

#. (opt) **Check status again.** Just out of interest, you might want
   to see what the status of the repo is now::

     git status

   .. list-table:: 
      :header-rows: 0

      * - .. image:: media/img_07_status_clean.png
             :width: 90%   
             :align: center

   Our work has been committed on local repo, so no changes are
   apparent. **But** we are not done: we have only made a *local*
   commit, and we have to push our changes to the *remote* repo.

   We could also continue to make more changes in our local branch and
   commit those, before moving on to the next step.  We can
   accummulate several commits, and then push them all at once.

#. **Push to remote branch.** Now, we will **push** all of those
   commited changes to this branch in the remote location.  The name
   of the remote branch should be 'origin' (this can be verified by
   first running ``git remote``)::

     git push origin test_ramus

   .. list-table:: 
      :header-rows: 0

      * - .. image:: media/img_08_push.png
             :width: 90%   
             :align: center

   Now, our branch in the remote location is updated. The ``commit
   ..`` added changes to our local branch, and the ``push ..``
   sent them to the remote branch.  

   We could continue changing our local file, and committing and
   pushing to the local and remote branch, respectively.  When we have
   as many of these changes added+pushed as we want, then we can make
   our pull request.

#. **Make pull request (online).** Now, we can make a pull request to
   merge the changes that are sitting in our branch (the commit added
   them to our local branch, and the push sent them to the remote
   branch) into the main/master branch. To do this step, let's go to
   the web interface.

   | Navigate to the afni source code github page in your browser:
   | `<https://github.com/afni/afni>`_
   | \.\.\. and you probably need to be logged in to your git account
     now.

   Looking at the webpage, you will likely notice that there is a
   notification about the push to the branch:

   .. list-table:: 
      :header-rows: 0

      * - .. image:: media/img_10_github_again.png
             :width: 90%   
             :align: center
   
   You could click on the big, green "Compare & pull request" button
   now (if you do so, skip down to the "Finally", below).

   Or, if you don't see that there for whatever reason (maybe
   fleeting time has passed, and other notifications sit there), then
   you can click on the gray "master" (or "main") button to the far
   left of the "Code" download button---click on it to see a menu of
   branches, find your branch and click on it:

   .. list-table:: 
      :header-rows: 0

      * - .. image:: media/img_11_branch_menu.png
             :width: 90%   
             :align: center
   
   That should take you to a page like this, where now you really
   should see (you really *should*) a big, green "Compare & pull
   request" button to click on (and *do so*):

   .. list-table:: 
      :header-rows: 0

      * - .. image:: media/img_12_branch_home.png
             :width: 90%   
             :align: center

      
   **Finally**, you are one step away from completing your pull
   request.  As the interface you should be looking at shows:

   .. list-table:: 
      :header-rows: 0

      * - .. image:: media/img_13_create_pr.png
             :width: 90%   
             :align: center

   \.\.\. you can add a comment/message to your request.  This can be
   reasoning for why you are making this PR, descriptive about the
   specific code changes (what programs added/changed and why/how),
   pinging someone to take a look at your PR (start typing ``@``, and
   you should get a menu of possible names to complete), etc.  All of
   these are good things, particularly if you are making this PR out
   of the blue.  This may be the start of a discussion, possibly
   leading to further changes in your branch before accepting the PR.
   
   After filling in some comment:

   .. list-table:: 
      :header-rows: 0

      * - .. image:: media/img_14_comment.png
             :width: 90%   
             :align: center

   \.\.\. you should get brought to a screen like this:

   .. list-table:: 
      :header-rows: 0

      * - .. image:: media/img_15_pr_check.png
             :width: 90%   
             :align: center
                

   You'll notice some automatic checks will be taking place within
   "CircleCI", and some automatic checks for conflicts within the git
   realm should also have taken place.  You can also click on the
   "Pull requests" tab at the top, and see the list of open PRs, of
   which yours should now be sitting at the top:

   .. list-table:: 
      :header-rows: 0

      * - .. image:: media/img_16_pr_list.png
             :width: 90%   
             :align: center

   **Congrats.** Again, at this point, someone might contact you about
   this PR, likely using the github page as a discussion thread.  And
   thanks for your contribution.

|

Lo stesso, alla breve
======================

Clone::

  git clone https://github.com/afni/afni.git

Fork a new branch::

  cd afni/
  git checkout -b test_ramus

*Make some changes in the branch.*

Check changes and what is ready to commit::

  git status

If necessary, add any new files you want to the repo::

  git add SurfLayers 

Commit your changes::

  git commit -am "SurfLayers: new prog;  1dplot.py: new opt '-solve_the_brain'"

Push to remote::

  git push origin test_ramus

Hop online and start clicking big, green buttons.  If you want get
there in style::

  afni_open -b https://github.com/afni/afni

\.\.\. or to be extra-fancy about it::

  afni_open -b  https://github.com/afni/afni/tree/test_ramus

Et voila.
