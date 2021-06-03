"export http_proxy="http://192.168.49.1:8282"
"export https_proxy="http://192.168.49.1:8282"
"add  apt-get proxy /etc/apt/apt.conf
"Acquire::http::Proxy "http://192.168.49.1:8282";
"git
"git config --global http.proxy 'http://192.168.49.1:8282'
"git config --global https.proxy 'http://192.168.49.1:8282'

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
let NERDTreeShowHidden=0
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
autocmd VimEnter * NERDTree
wincmd w
autocmd VimEnter * wincmd w
nnoremap <C-c> :NERDTreeClose<CR>
nnoremap <C-o> :NERDTree<CR>

"set statusline=%1*\%<%.50F\             "显示文件名和文件路径 (%<应该可以去掉)
"set statusline+=%=%2*\%y%m%r%h%w\ %*        "显示文件类型及文件状态
"set statusline+=%3*\%{&ff}\[%{&fenc}]\ %*   "显示文件编码类型
"set statusline+=%4*\Row:%l/%L:Col:%c\ %*  "显示光标所在行和列
"set statusline+=%5*\%3p%%\%*            "显示光标前文本所占总文本的比例
"hi User1 cterm=none,bold ctermfg=160 ctermbg=0
"hi User2 cterm=none,bold ctermfg=119 ctermbg=0
"hi User3 cterm=none,bold ctermfg=169 ctermbg=0
"hi User4 cterm=none,bold ctermfg=14 ctermbg=0
"hi User5 cterm=none,bold ctermfg=226 ctermbg=0
"function! InsertStatuslineColor(mode)
    "if a:mode != 'i'
            "hi User1 cterm=none,bold ctermfg=160 ctermbg=0
        "else
                "hi User1 cterm=none,bold ctermfg=41 ctermbg=0
        "endif
    "endfunction
"au InsertEnter * call InsertStatuslineColor(v:insertmode)
"au InsertLeave * hi User1 cterm=none,bold ctermfg=160 ctermbg=0

"set airline && airthemes 状态栏美化
"let g:airline_theme="bubblegum"


"set indentLine 缩进线
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme="understated"
let g:airline_powerline_fonts = 1
let g:indentLine_char='┆'
let g:indentLine_enabled = 1
let g:indentLine_noConcealCursor = 1
let g:indentLine_color_term = 0
let g:rainbow_active = 1
"--------------------------------------------------------------------------------------"
call plug#begin('~/.vim/plugged')
"call plug#begin('~/.config/nvim/plugged')
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes' "状态栏美化
	Plug 'neoclide/coc.nvim',{'branch':'release'}"代码补全
	Plug 'preservim/nerdtree' "目录树
	Plug 'Yggdroot/indentLine' "缩进线
	Plug 'preservim/nerdcommenter' "注释
	Plug 'mg979/vim-visual-multi', {'branch':'master'} "多光标
	Plug 'honza/vim-snippets' "片段补全
	Plug 'ryanoasis/vim-devicons' "美化
	"git
	plug '/airblade/vim-gitgutter'
	Plug 'tpope/vim-fugitive'
	Plug 'junegunn/gv.vim'
	"nvim
	"高亮
	"Plug 'prabirshrestha/vim-lsp',{'for':['c,cpp']}
	"Plug 'jackguo380/vim-lsp-cxx-highlight',{'for':['c,cpp']}
	"Plug 'octol/vim-cpp-enhanced-highlight'

call plug#end()

"-------------------------------------------------------------------------------------------"
"coc




"-------------------------------------------------------------------------------------------"
"函数高亮
"syn match cFunctions "\<[a-zA-Z_][a-zA-Z_0-9]*\>[^()]*)("me=e-2 
"syn match cFunctions "\<[a-zA-Z_][a-zA-Z_0-9]*\>\s*("me=e-1
"hi cFunctions term=underline cterm=bold ctermfg=14
"syn match cClass "\<[a-zA-Z_][a-zA-Z_0-9]*\>::"me=e-2
"hi cClass term=underline cterm=bold ctermfg=14

highlight GitGutterAdd    guifg=#009900 ctermfg=46
highlight GitGutterChange guifg=#bbbb00 ctermfg=214
highlight GitGutterDelete guifg=#ff2222 ctermfg=196
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_removed_above_and_below = '-'
let g:gitgutter_sign_modified_removed = 'v'

highlight PMenu              cterm=bold ctermfg=255 ctermbg=239
highlight PMenuSel           ctermfg=255 ctermbg=235
set cursorline
highlight CursorLine         cterm=bold ctermbg=237
highlight CursorLineNr       cterm=bold,italic ctermfg=255 ctermbg=237
hi SignColumn ctermbg=none

"nvim
"~/.config/nvim/autoload/plug.vim   
"~/.config/nvim/init.vim   // ~/.config/nvim/plugged 

" nvim add 
"highlight LspCxxHlSymFunction cterm=none
"highlight LspCxxHlGroupMemberVariable ctermfg=87

set numberwidth=3
set fileencodings=ucs-bom,utf-8,gb18030,default
set shortmess=atI " 启动的时候不显示那个援助索马里儿童的提示
set scrolloff=5
set noerrorbells "关闭提示音
set novisualbell
set t_vb=
set tm=500
set number
set relativenumber
set autoindent
set ts=4
set shiftwidth=4
set softtabstop=4
set tabstop=4
set cindent
set expandtab "设置tab=space
"set noexpandtab "设置spce=tab
"browsedir=buffer  "用当前文件所在目录；
"browsedir=current "用当前工作目录    
set mouse-=a
set nocompatible"不兼容vi模式
set cmdheight=1
set hlsearch
set backspace=indent,eol,start "设置back键
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif 
let mapleader=","

let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)

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
inoremap ' ''<Left>
inoremap" ""<Left>
nnoremap X "_X
nnoremap x "_x
nnoremap dd "_dd
nnoremap ss dd
nnoremap s d
vnoremap s d
vnoremap d "_d
nnoremap d "_d
nnoremap dl d$
nnoremap dh d^
nnoremap yl y$
nnoremap yh y^
nnoremap vl v$
nnoremap vh v^
nnoremap n o<Esc>k
nnoremap N a<CR><Esc>k
nnoremap K 3k
nnoremap H J
nnoremap J 3j
nnoremap z. <C-w>3>
nnoremap z, <C-w>3<
nnoremap <expr>m col(".")+1==col("$")?"^":"$"

