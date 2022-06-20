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

-- Hide number & sign columns to do tmux copy
vim.cmd [[
    function! s:tmux_copy_mode()
        setlocal nonumber
        setlocal signcolumn=no
        silent! IndentBlanklineDisable
    endfunction
    command! TmuxCopyMode call s:tmux_copy_mode()
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

-- open repo in browser
vim.cmd [[
    function! s:go_github()
        let s:repo = matchstr(expand('<cWORD>'), '\v[0-9A-Za-z\-\.\_]+/[0-9A-Za-z\-\.\_]+')
        if empty(s:repo)
            echo 'GoGithub: No repository found.'
        else
            let s:url = 'https://github.com/' . s:repo
            call netrw#BrowseX(s:url, 0)
        end
    endfunction
    augroup gogithub
        au!
        au FileType *vim,*zsh,*bash,*tmux,lua nnoremap <buffer> <silent> gW :call <sid>go_github()<cr>
    augroup END
]]

-- zoom
vim.cmd [[
    function! s:zoom()
      if winnr('$') > 1
        tab split
      elseif len(filter(map(range(tabpagenr('$')), 'tabpagebuflist(v:val + 1)'), 'index(v:val, '.bufnr('').') >= 0')) > 1
        tabclose
      endif
    endfunction
    nnoremap <silent> <c-w><c-w> :call <sid>zoom()<cr>
]]


-- Strip trailing whitespaces
vim.cmd [[
    function! s:strip_whitespace()
        let l:save = winsaveview()
        keeppatterns %s/\s\+$//e
        call winrestview(l:save)
    endfun
    command! StripWhitespace call s:strip_whitespace()
]]

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
