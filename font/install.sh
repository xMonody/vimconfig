#!/usr/bin/bash
sudo apt -y install xfonts-utils fontconfig
sudo mkdir -p /usr/share/fonts/myfonts
sudo cp ./*.ttf /usr/share/fonts/myfonts

cd /usr/share/fonts/myfonts
sudo fc-cache -fv
