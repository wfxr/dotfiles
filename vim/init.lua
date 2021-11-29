vim.opt.encoding = 'utf-8'
vim.opt.termguicolors = true

vim.cmd 'source ~/.vim_base'
vim.cmd 'source ~/.vim_plug'
vim.cmd 'source ~/.vim_map'
vim.cmd 'source ~/.vim_local'

vim.opt.mouse = 'a'
vim.opt.linebreak = true
vim.opt.whichwrap:append('<,>,h,l')
vim.opt.history = 1000
vim.opt.lazyredraw = true -- don't redraw while executing macros
vim.opt.number = true
vim.opt.cmdheight = 2
vim.opt.hlsearch = true
vim.opt.showmatch = true -- show matching brackets when text indicator is over them
vim.opt.matchtime = 2 -- how many tenths of a second (i.e. x/10 s) to blink when matching brackets
vim.opt.wildignore = { '*.o', '*~', '*.pyc' } -- ignore compiled files
vim.opt.wildmode = 'full'
vim.opt.smartindent = true
vim.opt.cindent = true
vim.opt.fileformat = 'unix'
vim.opt.fileformats = 'unix,dos,mac'
vim.opt.fileencodings = 'utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936,big5'
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = '/tmp/vim-' .. vim.env.USER .. '/undodir/'
vim.opt.errorbells = false
vim.opt.visualbell = true
vim.opt.autochdir = true
vim.opt.autoread = true
vim.opt.diffopt = 'vertical'
vim.opt.conceallevel=2
vim.opt.fillchars:append('vert:⎹') -- ¦ ┆ │ ⎹⎸ ▏
vim.opt.updatetime = 100 -- default 800ms is too slow
vim.opt.timeoutlen = 400 -- default 1000ms is too long
vim.opt.showmode = false
vim.opt.showcmd = true
vim.opt.autowrite = true
vim.opt.signcolumn = 'yes'
vim.opt.hidden = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.shortmess:append('c') -- don't give 'ins-completion-menu' messages.

vim.cmd [[
    autocmd InsertLeave,WinEnter * set cursorline
    autocmd InsertEnter,WinLeave * set nocursorline
]]


-- set spell in certain cases
vim.cmd [[
    augroup spell
        au FileType text,markdown,gitcommit setl spell
    augroup END
]]

-- " Have Vim jump to the last position when reopening a file
vim.cmd [[
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]]

vim.cmd 'colorscheme gruvbox-material'
vim.opt.background = 'dark'
vim.cmd [[
    exec 'hi! SignifySignAdd    ctermfg=Green  guifg=#50FA7B ' . (has('termguicolors')? 'guibg=':'ctermbg=') . synIDattr(hlID('SignColumn'),'bg')
    exec 'hi! SignifySignDelete ctermfg=Red    guifg=#FF5555 ' . (has('termguicolors')? 'guibg=':'ctermbg=') . synIDattr(hlID('SignColumn'),'bg')
    exec 'hi! SignifySignChange ctermfg=Yellow guifg=#FFB86C ' . (has('termguicolors')? 'guibg=':'ctermbg=') . synIDattr(hlID('SignColumn'),'bg')
    hi HighlightedyankRegion ctermbg=Red       guibg=#fb4934
    hi MinimapCurrentLine    ctermfg=Green     guifg=#50FA7B guibg=#3a3a3a
    hi MinimapCurrentRange   ctermfg=DarkGreen guifg=#87c596 guibg=#3a3a3a
    hi GitBlameVirtualText   cterm=italic      ctermfg=245   gui=italic guifg=#665c54
]]

-- transparent
vim.opt.pumblend = 10 -- popup_menu
vim.opt.winblend = 10 -- floating window

-- tags
vim.opt.tags = './.tags;,.tags'
vim.env.GTAGSLABEL = 'native-pygments'
vim.env.GTAGSCONF = '~/.gtags.conf'

-- Show changes since last save
vim.cmd [[
    function! s:DiffSaved()
      let filetype=&filetype
      diffthis
      vnew | r # | normal! 1Gdd
      diffthis
      exe 'setl bt=nofile bh=wipe nobl noswf ro ft=' . filetype
    endfunction
    command! DS call s:DiffSaved()
]]

-- Split and open terminal
vim.cmd [[
    command! -nargs=* T botright sp | resize 20 | term <args>
    command! -nargs=* VT vsp | term <args>
    noremap  <a-1> :T<cr>A
]]

-- Hide number & sign columns to do tmux copy
vim.cmd [[
    function! s:tmux_copy_mode_toggle()
        setlocal number!
        if &signcolumn ==? 'no'
            setlocal signcolumn=yes
        else
            setlocal signcolumn=no
        endif
    endfunction
    command! TmuxCopyModeToggle call s:tmux_copy_mode_toggle()
]]

-- Add custom filetypes detection. Mainly for ultisnips
vim.cmd [[
    augroup custom_filetype
        au!
        au BufRead,BufNewFile pom.xml           setl ft=maven.xml
        au BufRead,BufNewFile build.gradle      setl ft=gradle.groovy
        au BufRead,BufNewFile *.esquery.json    setl ft=esquery.json
        au BufRead,BufNewFile *pre-commit       setl ft=sh
        au BufNewFile,BufRead coc-settings.json setl ft=jsonc

        au Filetype *vim,*tmux setl foldenable | setl foldmethod=marker
        au Filetype *json      setl shiftwidth=2

        " au BufRead,BufNewFile * call DetectNoneExtensionFileType()

        " Disable automatic comment insertion
        " http://vim.wikia.com/wiki/Disable_automatic_comment_insertion
        au FileType * setl formatoptions-=cro
    augroup END
]]

-- Automatic rename of tmux window
if vim.env.TMUX ~= nil and vim.env.NORENAME == nil then
    vim.cmd [[
        augroup rename_tmux
            au!
            au BufEnter * if empty(&buftype) | call system('tmux rename-window '.expand('%:t:S')) | endif
            au VimLeave * call system('tmux set-window automatic-rename on')
        augroup END
    ]]
end

-- Prevent vim clearing the system clipboard
vim.cmd [[
    if executable('xsel')
        function! PreserveClipboard()
            call system('xsel -ib', getreg('+'))
        endfunction
        function! PreserveClipboadAndSuspend()
            call PreserveClipboard()
            suspend
        endfunction
        augroup preserve_clipboard
          au!
          au VimLeave * call PreserveClipboard()
        augroup END
        nnoremap <silent> <c-z> :call PreserveClipboadAndSuspend()<cr>
        vnoremap <silent> <c-z> :<c-u>call PreserveClipboadAndSuspend()<cr>
    endif
]]
