local config = {}

function config.lualine()
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
            component_separators = { left = '', right = ''},
            section_separators = { left = "", right = "" },
            globalstatus = true,
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = { { "branch" }, { "diff" } },
            lualine_c = {},
            lualine_x = {
                {
                    "diagnostics",
                    sources = { "nvim_diagnostic" },
                    symbols = { error = " ", warn = " ", info = " ", hint = " " }, --     כֿ 
                    diagnostics_color = {
                        error = 'DiagnosticSignError',
                        warn  = 'DiagnosticSignWarn',
                        info  = 'DiagnosticSignInfo',
                        hint  = 'DiagnosticSignHint',
                    },
                    colored = true,
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

function config.nvim_tree()
    local function on_attach(bufnr)
        local api = require('nvim-tree.api')
        local function opts(desc)
            return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        vim.keymap.set('n', '<CR>', api.node.open.edit,             opts('Open'))
        vim.keymap.set('n', 'o',    api.node.open.preview,          opts('Open Preview'))
        vim.keymap.set('n', 'K',    api.node.show_info_popup,       opts('Info'))
        vim.keymap.set('n', 'yy',   api.fs.copy.node,               opts('Copy'))
        vim.keymap.set('n', 'dd',   api.fs.cut,                     opts('Cut'))
        vim.keymap.set('n', 'gr',   api.fs.rename,                  opts('Rename'))
        vim.keymap.set('n', 'p',    api.fs.paste,                   opts('Paste'))
        vim.keymap.set('n', 'c',    api.fs.create,                  opts('Create'))
        vim.keymap.set('n', 'D',    api.fs.remove,                  opts('Delete'))
        vim.keymap.set('n', '<BS>', api.tree.change_root_to_parent, opts('Up'))
        vim.keymap.set('n', '?',    api.tree.toggle_help,           opts('Help'))
    end

    require("nvim-tree").setup({
        on_attach = on_attach,
        auto_reload_on_write = true,
        disable_netrw = false,
        hijack_cursor = true,
        hijack_netrw = true,
        hijack_unnamed_buffer_when_opening = false,
        open_on_tab = false,
        sort_by = "name",
        update_cwd = true,
        view = {
            width = 30,
            side = "left",
            preserve_window_proportions = false,
            number = false,
            relativenumber = false,
            signcolumn = "yes",
            hide_root_folder = false,
        },
        renderer = {
            add_trailing = false,
            group_empty = false,
            highlight_git = false,
            highlight_opened_files = "none",
            root_folder_modifier = ":~",
            indent_markers = {
                enable = false,
                icons = {
                    corner = "└ ",
                    edge = "│ ",
                    none = "  ",
                },
            },
            icons = {
                webdev_colors = true,
                git_placement = "before",
                padding = " ",
                symlink_arrow = " ➛ ",
                show = {
                    file = true,
                    folder = true,
                    folder_arrow = true,
                    git = true,
                },
                glyphs = {
                    default = "",
                    symlink = "",
                    folder = {
                        arrow_closed = "",
                        arrow_open = "",
                        default = "",
                        open = "",
                        empty = "",
                        empty_open = "",
                        symlink = "",
                        symlink_open = "",
                    },
                    git = {
                        unstaged  = "",
                        staged    = "",
                        unmerged  = "",
                        renamed   = "",
                        untracked = "ﲉ",
                        deleted   = "",
                        ignored   = "",
                    },
                },
            },
            special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
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
        filters = {
            dotfiles = false,
            custom = { ".DS_Store" },
            exclude = {},
        },
        actions = {
            change_dir = {
                enable = true,
                global = false,
                restrict_above_cwd = true,
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

function config.gitsigns()
    vim.cmd [[
        exec 'hi! GitSignsAdd    ctermfg=Green  guifg=#50FA7B'
        exec 'hi! GitSignsDelete ctermfg=Red    guifg=#FF5555'
        exec 'hi! GitSignsChange ctermfg=Yellow guifg=#FFB86C'
    ]]

    require("gitsigns").setup({
        signs = {
            add          = { hl = 'GitSignsAdd',    text = '┃' },
            change       = { hl = 'GitSignsChange', text = '┃' },
            changedelete = { hl = 'GitSignsChange', text = '┃' },
            untracked    = { hl = 'GitSignsAdd',    text = '┃' },
            topdelete    = { hl = 'GitSignsDelete', text = '⎺⎺' }, -- ↗
            delete       = { hl = 'GitSignsDelete', text = '⎽⎽' }, -- ↘
        },
        watch_gitdir = { interval = 1000, follow_files = true },
        current_line_blame = false,
        current_line_blame_opts = { delay = 1000, virtual_text_pos = "eol" },
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        word_diff = false,
        diff_opts = { internal = true },

        on_attach = function(bufnr)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, opts)
                opts = opts or {}
                opts.buffer = bufnr
                vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            map('n', ']c', function()
                if vim.wo.diff then return ']c' end
                vim.schedule(function() gs.next_hunk() end)
                return '<Ignore>'
            end, {expr=true})

            map('n', '[c', function()
                if vim.wo.diff then return '[c' end
                vim.schedule(function() gs.prev_hunk() end)
                return '<Ignore>'
            end, {expr=true})

            -- Actions
            map('n', '<leader>hs', gs.stage_hunk)
            map('n', '<leader>hr', gs.reset_hunk)
            map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
            map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
            map('n', '<leader>hS', gs.stage_buffer)
            map('n', '<leader>hu', gs.undo_stage_hunk)
            map('n', '<leader>hR', gs.reset_buffer)
            map('n', '<leader>hp', gs.preview_hunk)
            map('n', '<leader>hb', function() gs.blame_line{full=true} end)
            map('n', '<leader>tb', gs.toggle_current_line_blame)
            map('n', '<leader>hd', gs.diffthis)
            map('n', '<leader>hD', function() gs.diffthis('~') end)
            map('n', '<leader>td', gs.toggle_deleted)
        end
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
