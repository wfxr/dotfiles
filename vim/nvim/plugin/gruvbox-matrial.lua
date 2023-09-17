vim.g.gruvbox_material_enable_bold = 1
vim.g.gruvbox_material_enable_italic = 1
vim.g.gruvbox_material_visual = 'green background'
vim.g.gruvbox_material_background = 'medium'
vim.g.gruvbox_material_foreground = 'material'
vim.g.gruvbox_material_better_performance = 1
vim.opt.background = 'dark'
vim.cmd.colorscheme { "gruvbox-material" }

vim.cmd [[
    highlight FloatBorder guibg=NONE ctermbg=NONE
    highlight link NormalFloat Normal
]]

vim.cmd [[
    exec 'hi! GitSignsAdd    ctermfg=Green  guifg=#50FA7B'
    exec 'hi! GitSignsDelete ctermfg=Red    guifg=#FF5555'
    exec 'hi! GitSignsChange ctermfg=Yellow guifg=#FFB86C'
]]
