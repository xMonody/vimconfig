runtime! debian.vim
if has("syntax")
  syntax on
"colorscheme delek
highlight PMenu                 cterm=bold ctermfg=255 ctermbg=239
highlight PMenuSel              ctermfg=255 ctermbg=235
set cursorline
highlight CursorLine           cterm=bold ctermbg=8
highlight CursorLineNr         cterm=bold,italic ctermfg=159 ctermbg=236

set fileencodings=ucs-bom,utf-8,gb18030,default
autocmd! bufwritepost ~/.config/nvim/init.vim source % " vimrc文件修改之后自动加载
set autoread " 文件修改之后自动载入。
set shortmess=atI " 启动的时候不显示那个援助索马里儿童的提示
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
set mouse-=a
set nocompatible
set cmdheight=2
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

inoremap jj <Esc>
inoremap <C-v> <Esc>v
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
inoremap{ {}<Left>
inoremap{<CR> {}<ESC>i<CR><ESC>O
inoremap[ []<Left>
inoremap( ()<Left>
inoremap< <><Left>
inoremap<< <<
inoremap' ''<Left>
inoremap" ""<Left>
nnoremap X "_X
nnoremap x "_x
nnoremap s "_dd
nnoremap S "_d
vnoremap s "_d
"inoremap<C-d> <Del>
"inoremap<C-b> <BS>
"map <C-r> :call CompileRunGun()
"func! CompileRunGun()
"    exec "w"
"    exec "!make"
"    exec "!./Project"
"endfunc
let g:mapleader = ","
let   mapleader=","

""indentLine                            
let g:indentLine_noConcealCursor = 1
let g:indentLine_color_term = 0
let g:indentLine_char ='|' "'┊'
let g:airline_theme='cobalt2' "powerline
"let g:airline_theme='powerlineish'
let g:NERDTreeIndicatorMapCustom = {
        \ "Modified"  : "✹",
        \ "Staged"    : "✚",
        \ "Untracked" : "✭",
        \ "Renamed"   : "➜",
        \ "Unmerged"  : "═",
        \ "Deleted"   : "✖",
        \ "Dirty"     : "✗",
        \ "Clean"     : "✔︎",
        \ "Unknown"   : "?"
        \ }
let g:NERDTreeShowIgnoredStatus = 1
"autocmd BufEnter * if 0 == len(filter(range(1, winnr('$')), 'empty(getbufvar(winbufnr(v:val), "&bt"))')) | qa! | endif
autocmd vimEnter * NERDTree
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
let g:NERDTreeWinPos='left'
let g:NERDTreeWinSize=17
let g:NERDTreeSize=20
let g:NERDTreeShowHidden=1 
"hello whoel:
autocmd BufNewFile *.h 0r ~/.vim/template/c.h
autocmd BufNewFile *.c 0r ~/.vim/template/c.c
autocmd BufNewFile *.cpp 0r ~/.vim/template/c.cpp


let g:rainbow_active = 1
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

call plug#begin('~/.vim/plugged')
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'vim-airline/vim-airline-themes' "状态栏美化
	Plug 'vim-airline/vim-airline'
    Plug 'preservim/nerdtree' "目录树


	Plug 'Yggdroot/indentLine' "缩进线
	Plug 'octol/vim-cpp-enhanced-highlight'
	Plug 'preservim/nerdcommenter' "注释
    Plug 'mg979/vim-visual-multi', {'branch': 'master'} "多光标
    Plug 'honza/vim-snippets' "撸管代码更快
    Plug 'luochen1990/rainbow'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'ryanoasis/vim-devicons'
    "Plug 'airblade/vim-gitgutterf'   "git

call plug#end()
