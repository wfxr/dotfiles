function! s:bonly() abort
    let buf = bufnr("%")
    exe 'bufdo if bufnr("%") != ' . l:buf . ' | bd | endif'
endfunction

function! s:bdiff() abort
    exe 'w !git diff --no-index % -'
endfunction

command! Bonly call s:bonly()
command! Bdiff call s:bdiff()
