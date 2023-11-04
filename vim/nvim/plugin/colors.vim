" highlight yanked text
au TextYankPost * silent! lua vim.highlight.on_yank { higroup="IncSearch", timeout=100 }

let g:gruvbox_material_enable_bold        = 1
let g:gruvbox_material_enable_italic      = 1
let g:gruvbox_material_visual             = 'green background'
let g:gruvbox_material_background         = 'medium'
let g:gruvbox_material_foreground         = 'material'

let g:everforest_background = 'hard'

set background=dark
colorscheme everforest

" Override GitSigns colors
exec 'hi! GitSignsAdd    ctermfg=Green  guifg=#50FA7B'
exec 'hi! GitSignsDelete ctermfg=Red    guifg=#FF5555'
exec 'hi! GitSignsChange ctermfg=Yellow guifg=#FFB86C'

highlight FloatBorder guibg=NONE ctermbg=NONE
highlight FloatTitle  guibg=NONE ctermbg=NONE
highlight link NormalFloat Normal
