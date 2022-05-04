local ui = {}
local conf = require("modules.ui.config")

ui["sainnhe/gruvbox-material"] = {
    opt = false,
    config = function()
        vim.cmd [[
            let g:gruvbox_material_enable_bold = 1
            let g:gruvbox_material_enable_italic = 1
            let g:gruvbox_material_current_word = 'grey background'
            let g:gruvbox_material_visual = 'grey background'
            let g:gruvbox_material_background = 'medium'
            let g:gruvbox_material_palette = {
                \ 'bg0':              ['#282828', '235'],
                \ 'bg1':              ['#32302f', '236'],
                \ 'bg2':              ['#32302f', '236'],
                \ 'bg3':              ['#45403d', '237'],
                \ 'bg4':              ['#45403d', '237'],
                \ 'bg5':              ['#5a524c', '239'],
                \ 'bg_statusline1':   ['#32302f', '236'],
                \ 'bg_statusline2':   ['#3a3735', '236'],
                \ 'bg_statusline3':   ['#504945', '240'],
                \ 'bg_diff_green':    ['#34381b', '22'],
                \ 'bg_visual_green':  ['#3b4439', '22'],
                \ 'bg_diff_red':      ['#402120', '52'],
                \ 'bg_visual_red':    ['#4c3432', '52'],
                \ 'bg_diff_blue':     ['#0e363e', '17'],
                \ 'bg_visual_blue':   ['#374141', '17'],
                \ 'bg_visual_yellow': ['#4f422e', '94'],
                \ 'bg_current_word':  ['#2e3b3b', '237'],
                \ 'fg0':              ['#d4be98', '223'],
                \ 'fg1':              ['#ddc7a1', '223'],
                \ 'red':              ['#ea6962', '167'],
                \ 'orange':           ['#e78a4e', '208'],
                \ 'yellow':           ['#d8a657', '214'],
                \ 'green':            ['#a9b665', '142'],
                \ 'aqua':             ['#89b482', '108'],
                \ 'blue':             ['#7daea3', '109'],
                \ 'purple':           ['#d3869b', '175'],
                \ 'bg_red':           ['#ea6962', '167'],
                \ 'bg_green':         ['#a9b665', '142'],
                \ 'bg_yellow':        ['#d8a657', '214'],
                \ 'grey0':            ['#7c6f64', '243'],
                \ 'grey1':            ['#928374', '245'],
                \ 'grey2':            ['#a89984', '246'],
                \ 'none':             ['NONE',    'NONE']
                \ }
        ]]
        vim.opt.background = 'dark'
        vim.cmd 'colorscheme gruvbox-material'
    end
}
ui["kyazdani42/nvim-web-devicons"] = { opt = false }
ui["shaunsingh/nord.nvim"] = { opt = false, config = conf.nord }
ui["sainnhe/edge"] = { opt = false, config = conf.edge }
ui["catppuccin/nvim"] = {
    opt = false,
    as = "catppuccin",
    config = conf.catppuccin,
}
ui["hoob3rt/lualine.nvim"] = {
    opt = true,
    after = "lualine-lsp-progress",
    config = conf.lualine,
}
ui["SmiteshP/nvim-gps"] = {
    opt = true,
    after = "nvim-treesitter",
    config = conf.nvim_gps,
}
ui["arkav/lualine-lsp-progress"] = { opt = true, after = "nvim-gps" }
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
    opt = true,
    event = "BufRead",
    config = conf.indent_blankline,
}
ui["akinsho/bufferline.nvim"] = {
    opt = true,
    tag = "*",
    event = "BufRead",
    config = conf.nvim_bufferline,
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
