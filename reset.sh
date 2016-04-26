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

# create symbolic link to .emacs .gitconfig .gitignore
rm ~/.emacs
rm ~/.gitconfig
rm ~/.gitignore

# disable capslock button
mv /etc/default/keyboard.backup /etc/default/keyboard
dpkg-reconfigure -phigh console-setup
