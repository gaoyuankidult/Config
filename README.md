# Config: 

This repo is a personal configeration folder made by Alex Yuan Gao. It is used to automatically install nessasery libraries on a new linux based computer.
Currently, this repo only supports installation on lubuntu. I occationally update this repo and the next support OS will be LFS.

## Installation Files
Two installation files are used in this folder, namely lubuntu_setup.sh and reset.sh

- __lubuntu_setup.sh__ is used to install all the configerations files to there places.
- __reset.sh__ is used to remove all the installed files.

## Git Files

- __.gitconfig__ specifies system params and liases for git.
- __.gitignore__ specipies intentionally untracked files.

## Emacs Files/Folders
All emacs files/folders will be softlinked to ~/.emacs.d/.  Please check [setup file](lubuntu_setup.sh#L54) for more specifications.

- __init.el__ will be excuted when emacs is started. This file includes all *.el files.
- __00-editor.el__ specifies editor related emacs settings.
- __00-editor__ contains all libraies need by 00-editor.el.
- __01-system.el__ speficies system related emacs settings.
- __load-directory-mu.el__ is a common lisp library files used to load all libraries in a folder.

## Bash Files

- __.profile__ contains personal bash configerations.
