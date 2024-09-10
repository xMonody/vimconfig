sudo apt -y install xfonts-utils fontconfig
sudo mkdir -p /usr/share/fonts/myfonts
sudo cp ./*.ttf /usr/share/fonts/myfonts

cd /usr/share/fonts/myfonts
sudo mkfontscale
sudo mkfontdir
sudo fc-cache
