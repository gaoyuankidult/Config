#!/bin/bash

#################################################################################
# Coding conventions
#
# - Prefer portability, but don't sacrifice security and whitespace awareness
#   to it.
#
# - Prefer builtins over external commands.
#
# - But, use fast external commands to process very large inputs.
#
# - Avoid unnecessary subshells and pipelines.
#
# - Don't preoptimize.
#
# - Learn the rules of quoting. Then, use quotes.
#
# - Use functions to improve readability and control scope.
# 
# - Don't give scripts silly file extensions.
#
# - Never change directory without checking that it worked.
#
# - Eschew hobgoblins
#
#
# "A foolish consistency is the hobgoblin of little minds, adored by little
#  statesmen and philosophers and divines."
#
#  – Ralph Waldo Emerson
#
#
################################################################################

# require sudo right
if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

# check existence of backup file
if [ -f "/etc/default/keyboard.backup" ]; then
    echo "System has been modified, please reset using reset.sh"
    exit 1
fi

# download current package list and prepare for software installation
apt-get update 
apt-get install git emacs terminator texmaker 

# create symbolic link to emacs configeration files .gitconfig .gitignore
ln -s ~/Config/init.el ~/.emacs.d/init.el
ln -s ~/Config/load-directory-mu.el ~/.emacs.d/load-directory-mu.el
ln -s ~/Config/00-editor.el ~/.emacs.d/00-editor.el
ln -s ~/Config/00-editor ~/.emacs.d/00-editor
ln -s ~/Config/.gitconfig ~/.gitconfig
ln -s ~/Config/.gitignore ~/.gitignore

# disable capslock button
cp /etc/default/keyboard /etc/default/keyboard.backup
cat /etc/default/keyboard | sed 's/\(XKBOPTIONS="\)/1ctrl:nocaps,/' > /etc/default/keyboard
dpkg-reconfigure -phigh console-setup
