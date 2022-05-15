local vim = vim

local disable_distribution_plugins = function()
    vim.g.did_load_filetypes = 1
    vim.g.did_load_fzf = 1
    vim.g.did_load_gtags = 1
    vim.g.did_load_gzip = 1
    vim.g.did_load_tar = 1
    vim.g.did_load_tarPlugin = 1
    vim.g.did_load_zip = 1
    vim.g.did_load_zipPlugin = 1
    vim.g.did_load_getscript = 1
    vim.g.did_load_getscriptPlugin = 1
    vim.g.did_load_vimball = 1
    vim.g.did_load_vimballPlugin = 1
    vim.g.did_load_matchit = 1
    vim.g.did_load_matchparen = 1
    vim.g.did_load_2html_plugin = 1
    vim.g.did_load_logiPat = 1
    vim.g.did_load_rrhelper = 1
    vim.g.did_load_netrw = 1
    vim.g.did_load_netrwPlugin = 1
    vim.g.did_load_netrwSettings = 1
    vim.g.did_load_netrwFileHandlers = 1
end

local leader_map = function()
    vim.g.mapleader = ","
    vim.api.nvim_set_keymap("n", " ", "", { noremap = true })
    vim.api.nvim_set_keymap("x", " ", "", { noremap = true })
end

local neovide_config = function()
    vim.cmd([[set guifont=JetBrainsMono\ Nerd\ Font:h12]])
    vim.g.neovide_refresh_rate = 60
    vim.g.neovide_cursor_vfx_mode = "railgun"
    vim.g.neovide_no_idle = true
    vim.g.neovide_cursor_animation_length = 0.03
    vim.g.neovide_cursor_trail_length = 0.05
    vim.g.neovide_cursor_antialiasing = true
    vim.g.neovide_cursor_vfx_opacity = 200.0
    vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
    vim.g.neovide_cursor_vfx_particle_speed = 20.0
    vim.g.neovide_cursor_vfx_particle_density = 5.0
end

local dashboard_config = function()
    vim.g.dashboard_footer_icon = "🐬 "
    vim.g.dashboard_default_executive = "telescope"

    vim.g.dashboard_custom_header = {
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

    vim.g.dashboard_custom_section = {
        find_frecency = {
            description = { " File frecency              comma f r " },
            command = "Telescope frecency",
        },
        find_history = {
            description = { " File history               comma f e " },
            command = "DashboardFindHistory",
        },
        find_project = {
            description = { " Project find               comma f p " },
            command = "Telescope project",
        },
        find_file = {
            description = { " File find                  comma f f " },
            command = "DashboardFindFile",
        },
        file_new = {
            description = { " File new                   comma f n " },
            command = "DashboardNewFile",
        },
        find_word = {
            description = { " Word find                  comma f w " },
            command = "DashboardFindWord",
        },
    }
end

local load_core = function()
    local pack = require("core.pack")
    disable_distribution_plugins()
    leader_map()

    neovide_config()
    dashboard_config()

    require("core.options")
    require("core.mapping")
    require("keymap")
    require("core.event")
    require("core.utils")
    pack.load_compile()
end

load_core()
