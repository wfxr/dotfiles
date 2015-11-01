"=============================================================================
"       Author: Wenxuan Zhang
"        Email: wenxuan-zhang@outlook.com
"     HomePage: wenxuan.info
"=============================================================================

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Obtain basic info for later using
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Is Windows?
if has("win32") || has("win64")
    let g:isWIN = 1
else
    let g:isWIN = 0
endif

" Is GVim?
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Cancel compatible to avoid some bugs and limations.
set nocompatible

" Change to English version. (Replaced 'en_US' by 'zh_CN' for Chinese)
let $LANG = 'en_US'
set langmenu=en_US

" add 'cjk' to spelllang to avoid checking Chinese
set spelllang+=cjk

" Set extra options when running in GUI mode
if g:isGUI 
    set guioptions-=T
    set guioptions-=m
    set guioptions-=r
    set guioptions-=L
    set guitablabel=%M\ %t

    " Set fonts when running in GUI mode
    if !g:isWIN
        "set guifont=Monospace\ 14 
        "set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 14
        "set guifont=Fantasque\ Sans\ Mono\ 16
        set guifont=Inconsolata-g\ for\ Powerline\ 16
        "set linespace=2
    else
        "set guifont=YaHei\ Fantasque\ Sans\ Mono:h18:cANSI
        set guifont=Inconsolata-g\ for\ Powerline:h16:cANSI
        "set guifont=YaHei\ Consolas\ Hybrid:h14:cANSI
    endif

    " Request after changing the version of Language!
    if g:isWIN
        source $VIMRUNTIME/delmenu.vim
        source $VIMRUNTIME/menu.vim
        
        " Avoid messy code under console.
        language messages en_US
    endif
endif

" Enable mouse
set mouse=a

" Linebrake on 90 characters  
set linebreak
set textwidth=90
set wrap        " Wrap lines

" Hilight current line
"set cursorline

" Make '<', '>', 'h', 'l' work properly.
set whichwrap+=<,>,h,l

" Set how many lines of history Vim will remember
set history=1000

" Don't redraw while executing macros (good performance config)
set lazyredraw

" Share clipboard with windows
if g:isWIN
    set clipboard+=unnamed
endif

" Show row number
set number
" Show relative number
set relativenumber

" Set height of cmd line to 2
set cmdheight=2

" Add a bit extra margin to the left
"set foldcolumn=1

" Highlight search matches
set hlsearch

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second (i.e. x/10 s) to blink when matching brackets
set matchtime=2

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

" Set n lines to the cursor - when moving vertically using j/k
set scrolloff=4

" No fold when vim start up
set nofoldenable

" Set fold method
set foldmethod=indent
set foldlevel=0

" Use spaces instead of tabs
set expandtab
:%retab
" Set tab witdh to 4 spaces 
set tabstop=4
set shiftwidth=4


" Set auto indent and C/C++ indent
set smartindent
set cindent

set ttimeoutlen=50

" 设置编码格式为UTF-8,防止中文乱码
set encoding=utf-8

" Set the sequence of auto encoding
set fileencodings=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936,big5

" Use Unix as the standard file type
set fileformat=unix
set fileformats=unix,dos,mac

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

" Auto source it after .vimrc edited
if g:isWIN
    autocmd! bufwritepost _vimrc source ~/_vimrc
else
    autocmd! bufwritepost .vimrc source ~/.vimrc
endif

" disable Background Color Erase (BCE) so that color schemes
" render properly when inside 256-color tmux and GNU screen.
" see also http://snk.tuxfamily.org/log/vim-256color-bce.html
set t_ut=

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set key -ng
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" With a map leader it's possible to do extra key combinations
let mapleader = ","
let g:mapleader = ","

" Using <F8> to toggle background mode
map <F8> :call ToggleBg()<CR>

" Using <SPACE> to fold or unfold
nnoremap <leader><SPACE> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

" Treat long line as break lines (useful when move around int them)
map j gj
map k gk

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" With this, we can now type "<leader><leader>" to exit out of  insert mode
inoremap <leader><leader> <Esc>
vnoremap <leader><leader> <Esc>
nnoremap <leader><leader> <Esc>

" These create newlines like o and O but stay in normal mode
nnoremap <silent> zj o<Esc>k
nnoremap <silent> zk O<Esc>j

" Split window
map <leader>S :split<Space>
map <leader>V :vsplit<Space>

" Close window
map <leader>q :q<cr>
map <leader>Q :q!<cr>
" Save write
map <leader>w :w<cr>
map <leader>W :w!<cr>
" Save and quit
map <leader>x :x<cr>
map <leader>X :x!<cr>

" Smart way to move windows
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-l> <C-w>l

map <C-Up> :resize +1<cr>
map <C-Down> :resize -1<cr>
map <C-Right> :vertical resize +1<cr>
map <C-Left> :vertical resize -1<cr>

" Close the current buffer
"map <leader>bc :Bclose<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<SPACE>
"map <leader>to :tabonly<CR>
map <leader>tc :tabclose<CR>
"map <leader>t<tab> :tabnext<CR>
"map <leader>n :tabnext<CR>
"map <leader>p :tabNext<CR>

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
" Note: 如果激活Alt映射,<Esc>会被视作Alt的前导(eg:<Esc>j和<M-j>
" 将具有相同的效果)
"if g:isGUI
    "nnoremap <M-j> mz:m+<CR>`z
    "nnoremap <M-k> mz:m-2<CR>`z
    "vnoremap <M-j> :m'>+<CR>`<my`>mzgv`yo`z
    "vnoremap <M-k> :m'<-2<CR>`>my`<mzgv`yo`z
    "if has("mac") || has("macunix")
        "nmap <D-j> <M-j>
        "nmap <D-k> <M-k>
        "vmap <D-j> <M-j>
        "vmap <D-k> <M-k>
    "endif
"else
    "nnoremap j mz:m+<CR>`z
    "nnoremap k mz:m-2<CR>`z
    "vnoremap j :m'>+<CR>`<my`>mzgv`yo`z
    "vnoremap k :m'<-2<CR>`>my`<mzgv`yo`z
"endif

" Visual mode pressing * or $ searches for the current selection
" Super useful! From and idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>

" pressing <leader>ss will toggle and untoggle spell checking
noremap <leader>ss :setlocal spell!<cr>
noremap <leader>sn ]s
noremap <leader>sp [s
noremap <leader>sa zg
noremap <leader>s? z=

" Remove the Windows ^M - when the encodings gets messed up
noremap <leader>m mmHmt:%s/<C-v><CR>//ge<CR>'tzt'm

" Toggle paste mode on and off
"map <leader>pp :setlocal paste!<CR>

map <leader>y "+y
map <leader>Y "+Y
map <leader>p "+p
map <leader>P "+P

nmap <leader>tl :TlistToggle<CR>
nmap <leader>tl :TlistToggle<CR>
nmap <leader>tl :TlistToggle<CR>
nmap <leader>nt :NERDTree<CR>

" fast jump
nnoremap L G$
vnoremap L G$
nnoremap H gg
vnoremap H gg

" 卷动屏幕（光标不移动）
"nmap <C-j> <C-y>
"nmap <C-k> <C-e>

" Select pasted text
noremap vp `[v`]

" 安装插件
nmap <leader>I :BundleInstall<CR>

" 用<CR>来快速跳转到指定行(eg: 23<CR>跳转到第23行)
" Note: 这个映射会导致不能通过LocationList等键入<CR>进行跳转
"nmap <CR> G

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype off                  " required!

" Set Vundle location and add-ons' location according to type of OS.
if g:isWIN
    set rtp+=$VIMRUNTIME/../vimfiles/bundle/Vundle/ " Vundle's path
    call vundle#rc('$VIMRUNTIME/../vimfiles/bundle/')   " Add-ons' path
else    " For Linux
    set rtp+=~/.vim/bundle/Vundle.vim/
    call vundle#rc()    " Default is OK
endif

" let Vundle manage Vundle, required!
Plugin 'gmarik/Vundle.vim'

" 为编辑.tmux.conf提供额外的支持
Plugin 'tmux-plugins/vim-tmux'

" Youdao translator
Plugin 'ianva/vim-youdao-translater'
vnoremap <slient> <C-T> <Esc>:Ydv<CR>
nnoremap <slient> <C-T> <Esc>:Ydc<CR>
noremap <leader>yd :Yde<CR>


" best Git wrapper
set diffopt=vertical

" wonderful and powerful file navigator
Plugin 'Shougo/unite.vim'
nnoremap <leader>` :Unite -start-insert buffer file file_rec file_mru<CR>
" unite need this to support file_mru
Plugin 'Shougo/neomru.vim'

" AirLine plugin
Plugin 'bling/vim-airline'
let g:airline_theme='gruvbox'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1

" Taglist plugin
Plugin 'taglist.vim'

" General {
    " Nerd tree to explore filesystem and open files or directories
    Plugin 'scrooloose/nerdtree'
    " Surround.vim is all about surroundings
    Plugin 'tpope/vim-surround'
    Plugin 'tpope/vim-repeat'
    " 配对符号插件
    Plugin 'jiangmiao/auto-pairs'
    Plugin 'powerline/fonts'
    " Move cusor in vim quickly
    Plugin 'Lokaltog/vim-easymotion'
    Plugin 'mbbill/undotree'
    Plugin 'mhinz/vim-signify'
    Plugin 'osyo-manga/vim-over'
    Plugin 'terryma/vim-expand-region'
    " Full path fuzzy file, buffer, mru, tag, ... finder for Vim
    Plugin 'ctrlpvim/ctrlp.vim'
    Plugin 'tacahiroy/ctrlp-funky'
" }

" Genenal Programming {
    " Syntastic is a syntax checking plugin for Vim that runs files through 
    " external syntax checkers and displays any resulting errors to the user. 
    Plugin 'scrooloose/syntastic'
    Plugin 'tpope/vim-fugitive'
    Plugin 'mattn/gist-vim'
    " Nerd Commenter to comment code quickly
    Plugin 'scrooloose/nerdcommenter'
    Plugin 'tpope/vim-commentary'
" }

" Snippets & AutoComplete {
    " YouCompleteMe!
    Plugin 'Valloric/YouCompleteMe'
    " 快速开启或关闭quickfix窗口
    Plugin 'wfxr/ListToggle'
    " To generate .ycm_extra_conf.py file
    Plugin 'rdnetto/YCM-Generator'

    " Track the engin
    Plugin 'SirVer/ultisnips'
    " Snippets are separated from the engine. Add this if you want them:
    Plugin 'honza/vim-snippets'
" }

" Trigger configuration. Do not use <tab> if you use 'YouCompleteMe'
let g:UltiSnipsExpandTrigger="<leader><tab>"
let g:UltiSnipsJumpForwardTrigger="<C-b>"
let g:UltiSnipsJumpBackwardTrigger="<C-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" plugin for Python
"Plugin 'klen/python-mode'

" Plugin of calendar
"Plugin 'itchyny/calendar.vim'

" FuzzyFinder(L9 library is necessary for FuzzyFinder)
"Plugin 'FuzzyFinder'
"Plugin 'L9'

nmap <leader>f <Plug>(easymotion-s)
nmap <leader>F <Plug>(easymotion-s2)
map <leader>/ <Plug>(easymotion-sn)
omap <leader>/ <Plug>(easymotion-tn)
map <leader>n <Plug>(easymotion-next)
map <leader>N <Plug>(easymotion-prev)
" Avoid repetitive use of the h j k and l key.
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)

" a.vim to fast switch between .h and .c/.cpp file
Plugin 'a.vim'
nmap <leader>aa :A<CR>
nmap <leader>as :AS<CR>

" switch buffer with Alt-<number>
Plugin 'wfxr/BufferSwitch'

" for quickly debug
Plugin 'quickfix/quickfix'

" Format your C, C++ and Objective-C code
Plugin 'rhysd/vim-clang-format'
let g:clang_format#style_options = {
    \ "BasedOnStyle" : "LLVM",
    \ "IndentWidth" : 4,
    \ "AccessModifierOffset" : -4,
    \ "ColumnLimit" : 80,
    \ "AllowShortFunctionsOnASingleLine" : "All",
    \ "AllowShortIfStatementsOnASingleLine" : "true",
    \ "AlwaysBreakTemplateDeclarations" : "true",
    \ "Standard" : "C++11" }
" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><leader>cf :ClangFormat<CR>
" Toggle auto formatting:
nmap <Leader>C :ClangFormatAutoToggle<CR>

" for editing markdown file conveniently
Plugin 'suan/vim-instant-markdown'

"let g:NERDSpaceDelims = 1

" 快速插入注释，需要NerdCommenter支持
Plugin 'AuthorInfo'
let g:vimrc_author='Wenxuan Zhang'
let g:vimrc_email='wenxuan-zhang@outlook.com'
let g:vimrc_homepage='wenxuan.info'
nmap <F4> :AuthorInfoDetect<cr>

" Tabular to line up text
Plugin 'godlygeek/tabular'

" Draw CSS color
Plugin 'skammer/vim-css-color'

" Syntastic config {
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0

    let g:syntastic_error_symbol = '྾' 
    let g:syntastic_warning_symbol = '⚠'
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_cpp_compiler_options = '-std=c++14'  
    "let g:synatastic_auto_loc_list=1
    "let g:syntastic_enable_signs=1
"}

" Wonderful themes
Plugin 'morhetz/gruvbox'
"Plugin 'nanotech/jellybeans.vim'
"Plugin 'zeis/vim-kolor'
"Plugin 'tpope/vim-vividchalk'
"Plugin 'Lokaltog/vim-distinguished'
"Plugin 'ryanb/dotfiles'
"Plugin 'altercation/vim-colors-solarized'
"Plugin 'dsolstad/vim-wombat256i'
"Plugin 'zenorocha/dracula-theme'

" vim plugin to display the indention levels with thin vertical lines
Plugin 'Yggdroot/indentLine'
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#4E4E4E'
map <leader>il :IndentLinesToggle<CR>

" 扩展/收缩选区
map + <Plug>(expand_region_expand)
map - <Plug>(expand_region_shrink)

" 通用的vim基本配置
Plugin 'tpope/vim-sensible'

filetype plugin indent on     " required!

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Theme
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gruvbox_italic=1
colorscheme gruvbox
set background=dark

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Taglist
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Exit when all other windows exit
let Tlist_Exit_OnlyWindow=1

" On/off TList when start vim
let Tlist_Auto_Open=0


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>nt :NERDTreeToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" YouCompleteMe
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 配置默认的ycm_extra_conf.py
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
" 打开vim时不再询问是否加载ycm_extra_conf.py配置
let g:ycm_confirm_extra_conf = 0
" 开启注释补全
let g:ycm_complete_in_comments = 1
" 开启字符串补全
let g:ycm_complete_in_strings = 1
" 开启基于标签收集引擎
let g:ycm_collect_identifiers_from_tags_files = 1
" 开启基于注释和字符串的收集引擎
let g:ycm_collect_identifiers_from_comments_and_strings = 1
" 语言关键字补全
let g:ycm_seed_identifiers_with_syntax = 1
" 从第二个字符开始展开补全
let g:ycm_min_num_of_chars_for_completion = 2
" 添加UltiSnips进行snippet补全
let g:ycm_use_ultisnips_completer = 1
" 直接显示补全
let g:ycm_key_invoke_completion = '<C-\>'
let g:ycm_autoclose_preview_window_after_completion = 1

" 映射快捷键跳转到定义或声明
nnoremap <leader>g :YcmCompleter GoTo<CR>

" ListToggle配置
let g:lt_height = 10
let g:lt_location_list_toggle_map = '<leader>1'
let g:lt_quickfix_list_toggle_map = '<leader>2'

" Helper functions {
    function! ToggleBg()
        if &background == 'dark'
            set bg=light
        else
            set bg=dark
        endif
    endfunction

    function! VisualSelection(direction, extra_filter) range
        let l:saved_reg = @"
        execute "normal! vgvy"

        let l:pattern = escape(@", '\\/.*$^~[]')
        let l:pattern = substitute(l:pattern, "\n$", "", "")

        if a:direction == 'b'
            execute "normal ?" . l:pattern . "^M"
        elseif a:direction == 'gv'
            call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.' . a:extra_filter)
        elseif a:direction == 'replace'
            call CmdLine("%s" . '/'. l:pattern . '/')
        elseif a:direction == 'f'
            execute "normal /" . l:pattern . "^M"
        endif

        let @/ = l:pattern
        let @" = l:saved_reg
    endfunction


    function! VisualSelection(direction, extra_filter) range
        let l:saved_reg = @"
        execute "normal! vgvy"

        let l:pattern = escape(@", '\\/.*$^~[]')
        let l:pattern = substitute(l:pattern, "\n$", "", "")

        if a:direction == 'b'
            execute "normal ?" . l:pattern . "^M"
        elseif a:direction == 'gv'
            call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.' . a:extra_filter)
        elseif a:direction == 'replace'
            call CmdLine("%s" . '/'. l:pattern . '/')
        elseif a:direction == 'f'
            execute "normal /" . l:pattern . "^M"
        endif

        let @/ = l:pattern
        let @" = l:saved_reg
    endfunction


    " Returns true if paste mode is enabled
    function! HasPaste()
        if &paste
            return 'PASTE MODE  '
        en
        return ''
    endfunction


    " Don't close window, when deleting a buffer
    command! Bclose call <SID>BufcloseCloseIt()
    function! <SID>BufcloseCloseIt()
       let l:currentBufNum = bufnr("%")
       let l:alternateBufNum = bufnr("#")

       if buflisted(l:alternateBufNum)
         buffer #
       else
         bnext
       endif

       if bufnr("%") == l:currentBufNum
         new
       endif

       if buflisted(l:currentBufNum)
         execute("bdelete! ".l:currentBufNum)
       endif
    endfunction
" }
