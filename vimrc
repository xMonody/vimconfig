runtime! debian.vim
syntax on
set mouse-=a
"colorscheme delek
"export http_proxy='http://proxy.xxx.com:8080'
"git config --global http.proxy http://192.168.49.1:8282
"sudo apt-get -o Acquire::http::proxy="http://127.0.0.1:18088/" update
highlight PMenu                 cterm=bold ctermfg=255 ctermbg=239
highlight PMenuSel              ctermfg=255 ctermbg=235
set cursorline
highlight CursorLine           cterm=bold ctermbg=8
highlight CursorLineNr         cterm=bold,italic ctermfg=159 ctermbg=236
set fileencodings=ucs-bom,utf-8,gb18030,default
set shortmess=atI " 启动的时候不显示那个援助索马里儿童的提示
set scrolloff=5
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
set hlsearch
set backspace=indent,eol,start
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif


"set airline && airthemes 状态栏美化
"let g:airline_theme="bubblegum"
let g:airline_theme='powerlineish'
let g:cpp_no_function_highlight = 1
let g:cpp_concepts_highlight = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_scope_highlight = 1

"set nerdtree 目录树
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
"autocmd vimenter * if !argc()|NERDTree|
autocmd vimenter * NERDTree
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
" 显示行号
let NERDTreeShowLineNumbers=1
let NERDTreeAutoCenter=1
" 是否显示隐藏文件
let NERDTreeShowHidden=1
" 设置宽度
let g:NERDTreeWinSize=17
let NERDTreeWinSize=25
let g:NERDTreeWinPos='left'
let g:NERDTreeSize=30
" 在终端启动vim时，共享NERDTree
let g:nerdtree_tabs_open_on_console_startup=1
" 忽略一下文件的显示
let NERDTreeIgnore=['\.pyc','\~$','\.swp']
" 显示书签列表
let NERDTreeShowBookmarks=1
autocmd bufenter * if(winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"set indentLine 缩进线
let g:indentLine_char='┆'
let g:indentLine_enabled = 1
let g:indentLine_noConcealCursor = 1
let g:indentLine_color_term = 0
let g:rainbow_active = 1

"set nerd commenter
let mapleader=","

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
inoremap<> <><Left>
inoremap<< <<
nnoremap <expr>m col(".")+1==col("$")?"^":"$"

inoremap" ""<Left>
nnoremap X "_X
nnoremap x "_x
nnoremap dd "_dd
nnoremap s dd
nnoremap d "_d
vnoremap B ge

let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)

"inoremap<C-d> <Del>
"inoremap<C-b> <BS>

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
    "Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'ryanoasis/vim-devicons'
    "Plug 'luochen1990/rainbow'
    "Plug 'airblade/vim-gitgutterf'   "git
    "Plug 'tpope/vim-surround'

call plug#end()
