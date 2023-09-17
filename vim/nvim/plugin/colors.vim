" highlight yanked text
au TextYankPost * silent! lua vim.highlight.on_yank { higroup="IncSearch", timeout=100 }

" highlight trailing whitespace
hi ExtraneousWhitespace guibg=red
match ExtraneousWhitespace /\(\s\+$\| \)/
autocmd BufWinEnter,CursorMovedI * highlight ExtraneousWhitespace ctermbg=red
