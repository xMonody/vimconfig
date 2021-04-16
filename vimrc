highlight PMenu                 ctermfg=0 ctermbg=242 "设置补全提示框颜色
highlight PMenuSel              ctermfg=242 ctermbg=8 
set cursorline
highlight CursorLine           cterm=bold,italic ctermbg=8设置当前行颜色
highlight CursorLineNr         cterm=bold,italic ctermfg=159 ctermbg=236设置当前行号高亮

set fileencodings=ucs-bom,utf-8,gb18030,default "设置编码
autocmd! bufwritepost .vimrc source % " vimrc文件修改之后自动加载
set autoread " 文件修改之后自动载入。
set shortmess=atI " 启动的时候不显示那个援助索马里儿童的提示
set guifont=monaco:h20"设置字体字号
set mouse-=a"设置所有模式可用鼠标
set noerrorbells
set novisualbell 
set t_vb=
set tm=500
set number
set relativenumber
set ts=4
set shiftwidth=4
set softtabstop=4
set tabstop=4
set autoindent
set cindent
set expandtab

imap jj <Esc>
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
inoremap{ {}<ESC>i<CR><ESC>O
inoremap[ []<Left>
inoremap( ()<Left>
inoremap< <><Left>
inoremap' ''<Left>
inoremap" ""<Left>
""indentLine 
let g:indentLine_noConcealCursor = 1
let g:indentLine_color_term = 0
let g:indentLine_char = '|'

let g:mapleader = ","
let   mapleader=","
set nocompatible

call plug#begin('~/.vim/plugged')
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'vim-airline/vim-airline-themes'
	Plug 'vim-airline/vim-airline'
	Plug 'preservim/nerdtree'
	Plug 'Yggdroot/indentLine'
	Plug 'octol/vim-cpp-enhanced-highlight'
	Plug 'preservim/nerdcommenter'
call plug#end()

