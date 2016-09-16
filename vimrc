"=============================================================================
"       Author: Wenxuan Zhang
"        Email: wenxuan-zhang@outlook.com
"     HomePage: wenxuan.info
"=============================================================================

if has("win32") || has("win64")
    let g:isWIN = 1
else
    let g:isWIN = 0
endif

source ~/.vimrc.commons
source ~/.vimrc.plugins

if has("gui_running")
    source ~/.vimrc.gui
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Change to English version. (Replaced 'en_US' by 'zh_CN' for Chinese)
let $LANG = 'en_US'
set langmenu=en_US

" Add 'cjk' to spelllang to avoid checking Chinese
set spelllang+=cjk

" Use spell check
setlocal spell

" Enable mouse
set mouse=a

" Linebrake on 90 characters
set linebreak
set textwidth=90
set wrap

" Hilight current line
"set cursorline

" Make '<', '>', 'h', 'l' work properly.
set whichwrap+=<,>,h,l

" Set how many lines of history Vim will remember
set history=1000

" Don't redraw while executing macros (good performance config)
set lazyredraw

" Share clipboard with windows
set clipboard+=unnamed

" Show row number
set number
" Show relative number
"set relativenumber

" Set height of cmd line to 2
set cmdheight=2

" Highlight search matches
set hlsearch

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second (i.e. x/10 s) to blink when matching brackets
set matchtime=2

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
set wildmode=full

" Set auto indent and C/C++ indent
set smartindent
set cindent

" 设置编码格式为UTF-8,防止中文乱码
set encoding=utf-8

" Set the sequence of auto encoding
set fileencodings=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936,big5

" No swap files, use version control instead
set noswapfile

" Use Unix as the standard file type
set fileformat=unix
set fileformats=unix,dos,mac
set diffopt=vertical

" disable Background Color Erase (BCE) so that color schemes
" render properly when inside 256-color tmux and GNU screen.
" see also http://snk.tuxfamily.org/log/vim-256color-bce.html
set t_ut=

" Home away from home. We store some config files and snippets here and the
" whole dotfiles dir is a git repo. Should be the last entry in rtp (for
" UltiSnips).
set rtp+=$HOME/.dotfiles/vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <C-Up> :resize +1<cr>
map <C-Down> :resize -1<cr>
map <C-Right> :vertical resize +1<cr>
map <C-Left> :vertical resize -1<cr>

" Useful mappings for managing tabs
map <leader>tc :tabnew<SPACE>
"map <leader>to :tabonly<CR>
map <leader>tq :tabclose<CR>
"map <leader>t<tab> :tabnext<CR>
map <leader>tn :tabnext<CR>
map <leader>tp :tabNext<CR>

" pressing <leader>ss will toggle spell checking
noremap <leader>ss :setlocal spell!<cr>
noremap <leader>sn ]s
noremap <leader>sp [s
noremap <leader>sa zg
noremap <leader>s? z=

colorscheme gruvbox
set background=dark
