# vim and neovim config
install ripgrep fzf bat silversearcher-ag

pip3 install pynvim  msgpack-python  

# build vim
./configure --with-features=huge --with-python3-command=/usr/bin/python3 --enable-python3interp --enable-luainterp --enable-multibyte --enable-cscope --prefix=/usr/local/vim

## vim config
1. install plug.vim
file pos windows ~/vimfiles/autoload/plug.vim  linux ~/.vim/autoload/plug.vim

linux
``` shell
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

windows
``` shell
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni $HOME/vimfiles/autoload/plug.vim -Force
```
2. windows file pos ~/vimfiles/vimrc 
linux file pos ~/.vimrc and .config/vim/vimrc
3. PlugInstall

## nvim config
4. windows   ~/AppData\Local\nvim\init.lua
5. linux     ~/.config/nvim/init.lua
6. Lazy
# install font  
RedHatMono Nerd Font Mono
SauceCodePro Nerd Font Mono  
sudo apt-get install xfonts-utils fontconfig  
sudo mkdir -p /usr/share/fonts/myfonts  
cd /usr/share/fonts/myfonts  
sudo cp /home/deb/vimconfig/font/* ./  

sudo mkfontscale　　 # 生产字体索引  
sudo mkfontdir　　　 #   
sudo fc-cache　　　　# 更新字体缓存  

