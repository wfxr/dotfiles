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
