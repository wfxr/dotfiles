local config = {}

function config.edge()
    vim.cmd([[set background=dark]])
    vim.g.edge_style = "aura"
    vim.g.edge_enable_italic = 1
    vim.g.edge_disable_italic_comment = 1
    vim.g.edge_show_eob = 1
    vim.g.edge_better_performance = 1
    vim.g.edge_transparent_background = 1
end

function config.nord()
    vim.g.nord_contrast = true
    vim.g.nord_borders = false
    vim.g.nord_cursorline_transparent = true
    vim.g.nord_disable_background = false
    vim.g.nord_enable_sidebar_background = true
    vim.g.nord_italic = false
end

function config.catppuccin()
    require("catppuccin").setup({
        transparent_background = true,
        term_colors = true,
        styles = {
            comments = "italic",
            functions = "italic,bold",
            keywords = "italic",
            strings = "NONE",
            variables = "NONE",
        },
        integrations = {
            treesitter = true,
            native_lsp = {
                enabled = true,
                virtual_text = {
                    errors = "italic",
                    hints = "italic",
                    warnings = "italic",
                    information = "italic",
                },
                underlines = {
                    errors = "underline",
                    hints = "underline",
                    warnings = "underline",
                    information = "underline",
                },
            },
            lsp_trouble = true,
            lsp_saga = true,
            gitgutter = false,
            gitsigns = true,
            telescope = true,
            nvimtree = { enabled = true, show_root = true },
            which_key = true,
            indent_blankline = { enabled = true, colored_indent_levels = false },
            dashboard = true,
            neogit = false,
            vim_sneak = false,
            fern = false,
            barbar = false,
            bufferline = true,
            markdown = true,
            lightspeed = false,
            ts_rainbow = true,
            hop = true,
        },
    })
end

function config.lualine()
    local gps = require("nvim-gps")

    local function gps_content()
        if gps.is_available() then
            return gps.get_location()
        else
            return ""
        end
    end
    local mini_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "location" },
    }
    local simple_sections = {
        lualine_a = { "mode" },
        lualine_b = { "filetype" },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "location" },
    }
    local minimap = {
        sections = mini_sections,
        filetypes = { "minimap" },
    }
    local aerial = {
        sections = mini_sections,
        filetypes = { "aerial" },
    }
    local dapui_scopes = {
        sections = simple_sections,
        filetypes = { "dapui_scopes" },
    }

    local dapui_breakpoints = {
        sections = simple_sections,
        filetypes = { "dapui_breakpoints" },
    }

    local dapui_stacks = {
        sections = simple_sections,
        filetypes = { "dapui_stacks" },
    }

    local dapui_watches = {
        sections = simple_sections,
        filetypes = { "dapui_watches" },
    }

    require("lualine").setup({
        options = {
            icons_enabled = true,
            theme = "auto",
            disabled_filetypes = {},
            component_separators = "",
            section_separators = { left = "", right = "" },
            globalstatus = true,
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = { { "branch" }, { "diff" } },
            lualine_c = {
                { "lsp_progress" },
                { gps_content, cond = gps.is_available },
            },
            lualine_x = {
                {
                    "diagnostics",
                    sources = { "nvim_diagnostic" },
                    symbols = { error = " ", warn = " ", info = " " },
                },
            },
            lualine_y = {
                {
                    "filetype",
                    "encoding",
                },
                {
                    "fileformat",
                    icons_enabled = true,
                    symbols = {
                        unix = "LF",
                        dos = "CRLF",
                        mac = "CR",
                    },
                },
            },
            lualine_z = { "progress", "location" },
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { "filename" },
            lualine_x = { "location" },
            lualine_y = {},
            lualine_z = {},
        },
        tabline = {
            lualine_a = {
                {
                    'buffers',
                    mode = 2,
                    show_modified_status = true,
                }
            },
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {}
        },

        extensions = {
            "quickfix",
            "nvim-tree",
            "toggleterm",
            "fugitive",
            minimap,
            aerial,
            dapui_scopes,
            dapui_breakpoints,
            dapui_stacks,
            dapui_watches,
        },
    })
end

function config.nvim_gps()
    require("nvim-gps").setup({
        icons = {
            ["class-name"] = " ", -- Classes and class-like objects
            ["function-name"] = " ", -- Functions
            ["method-name"] = " ", -- Methods (functions inside class-like objects)
        },
        languages = {
            -- You can disable any language individually here
            ["c"] = true,
            ["cpp"] = true,
            ["go"] = true,
            ["java"] = true,
            ["javascript"] = true,
            ["lua"] = true,
            ["python"] = true,
            ["rust"] = true,
        },
        separator = " > ",
    })
end

function config.nvim_tree()
    vim.g.nvim_tree_root_folder_modifier = ":e"
    vim.g.nvim_tree_icon_padding = " "
    vim.g.nvim_tree_symlink_arror = "  "
    vim.g.nvim_tree_respect_buf_cwd = 1

    vim.g.nvim_tree_icons = {
        ["default"] = "", --
        ["symlink"] = "",
        ["git"] = {
            ["unstaged"]  = "",
            ["staged"]    = "", --
            ["unmerged"]  = "שׂ",
            ["renamed"]   = "", --
            ["untracked"] = "ﲉ",
            ["deleted"]   = "",
            ["ignored"]   = "", --◌
        },
        ["folder"] = {
            -- ['arrow_open'] = "",
            -- ['arrow_closed'] = "",
            ["arrow_open"]   = "",
            ["arrow_closed"] = "",
            ["default"]      = "",
            ["open"]         = "",
            ["empty"]        = "",
            ["empty_open"]   = "",
            ["symlink"]      = "",
            ["symlink_open"] = "",
        },
    }

    require("nvim-tree").setup({
        auto_reload_on_write = true,
        disable_netrw = false,
        hijack_cursor = true,
        hijack_netrw = true,
        hijack_unnamed_buffer_when_opening = false,
        ignore_buffer_on_setup = false,
        open_on_setup = false,
        open_on_setup_file = false,
        open_on_tab = false,
        sort_by = "name",
        update_cwd = true,
        view = {
            width = 30,
            height = 30,
            side = "left",
            preserve_window_proportions = false,
            number = false,
            relativenumber = false,
            signcolumn = "yes",
            hide_root_folder = false,
        },
        renderer = {
            indent_markers = {
                enable = true,
                icons = {
                    corner = "└ ",
                    edge = "│ ",
                    none = "  ",
                },
            },
        },
        hijack_directories = {
            enable = true,
            auto_open = true,
        },
        update_focused_file = {
            enable = true,
            update_cwd = true,
            ignore_list = {},
        },
        ignore_ft_on_setup = {},
        filters = {
            dotfiles = false,
            custom = { ".DS_Store" },
            exclude = {},
        },
        actions = {
            use_system_clipboard = true,
            change_dir = {
                enable = true,
                global = false,
            },
            open_file = {
                quit_on_open = false,
                resize_window = false,
                window_picker = {
                    enable = true,
                    chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                    exclude = {
                        filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                        buftype = { "nofile", "terminal", "help" },
                    },
                },
            },
        },
    })
end

-- function config.nvim_bufferline()
--     require("bufferline").setup({
--         options = {
--             number = "none",
--             indicator_icon = '▎',
--             modified_icon = "●",
--             buffer_close_icon = "",
--             left_trunc_marker = "",
--             right_trunc_marker = "",
--             max_name_length = 14,
--             max_prefix_length = 13,
--             tab_size = 20,
--             show_buffer_close_icons = true,
--             show_buffer_icons = true,
--             show_tab_indicators = true,
--             diagnostics = "nvim_lsp",
--             always_show_bufferline = true,
--             separator_style = 'thin',
--             offsets = {
--                 {
--                     filetype = "NvimTree",
--                     text = "File Explorer",
--                     text_align = "center",
--                     padding = 1,
--                 },
--             },
--         },
--     })
-- end

function config.gitsigns()
    vim.cmd [[
        exec 'hi! GitSignsAdd    ctermfg=Green  guifg=#50FA7B ' . (has('termguicolors')? 'guibg=':'ctermbg=') . synIDattr(hlID('SignColumn'),'bg')
        exec 'hi! GitSignsDelete ctermfg=Red    guifg=#FF5555 ' . (has('termguicolors')? 'guibg=':'ctermbg=') . synIDattr(hlID('SignColumn'),'bg')
        exec 'hi! GitSignsChange ctermfg=Yellow guifg=#FFB86C ' . (has('termguicolors')? 'guibg=':'ctermbg=') . synIDattr(hlID('SignColumn'),'bg')
    ]]

    require("gitsigns").setup({
        signs = {
            add          = { hl = 'GitSignsAdd',    text = '┃' },
            change       = { hl = 'GitSignsChange', text = '┃' },
            changedelete = { hl = 'GitSignsChange', text = '┃' },
            topdelete    = { hl = 'GitSignsDelete', text = '↗' },
            delete       = { hl = 'GitSignsDelete', text = '↘' },
        },
        keymaps = {
            -- Default keymap options
            noremap = true,
            buffer = true,
            ["n ]g"] = {
                expr = true,
                "&diff ? ']g' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'",
            },
            ["n [g"] = {
                expr = true,
                "&diff ? '[g' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'",
            },
            ["n <leader>hs"] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
            ["v <leader>hs"] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
            ["n <leader>hu"] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
            ["n <leader>hr"] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
            ["v <leader>hr"] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
            ["n <leader>hR"] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
            ["n <leader>hp"] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
            ["n <leader>hb"] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
            -- Text objects
            ["o ih"] = ':<C-U>lua require"gitsigns".text_object()<CR>',
            ["x ih"] = ':<C-U>lua require"gitsigns".text_object()<CR>',
        },
        watch_gitdir = { interval = 1000, follow_files = true },
        current_line_blame = false,
        current_line_blame_opts = { delay = 1000, virtual_text_pos = "eol" },
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        word_diff = false,
        diff_opts = { internal = true },
    })
end

function config.indent_blankline()
    require("indent_blankline").setup({
        char = "│",
        filetype = {
            "c",
            "cpp",
            "go",
            "lua",
            "java",
            "kotlin",
            "scala",
            "clojure",
            "rust",
            "sh",
            "zsh",
            "vim",
            "ruby",
            "python",
            "make",
            "toml",
            "yaml",
        },
        buftype_exclude = { "terminal", "nofile" },
        show_trailing_blankline_indent = false,
        show_current_context = true,
        context_patterns = {
            "class",
            "function",
            "method",
            "block",
            "list_literal",
            "selector",
            "^if",
            "^table",
            "if_statement",
            "while",
            "for",
            "type",
            "var",
            "import",
        },
        space_char_blankline = " ",
    })
    -- because lazy load indent-blankline so need readd this autocmd
    vim.cmd("autocmd CursorMoved * IndentBlanklineRefresh")
end

return config
