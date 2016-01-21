#!bin/bash

change XKBOPTIONS="ctrl:nocaps" in /etc/default/keyboard
then run sudo dpkg-reconfigure -phigh console-setup
