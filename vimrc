"set signcolumn=yes "搜索去掉边框
"colorscheme delek
highlight PMenu                 ctermfg=0 ctermbg=242 
highlight PMenuSel              ctermfg=242 ctermbg=8 
set cursorline
highlight CursorLine           cterm=bold,italic ctermbg=8
highlight CursorLineNr         cterm=bold,italic ctermfg=159 ctermbg=236

set fileencodings=ucs-bom,utf-8,gb18030,default"设置编码
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
"set cmdheight=1
"打开回到上一次打开的位置
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif 

inoremap jj <Esc>
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
"设置x f删除不复制
nnoremap X "_X
nnoremap x "_x
nnoremap f "_dd
nnoremap F "_d
vnoremap f "_d
 
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
let g:indentLine_char = ':'"设置对齐线
"let g:airline_theme='cobalt2' "powerline
let g:airline_theme='powerlineish'设置状态栏主题
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
"最后一个窗口不是编辑窗口就关闭
autocmd BufEnter * if 0 == len(filter(range(1, winnr('$')), 'empty(getbufvar(winbufnr(v:val), "&bt"))')) | qa! | endif
autocmd vimEnter * NERDTree
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
let g:NERDTreeWinPos='left'
let g:NERDTreeWinSize=17
let g:NERDTreeSize=20
设置是否显示隐藏文件 0不显示
let g:NERDTreeShowHidden=1 

"模板
autocmd BufNewFile *.h 0r ~/.vim/template/c.h
autocmd BufNewFile *.c 0r ~/.vim/template/c.c
autocmd BufNewFile *.cpp 0r ~/.vim/template/c.cpp


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
    Plug 'Xuyuanp/nerdtree-git-plugin'
    "vim-gitgutterf   "git
call plug#end()
