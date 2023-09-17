if &modifiable
    setlocal conceallevel=0
    setlocal cursorcolumn
endif

" This is to override hover.nvim's K keymap
nnoremap <buffer> K K
