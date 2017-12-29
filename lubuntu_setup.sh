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
apt-get update add-apt-repository ppa:kelleyk/emacs
apt-get install git terminator texmaker xclip tmux uget ssh python-pip sshpass gnome-do gnome-session-flashback i3 compizconfig-settings-manager compiz-plugins-extra alsa-utils texlive-full zathura tty-clock task inotify-tools
pip install setuptools python-virtualenv

# install emacs25 and set it as default
add-apt-repository ppa:kelleyk/emacs
apt update
apt install emacs25

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

# create symbolic links to i3 configeration files
mkdir -p ~/.config/i3
ln -s ~/Config/i3/config ~/.config/i3/config
ln -s ~/Config/i3/i3status.conf ~/.config/i3/i3status.conf

# create a symbolic links to terminator configeration file
mkdir -p ~/Config/terminator
ln -s ~/Config/terminator/config ~/.config/terminator/config

# generate ssh key and setup github
sudo -H -u alex bash -c 'ssh-keygen -t rsa -b 4096 -C "gaoyuankidult@gmail.com"'
sudo -H -u alex bash -c 'eval "$(ssh-agent -s)" && ssh-add ~/.ssh/id_rsa'

echo ""
echo "Please excute..."
echo "xclip -sel clip < ~/.ssh/id_rsa.pub"
echo "...and paste it on GitHub ssh settings."

# confirm that the user is done with the ssh
while true; do
    read -p "Have you done installation of git ?" yn
    case $yn in
        [Yy]* ) echo "Installation continues...";;
        [Nn]* ) echo "Pleae install git fist.";;
        * ) echo "Please answer yes or no.";;
    esac
done

# install i3-gap for i3 environment under ubuntu 14.04
sudo apt-get install autoconf libev-dev 
sudo apt-get install libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf libxcb-xrm-dev

cd ~/Desktop
wget http://ftp.br.debian.org/debian/pool/main/x/xcb-util-xrm/libxcb-xrm0_1.0-2_amd64.deb
wget http://ftp.br.debian.org/debian/pool/main/x/xcb-util-xrm/libxcb-xrm-dev_1.0-2_amd64.deb
sudo dpkg -i libxcb-xrm0_1.0-2_amd64.deb
sudo dpkg -i libxcb-xrm-dev_1.0-2_amd64.deb

sudo apt-get build-dep cairo
wget http://cairographics.org/releases/cairo-1.14.6.tar.xz
tar xf cairo-1.14.6.tar.xz
cd cairo-1.14.6

./configure --prefix=$HOME/prefix
make
make install
export PKG_CONFIG_PATH=$HOME/prefix/lib/pkgconfig
export LD_LIBRARY_PATH=$HOME/prefix/lib

cd ~/Desktop
git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps
autoreconf --force --install
rm -rf build/
mkdir -p build && cd build/
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make
sudo make install

# install feh for i3 wall paper
apt-get install feh

# install udiskie to autoload removable disk for i3
apt-get install python-setuptools udisks python-pip python-gobject python-yaml libgio2.0 gobject-introspection libgtk2.0-0 libnotify4 gettext gir1.2-notify-0.7
pip install udiskie
echo "[mount]
Identity=unix-group:plugdev
Action=org.freedesktop.udisks.filesystem-mount
ResultAny=yes
[unlock]
Identity=unix-group:plugdev
Action=org.freedesktop.udisks.luks-unlock
ResultAny=yes
[eject]
Identity=unix-group:plugdev
Action=org.freedesktop.udisks.drive-eject
ResultAny=yes
[detach]
Identity=unix-group:plugdev
Action=org.freedesktop.udisks.drive-detach
ResultAny=yes" >> /etc/polkit-1/localauthority/50-local.d/consolekit.pkla

# install wangyi yun
wget http://s1.music.126.net/download/pc/netease-cloud-music_1.0.0-2_amd64_ubuntu14.04.deb
dpkg -i netease-cloud-music_1.0.0-2_amd64_ubuntu14.04.deb 
apt-get install -f # dpkg will fail the first time 
dpkg -i netease-cloud-music_1.0.0-2_amd64_ubuntu14.04.deb

# link configeration of default programs for different types of files
rm  ~/.config/mimeapps.list
ln -s ~/Config/mimeapps.list ~/.config/mimeapps.list
rm ~/.local/share/applications/mimeapps.list
rm  ~/.local/share/applications/mimeapps.list
ln -s ~/Config/mimeapps.list ~/.local/share/applications/mimeapps.list
rm ~/.toprc
ln -s ~/Config/.toprc ~/.toprc
rm ~/.taskrc
ln -s ~/Config/.taskrc ~/.taskrc

# download and install screen lock for i3
git clone https://github.com/meskarune/i3lock-fancy.git /usr/local/bin/

# link ssh configeration files
ln -s ~/Config/ssh/config  ~/.ssh/config

