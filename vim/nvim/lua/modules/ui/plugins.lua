local ui = {}
local conf = require("modules.ui.config")

ui["sainnhe/gruvbox-material"] = {
    opt = false,
    config = function()
        vim.g.gruvbox_material_enable_bold = 1
        vim.g.gruvbox_material_enable_italic = 1
        vim.g.gruvbox_material_visual = 'green background'
        vim.g.gruvbox_material_background = 'medium'
        vim.g.gruvbox_material_palette = 'material'
        vim.g.gruvbox_material_better_performance = 1
        vim.opt.background = 'dark'
        vim.cmd [[
            colorscheme gruvbox-material
            highlight FloatBorder guibg=NONE ctermbg=NONE
        ]]
    end
}
ui["kyazdani42/nvim-web-devicons"] = { opt = false }
ui["hoob3rt/lualine.nvim"] = {
    opt = false,
    config = conf.lualine,
}
ui["j-hui/fidget.nvim"] = {
    opt = true,
    after = "nvim-lspconfig",
    config = function ()
        require('fidget').setup {
            text = { spinner = 'meter' },
        }
    end
}
ui["glepnir/dashboard-nvim"] = { opt = true, event = "BufWinEnter" }
ui["kyazdani42/nvim-tree.lua"] = {
    opt = true,
    cmd = { "NvimTreeToggle" },
    config = conf.nvim_tree,
}
ui["lewis6991/gitsigns.nvim"] = {
    opt = true,
    event = { "BufRead", "BufNewFile" },
    config = conf.gitsigns,
    requires = { "nvim-lua/plenary.nvim", opt = true },
}
ui["lukas-reineke/indent-blankline.nvim"] = {
    opt = false,
    config = conf.indent_blankline,
}
ui["petertriho/nvim-scrollbar"] = {
    opt = true,
    event = "BufRead",
    config = function()
        require("scrollbar").setup()
    end,
}
ui["wfxr/minimap.vim"] = {
    opt = true,
    event = "BufRead",
    config = function()
        vim.cmd [[
            hi MinimapCurrentLine  ctermfg=Green     guifg=#50FA7B guibg=#3a3a3a
            hi MinimapCurrentRange ctermfg=DarkGreen guifg=#87c596 guibg=#3a3a3a
        ]]
        vim.g.minimap_auto_start = 0
        vim.g.minimap_width = 10
        vim.g.minimap_cursor_color = 'MinimapCurrentLine'
        vim.g.minimap_range_color = 'MinimapCurrentRange'
        vim.g.minimap_auto_start_win_enter = 1
        vim.g.minimap_highlight_range = 1
        vim.g.minimap_block_filetypes = { 'aerial', 'NvimTree', 'fugitive', 'nerdtree', 'tagbar', 'coc-explorer', 'vista' }
        vim.g.minimap_close_filetypes = { 'startify', 'netrw', 'vim-plug' }
    end
}
ui["mbbill/undotree"] = {
    opt = true,
    cmd = "UndotreeToggle",
}

return ui
