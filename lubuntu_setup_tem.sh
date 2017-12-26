
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

