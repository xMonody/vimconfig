# build vim
```bash
./configure --with-features=huge --enable-python3interp --enable-multibyte --enable-cscope --enable-gtk4 --enable-fail-if-missing --prefix=/usr/local/vim
```

# install font
```bash
sudo apt-get install xfonts-utils fontconfig
sudo mkdir -p /usr/share/fonts/myfonts
cd /usr/share/fonts/myfonts
sudo cp ./*.ttf /usr/share/fonts/myfonts

sudo fc-cache -v # 更新字体缓存
```
