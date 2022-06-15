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
            highlight link NormalFloat Normal
        ]]
    end
}
ui["stevearc/dressing.nvim"] = {
    opt = true,
    after = "telescope.nvim",
    config = function ()
        require('dressing').setup({
            input = {
                default_prompt = "Input:",
                border = { "┏", "─", "┓", "│", "┛", "─", "┗", "│" },
                winblend = 5,
                winhighlight = "NormalFloat:Normal",
            },
            select = {
                enabled = true,
                -- Priority list of preferred vim.select implementations
                backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },
                -- Options for built-in selector
                builtin = {
                    border = { "┏", "─", "┓", "│", "┛", "─", "┗", "│" },
                    winblend = 5,
                },
            }
        })
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
            text = {
                spinner = 'meter',
                done = '',
            },
        }
    end
}
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
ui["goolord/alpha-nvim"] = {
    opt = true,
    event = "BufWinEnter",
    config = function ()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        dashboard.section.header.val = {
            [[                                                       ]],
            [[                                                       ]],
            [[                                  ,     ,              ]],
            [[                                  )\___/(              ]],
            [[                                 {(@)v(@)}             ]],
            [[                                  {|~~~|}              ]],
            [[                                  {/^^^\}              ]],
            [[                              -=-~'`m-m` .-^-_ wfxr    ]],
            [[ ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗]],
            [[ ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║]],
            [[ ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║]],
            [[ ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║]],
            [[ ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║]],
            [[ ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝]],
            [[                                                       ]],
            [[                                                       ]],
            [[                                                       ]],
        }

        local function button(sc, txt, leader_txt, keybind, keybind_opts)
            local sc_after = sc:gsub("%s", ""):gsub(leader_txt, "<leader>")

            local opts = {
                position = "center",
                shortcut = sc,
                cursor = 5,
                width = 50,
                align_shortcut = "right",
                hl_shortcut = "Keyword",
            }

            if nil == keybind then
                keybind = sc_after
            end
            keybind_opts = vim.F.if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
            opts.keymap = { "n", sc_after, keybind, keybind_opts }

            local function on_press()
                local key = vim.api.nvim_replace_termcodes(sc_after .. "<Ignore>", true, false, true)
                vim.api.nvim_feedkeys(key, "t", false)
            end

            return {
                type = "button",
                val = txt,
                on_press = on_press,
                opts = opts,
            }
        end

        local leader = "comma"
        dashboard.section.buttons.val = {
            button("i",         " File new",      leader, "<cmd>enew<cr>i"),
            button("comma f r", " File frecency", leader, "<cmd>Telescope frecency<cr>"),
            button("comma f e", " File history",  leader, "<cmd>Telescope oldfiles<cr>"),
            button("comma f f", " File find",     leader, "<cmd>Telescope find_files<cr>"),
            button("comma f w", " Word find",     leader, "<cmd>Telescope live_grep<cr>"),
            button("comma s c", " Scheme change", leader, "<cmd>Telescope colorscheme<cr>"),
        }
        dashboard.section.buttons.opts.hl = "String"

        local function footer()
            return "🐬  Have Fun with neovim"
            .. " v"
            .. vim.version().major
            .. "."
            .. vim.version().minor
            .. "."
            .. vim.version().patch
        end

        dashboard.section.footer.val = footer()
        dashboard.section.footer.opts.hl = "Function"

        local head_butt_padding = 2
        local occu_height = #dashboard.section.header.val + 2 * #dashboard.section.buttons.val + head_butt_padding
        local header_padding = math.max(0, math.ceil((vim.fn.winheight("$") - occu_height) * 0.25))
        local foot_butt_padding = 1

        dashboard.config.layout = {
            { type = "padding", val = header_padding },
            dashboard.section.header,
            { type = "padding", val = head_butt_padding },
            dashboard.section.buttons,
            { type = "padding", val = foot_butt_padding },
            dashboard.section.footer,
        }

        alpha.setup(dashboard.opts)
    end
}

return ui
