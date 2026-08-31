# install Install the required tools
```bash
# Debian
sudo apt-get install ripgrep silversearcher-ag fd-find fzf bat python3-pynvim command-not-found # msgpack-python python3-u-msgpack
# ArchLinux
sudo pacman -S ripgrep the_silver_searcher fd fzf bat python-pynvim pkgfile
```

# build vim
```bash
./configure --with-features=huge --enable-python3interp --enable-multibyte --enable-cscope --enable-gtk4 --enable-fail-if-missing --prefix=/usr/local/vim
```

# install font
```bash
sudo apt-get install xfonts-utils fontconfig
sudo mkdir -p /usr/share/fonts/myfonts
cd /usr/share/fonts/myfonts
sudo cp /home/deb/vimconfig/font/* ./

sudo fc-cache -v # 更新字体缓存
```
