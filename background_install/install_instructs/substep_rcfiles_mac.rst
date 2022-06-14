
To improve your life when using the terminal, copy+paste these::

  echo 'set filec'    >> ~/.cshrc
  echo 'set autolist' >> ~/.cshrc
  echo 'set nobeep'   >> ~/.cshrc

  echo 'alias ls ls -G'       >> ~/.cshrc
  echo 'alias ll ls -lG'      >> ~/.cshrc
  echo 'alias ltr ls -lGtr'   >> ~/.cshrc
  echo 'alias ls="ls -G"'     >> ~/.bashrc
  echo 'alias ll="ls -lG"'    >> ~/.bashrc
  echo 'alias ltr="ls -lGtr"' >> ~/.bashrc
  echo 'alias ls="ls -G"'     >> ~/.zshrc
  echo 'alias ll="ls -lG"'    >> ~/.zshrc
  echo 'alias ltr="ls -lGtr"' >> ~/.zshrc

**Purpose:** The first command block sets up ``tab`` autocompletion
for ``tcsh`` (which should already be enabled for ``bash`` users by
default). The second set of commands make aliases for the main shells
so that different types of files ("normal" files, zipped files,
executables, et al.)  and directories are shown using different colors
and boldness.  It makes it *much* easier to navigate on a terminal,
IMHO.
