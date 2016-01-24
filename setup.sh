#!/bin/bash

#change XKBOPTIONS="ctrl:nocaps" in /etc/default/keyboard
# then run sudo dpkg-reconfigure -phigh console-setup

ssh-keygen -t rsa -b 4096 -C "gaoyuankidult@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
sudo apt-get install xclip
xclip -sel clip < ~/.ssh/id_rsa.pub
