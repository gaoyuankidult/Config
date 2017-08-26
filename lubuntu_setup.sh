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
if [ -f "/etc/default/keyboard.backup" -f "~/.ssh/id_rsa" -f "~/.ssh/id_rsa.pub" ]; then
    echo "System has been modified, please reset using reset.sh"
    exit 1
fi

# download current package list and prepare for software installation
apt-get update 
apt-get install git emacs terminator texmaker xclip tmux uget ssh python-pip sshpass gnome-do gnome-session-fallback i3
pip install setuptools

# install gnome related operations e.g. gnome-session-quit (to log out from command line)
apt-get install gnome-session-bin

# install anaconda
wget http://repo.continuum.io/archive/Anaconda2-4.0.0-Linux-x86_64.sh
chmod +x Anaconda2-4.0.0-Linux-x86_64.sh
./Anaconda2-4.0.0-Linux-x86_64.sh
rm Anaconda2-4.0.0-Linux-x86_64.sh

# create symbolic link to emacs configeration files, .gitconfig, .gitignore and bash_profile.
echo 'source ~/Config/.profile' >> ~/.bashrc 
mkdir ~/.emacs.d
ln -s ~/Config/init.el ~/.emacs.d/init.el
ln -s ~/Config/load-directory-mu.el ~/.emacs.d/load-directory-mu.el
ln -s ~/Config/00-editor.el ~/.emacs.d/00-editor.el
ln -s ~/Config/01-system.el ~/.emacs.d/01-system.el
ln -s ~/Config/00-editor ~/.emacs.d/00-editor
ln -s ~/Config/.gitconfig ~/.gitconfig
ln -s ~/Config/.gitignore ~/.gitignore

# disable capslock button
cp /etc/default/keyboard /etc/default/keyboard.backup
sed -i 's/\(XKBOPTIONS="\)/&ctrl:nocaps,/' /etc/default/keyboard
dpkg-reconfigure -phigh console-setup

# add terminator to autostart in lubuntu
mkdir -p ~/.config/autostart/
ln -s ~/Config/autostart.desktop ~/.config/autostart/autostart.desktop

# set remote url of Config to be via git instead of https
cd /home/alex/Config
git remote set-url origin git@github.com:gaoyuankidult/Config.git

# generate ssh key and setup github
sudo -H -u alex bash -c 'ssh-keygen -t rsa -b 4096 -C "gaoyuankidult@gmail.com"'
sudo -H -u alex bash -c 'eval "$(ssh-agent -s)" && ssh-add ~/.ssh/id_rsa'

echo ""
echo "Please excute..."
echo "xclip -sel clip < ~/.ssh/id_rsa.pub"
echo "...and paste it on GitHub ssh settings."

