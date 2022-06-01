local config = {}

function config.telescope()
    vim.cmd([[packadd sqlite.lua]])
    vim.cmd([[packadd telescope-fzf-native.nvim]])
    vim.cmd([[packadd telescope-frecency.nvim]])
    vim.cmd([[packadd telescope-zoxide]])
    vim.cmd([[packadd telescope-ui-select.nvim]])

    local telescope = require("telescope")
    telescope.setup({
        defaults = {
            initial_mode = "insert",
            mappings = {
                i = {
                    ["<esc>"] = require('telescope.actions').close,
                    ["<c-[>"] = require('telescope.actions').close,
                }
            },
            prompt_prefix = " ❯ ",
            selection_caret = " ",
            entry_prefix = " ",
            scroll_strategy = "cycle",
            results_title = false,
            borderchars = { "─", "│", "─", "│", "┏", "┓", "┛", "┗" },
            file_ignore_patterns = {},
            sorting_strategy = "ascending",
            path_display = { "relative" },
            layout_strategy = "vertical",
            layout_config = {
                prompt_position = "top",
                vertical = {
                    mirror = true,
                },
            },
            file_previewer   = require("telescope.previewers").vim_buffer_cat.new,
            grep_previewer   = require("telescope.previewers").vim_buffer_vimgrep.new,
            qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
            file_sorter      = require("telescope.sorters").get_fuzzy_file,
            generic_sorter   = require("telescope.sorters").get_generic_fuzzy_sorter,
        },
        extensions = {
            ["ui-select"] = {
                require("telescope.themes").get_cursor {
                    borderchars = {
                        prompt  = {'─', '│', ' ', '│', '┏', '┓', '│', '│'},
                        results = {'─', '│', '─', '│', '┣', '┫', '┛', '┗'},
                        preview = {'─', '│', '─', '│', '┏', '┓', '┛', '┗'},
                    },
                }
            },
            fzf = {
                fuzzy = false,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",
            },
            frecency = {
                show_scores = true,
                show_unindexed = true,
                ignore_patterns = { "*.git/*", "*/tmp/*" },
            },
        },
    })

    vim.lsp.handlers["textDocument/references"]     = require("telescope.builtin").lsp_references
    vim.lsp.handlers["textDocument/typeDefinition"] = require("telescope.builtin").lsp_type_definitions
    vim.lsp.handlers["textDocument/definition"]     = require("telescope.builtin").lsp_definitions
    vim.lsp.handlers["textDocument/implementation"] = require("telescope.builtin").lsp_implementations
    vim.lsp.handlers["workspace/symbol"]            = require("telescope.builtin").lsp_workspace_symbols
    vim.lsp.handlers["textDocument/documentSymbol"] = require("telescope.builtin").lsp_document_symbols

    telescope.load_extension("fzf")
    telescope.load_extension("zoxide")
    telescope.load_extension("frecency")
    telescope.load_extension("ui-select")
end

function config.trouble()
    require("trouble").setup({
        position = "bottom", -- position of the list can be: bottom, top, left, right
        height = 10, -- height of the trouble list when position is top or bottom
        width = 50, -- width of the list when position is left or right
        icons = true, -- use devicons for filenames
        mode = "document_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
        fold_open = "", -- icon used for open folds
        fold_closed = "", -- icon used for closed folds
        action_keys = {
            -- key mappings for actions in the trouble list
            -- map to {} to remove a mapping, for example:
            -- close = {},
            close = "q", -- close the list
            cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
            refresh = "r", -- manually refresh
            jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
            open_split = { "<c-x>" }, -- open buffer in new split
            open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
            open_tab = { "<c-t>" }, -- open buffer in new tab
            jump_close = { "o" }, -- jump to the diagnostic and close the list
            toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
            toggle_preview = "P", -- toggle auto_preview
            hover = "K", -- opens a small popup with the full multiline message
            preview = "p", -- preview the diagnostic location
            close_folds = { "zM", "zm" }, -- close all folds
            open_folds = { "zR", "zr" }, -- open all folds
            toggle_fold = { "zA", "za" }, -- toggle fold of current file
            previous = "k", -- preview item
            next = "j", -- next item
        },
        indent_lines = true, -- add an indent guide below the fold icons
        auto_open = false, -- automatically open the list when you have diagnostics
        auto_close = false, -- automatically close the list when you have no diagnostics
        auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
        auto_fold = false, -- automatically fold a file trouble list at creation
        signs = {
            -- icons / text used for a diagnostic
            error = "••", -- 
            warning = "•", --
            hint = "", -- 
            information = "כֿ", --     כֿ 
            other = "﫠",
        },
        use_lsp_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
    })
end

function config.sniprun()
    require("sniprun").setup({
        selected_interpreters = {}, -- " use those instead of the default for the current filetype
        repl_enable = {}, -- " enable REPL-like behavior for the given interpreters
        repl_disable = {}, -- " disable REPL-like behavior for the given interpreters
        interpreter_options = {}, -- " intepreter-specific options, consult docs / :SnipInfo <name>
        -- " you can combo different display modes as desired
        display = {
            "Classic", -- "display results in the command-line  area
            "VirtualTextOk", -- "display ok results as virtual text (multiline is shortened)
            "VirtualTextErr", -- "display error results as virtual text
            -- "TempFloatingWindow",      -- "display results in a floating window
            "LongTempFloatingWindow", -- "same as above, but only long results. To use with VirtualText__
            -- "Terminal"                 -- "display results in a vertical split
        },
        -- " miscellaneous compatibility/adjustement settings
        inline_messages = 0, -- " inline_message (0/1) is a one-line way to display messages
        -- " to workaround sniprun not being able to display anything

        borders = "shadow", -- " display borders around floating windows
        -- " possible values are 'none', 'single', 'double', or 'shadow'
    })
end

function config.wilder()
    vim.cmd [[
        call wilder#setup({'modes': [':', '/', '?']})
        call wilder#set_option('use_python_remote_plugin', 0)
        call wilder#set_option('pipeline', [wilder#branch(wilder#cmdline_pipeline({'use_python': 0,'fuzzy': 1, 'fuzzy_filter': wilder#lua_fzy_filter()}),wilder#vim_search_pipeline(), [wilder#check({_, x -> empty(x)}), wilder#history(), wilder#result({'draw': [{_, x -> ' ' . x}]})])])
        call wilder#set_option('renderer', wilder#renderer_mux({':': wilder#popupmenu_renderer({'highlighter': wilder#lua_fzy_highlighter(), 'left': [wilder#popupmenu_devicons()], 'right': [' ', wilder#popupmenu_scrollbar()]}), '/': wilder#wildmenu_renderer({'highlighter': wilder#lua_fzy_highlighter()})}))
    ]]
end

function config.filetype()
    -- In init.lua or filetype.nvim's config file
    require("filetype").setup({
        overrides = {
            shebang = {
                -- Set the filetype of files with a dash shebang to sh
                dash = "sh",
            },
        },
    })
end

return config
