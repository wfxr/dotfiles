" i want to be able to leave terminal yes pls
tnoremap <Esc> <C-\><C-n>

" search and highlight but dont jump
nnoremap * :keepjumps normal! mi*`i<CR>
nnoremap # :keepjumps normal! mi#`i<CR>

nmap <Esc> <cmd>noh<CR>

nnoremap <C-Space> <C-^>

" Use the text that has already been typed as the prefix for searching through commands
cnoremap <expr> <C-p> pumvisible() ? "<C-p>" : "<Up>"
cnoremap <expr> <C-n> pumvisible() ? "<C-n>" : "<Down>"

" With a map leader it's possible to do extra key combinations
let mapleader = ','
let g:mapleader = ','
noremap \ ,

" Using <SPACE> to fold or unfold
nnoremap <silent> <SPACE><SPACE> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
" nnoremap <silent> <SPACE><CR> zi
nnoremap <silent><expr> <SPACE><CR> &foldlevel ? 'zM' :'zR'


" Disable highlight & redraw
nnoremap <silent> <leader><cr> :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

" These create newlines like o and O but stay in normal mode
nnoremap <silent> zj o<Esc>k
nnoremap <silent> zk O<Esc>j
nnoremap <silent> zl i <Esc>l
"inoremap <silent> <leader>i <Home>
"inoremap <silent> <leader>a <End>
inoremap <silent> <leader>, <End>,<Esc>
inoremap <silent> <leader>; <End>;<Esc>
inoremap <silent> <leader>{ <End> {<CR>}<C-o>O
inoremap <silent> <leader>. ->
"inoremap <silent> <leader>o <C-o>o
"inoremap <silent> <leader>O <C-o>O

" Make j/k/0/$ work as expected on the wrap lines
" noremap <buffer> <silent> k gk
" noremap <buffer> <silent> j gj
" noremap <buffer> <silent> gk k
" noremap <buffer> <silent> gj j
" noremap <buffer> <silent> 0 g0
" noremap <buffer> <silent> $ g$

" Quit
noremap <C-c> :q<cr>
" Save write
noremap <C-s> :update<cr>
" Save & quit
noremap <C-x> :x<cr>

" Save and suspend
noremap <leader>bg :w<cr><C-z>

" Remove the Windows ^M - when the encodings gets messed up
noremap <leader>M mmHmt:%s/<C-v><CR>//ge<CR>'tzt'm

" Yank & paste
" noremap  <c-y> "+yy
" vnoremap <c-y> "+y
inoremap <c-v> <c-o>:set paste<cr><c-r>+<c-o>:set nopaste<cr>

" Select pasted text
noremap gp `[v`]

noremap H 0
noremap L $

" Emacs style key mapping
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <leader>a <End>
inoremap <leader>e <End>
inoremap <C-h> <BS>
inoremap <C-d> <Del>
inoremap <C-f> <Right>
inoremap <C-b> <Left>
" In insert mode, pressing Ctrl-O switches to normal mode for one command, then switches back to insert mode when the command is finished.
inoremap <C-k> <C-o>D
inoremap <C-u> <Esc>v0c

" Quickly move in normal mode
noremap <c-j> <c-y>
noremap <c-k> <c-e>
noremap <c-e> A
noremap <c-a> I

" Paste multiple times
xnoremap p pgvy

" Move between windows quickly
noremap  <A-h> <C-w>h
noremap  <A-j> <C-w>j
noremap  <A-k> <C-w>k
noremap  <A-l> <C-w>l
" nnoremap <tab>   <c-w>w
" nnoremap <S-tab> <c-w>W

" Toggle line wrap
noremap <A-w> :set wrap!<CR>

map <C-Up> :resize +1<cr>
map <C-Down> :resize -1<cr>
map <C-Right> :vertical resize +1<cr>
map <C-Left> :vertical resize -1<cr>

" Useful mappings for managing tabs
map <leader>tc :tabnew<SPACE>
map <leader>tq :tabclose<CR>
map <leader>tn :tabnext<CR>
map <leader>tp :tabNext<CR>

" pressing <leader>ss will toggle spell checking
noremap <leader>ss :setlocal spell!<cr>
noremap <leader>sn ]s
noremap <leader>sp [s
noremap <leader>sa zg
noremap <leader>s? z=

nnoremap q: <Nop>
nnoremap q/ <Nop>
nnoremap q? <Nop>

" nnoremap <Up> <Nop>
" nnoremap <Down> <Nop>
" nnoremap <Left> <Nop>
" nnoremap <Right> <Nop>

noremap ： :

" Save with root
cnoremap W!! w !sudo tee % >/dev/null<cr>

" Lock up history commands quickly
" cnoremap <C-p> <Up>
" cnoremap <C-n> <Down>

" Don't lose selection when shifting sidewards
xnoremap < <gv
xnoremap > >gv

" List all tags if possible
" nnoremap <c-]> g<c-]>

" qq to record, Q to replay
nnoremap Q @q

" g{ / g} to split / join {} block in c,cpp,java etc.
nnoremap <silent> g{ va{:s/\%V{\s\+\(\S.*\S\)\s\+}/{\r\1\r}/<cr>va{:s/;\s\+/;\r/g<cr>j=a{:noh<cr>
nnoremap <silent> g} va{J<esc>

" terminal mode mapping
if v:version >= 800
  tnoremap <Esc> <C-\><C-n>
endif

nnoremap <silent> <leader>ee :e<cr>

" nnoremap <silent> <tab> :call system('tmux select-pane -t :.+')<cr>

nmap ga :EasyAlign<cr>
xmap ga :EasyAlign<cr>
