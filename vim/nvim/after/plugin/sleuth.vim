augroup sleuthcompat
    autocmd!
    autocmd FileType * if len(findfile('.editorconfig', '.;')) == 0 | silent! Sleuth | endif
augroup END
