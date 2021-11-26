local vo = vim.opt

vo.encoding = 'utf-8'
vo.termguicolors = true

vim.cmd 'source ~/.vim_base'
vim.cmd 'source ~/.vim_plug'
vim.cmd 'source ~/.vim_map'
vim.cmd 'source ~/.vim_local'

vo.mouse = 'a'
vo.linebreak = true
vo.whichwrap:append('<,>,h,l')
vo.history = 1000
vo.lazyredraw = true -- don't redraw while executing macros
vo.number = true
vo.cmdheight = 2
vo.hlsearch = true
vo.showmatch = true -- show matching brackets when text indicator is over them
vo.matchtime = 2 -- how many tenths of a second (i.e. x/10 s) to blink when matching brackets
vo.wildignore = { '*.o', '*~', '*.pyc' } -- ignore compiled files
vo.wildmode = 'full'
vo.smartindent = true
vo.cindent = true
vo.fileformat = 'unix'
vo.fileformats = 'unix,dos,mac'
vo.fileencodings = 'utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936,big5'
vo.swapfile = false
vo.undofile = true
vo.undodir = '/tmp/vim-' .. vim.env.USER .. '/undodir/'
vo.errorbells = false
vo.visualbell = true
vo.autochdir = true
vo.autoread = true
vo.diffopt = 'vertical'
vo.conceallevel=2
vo.fillchars:append('vert:⎹') -- ¦ ┆ │ ⎹⎸ ▏
vo.updatetime = 100 -- default 800ms is too slow
vo.timeoutlen = 400 -- default 1000ms is too long
vo.showmode = false
vo.showcmd = true
vo.autowrite = true
vo.signcolumn = 'yes'
vo.hidden = true
vo.backup = false
vo.writebackup = false
vo.shortmess:append('c') -- don't give 'ins-completion-menu' messages.

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
vo.background = 'dark'
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
vo.pumblend = 10 -- popup_menu
vo.winblend = 10 -- floating window

-- tags
vo.tags = './.tags;,.tags'
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
