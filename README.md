# install Install the required tools
```bash
# Debian
sudo apt-get install ripgrep silversearcher-ag fd-find fzf bat python3-pynvim command-not-found # msgpack-python python3-u-msgpack
# ArchLinux
sudo pacman -S ripgrep the_silver_searcher fd fzf bat python-pynvim pkgfile
```

# build vim
```bash
./configure --with-features=huge --with-python3-command=/usr/bin/python3 --enable-python3interp --enable-luainterp --enable-multibyte --enable-cscope --prefix=/usr/local/vim
```

# install font
```bash
sudo apt-get install xfonts-utils fontconfig
sudo mkdir -p /usr/share/fonts/myfonts
cd /usr/share/fonts/myfonts
sudo cp /home/deb/vimconfig/font/* ./

sudo mkfontscale　　 # 生产字体索引
sudo mkfontdir　　　 #
sudo fc-cache　　　　# 更新字体缓存
```
