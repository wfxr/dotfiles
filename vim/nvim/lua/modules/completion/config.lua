local config = {}

function config.nvim_lsp()
    require("modules.completion.lsp")
end

function config.aerial()
    -- Call the setup function to change the default behavior
    require("aerial").setup({
        -- Priority list of preferred backends for aerial.
        -- This can be a filetype map (see :help aerial-filetype-map)
        backends = { "treesitter", "lsp", "markdown" },

        -- Enum: persist, close, auto, global
        --   persist - aerial window will stay open until closed
        --   close   - aerial window will close when original file is no longer visible
        --   auto    - aerial window will stay open as long as there is a visible
        --             buffer to attach to
        --   global  - same as 'persist', and will always show symbols for the current buffer
        close_behavior = "auto",

        -- Set to false to remove the default keybindings for the aerial buffer
        default_bindings = true,

        -- Enum: prefer_right, prefer_left, right, left, float
        -- Determines the default direction to open the aerial window. The 'prefer'
        -- options will open the window in the other direction *if* there is a
        -- different buffer in the way of the preferred direction
        default_direction = "prefer_right",

        -- Disable aerial on files with this many lines
        disable_max_lines = 10000,

        -- Disable aerial on files this size or larger (in bytes)
        disable_max_size = 10000000,

        -- A list of all symbols to display. Set to false to display all symbols.
        -- This can be a filetype map (see :help aerial-filetype-map)
        -- To see all available values, see :help SymbolKind
        filter_kind = {
            "Class",
            "Constructor",
            "Enum",
            "Function",
            "Interface",
            "Module",
            "Method",
            "Struct",
        },

        -- Enum: split_width, full_width, last, none
        -- Determines line highlighting mode when multiple splits are visible.
        -- split_width   Each open window will have its cursor location marked in the
        --               aerial buffer. Each line will only be partially highlighted
        --               to indicate which window is at that location.
        -- full_width    Each open window will have its cursor location marked as a
        --               full-width highlight in the aerial buffer.
        -- last          Only the most-recently focused window will have its location
        --               marked in the aerial buffer.
        -- none          Do not show the cursor locations in the aerial window.
        highlight_mode = "split_width",

        -- Highlight the closest symbol if the cursor is not exactly on one.
        highlight_closest = true,

        -- Highlight the symbol in the source buffer when cursor is in the aerial win
        highlight_on_hover = false,

        -- When jumping to a symbol, highlight the line for this many ms.
        -- Set to false to disable
        highlight_on_jump = 300,

        -- Define symbol icons. You can also specify "<Symbol>Collapsed" to change the
        -- icon when the tree is collapsed at that symbol, or "Collapsed" to specify a
        -- default collapsed icon. The default icon set is determined by the
        -- "nerd_font" option below.
        -- If you have lspkind-nvim installed, aerial will use it for icons.
        icons = {},

        -- Control which windows and buffers aerial should ignore.
        -- If close_behavior is "global", focusing an ignored window/buffer will
        -- not cause the aerial window to update.
        -- If open_automatic is true, focusing an ignored window/buffer will not
        -- cause an aerial window to open.
        -- If open_automatic is a function, ignore rules have no effect on aerial
        -- window opening behavior; it's entirely handled by the open_automatic
        -- function.
        ignore = {
            -- Ignore unlisted buffers. See :help buflisted
            unlisted_buffers = true,

            -- List of filetypes to ignore.
            filetypes = {},

            -- Ignored buftypes.
            -- Can be one of the following:
            -- false or nil - No buftypes are ignored.
            -- "special"    - All buffers other than normal buffers are ignored.
            -- table        - A list of buftypes to ignore. See :help buftype for the
            --                possible values.
            -- function     - A function that returns true if the buffer should be
            --                ignored or false if it should not be ignored.
            --                Takes two arguments, `bufnr` and `buftype`.
            buftypes = "special",

            -- Ignored wintypes.
            -- Can be one of the following:
            -- false or nil - No wintypes are ignored.
            -- "special"    - All windows other than normal windows are ignored.
            -- table        - A list of wintypes to ignore. See :help win_gettype() for the
            --                possible values.
            -- function     - A function that returns true if the window should be
            --                ignored or false if it should not be ignored.
            --                Takes two arguments, `winid` and `wintype`.
            wintypes = "special",
        },

        -- When you fold code with za, zo, or zc, update the aerial tree as well.
        -- Only works when manage_folds = true
        link_folds_to_tree = false,

        -- Fold code when you open/collapse symbols in the tree.
        -- Only works when manage_folds = true
        link_tree_to_folds = true,

        -- Use symbol tree for folding. Set to true or false to enable/disable
        -- 'auto' will manage folds if your previous foldmethod was 'manual'
        manage_folds = false,

        -- These control the width of the aerial window.
        -- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        -- min_width and max_width can be a list of mixed types.
        -- max_width = {40, 0.2} means "the lesser of 40 columns or 20% of total"
        max_width = { 40, 0.2 },
        width = nil,
        min_width = 16,

        -- Set default symbol icons to use patched font icons (see https://www.nerdfonts.com/)
        -- "auto" will set it to true if nvim-web-devicons or lspkind-nvim is installed.
        nerd_font = "auto",

        -- Call this function when aerial attaches to a buffer.
        -- Useful for setting keymaps. Takes a single `bufnr` argument.
        on_attach = nil,

        -- Automatically open aerial when entering supported buffers.
        -- This can be a function (see :help aerial-open-automatic)
        open_automatic = false,

        -- Set to true to only open aerial at the far right/left of the editor
        -- Default behavior opens aerial relative to current window
        placement_editor_edge = false,

        -- Run this command after jumping to a symbol (false will disable)
        post_jump_cmd = "normal! zz",

        -- When true, aerial will automatically close after jumping to a symbol
        close_on_select = false,

        -- Show box drawing characters for the tree hierarchy
        show_guides = false,

        -- The autocmds that trigger symbols update (not used for LSP backend)
        update_events = "TextChanged,InsertLeave",

        -- Customize the characters used when show_guides = true
        guides = {
            -- When the child item has a sibling below it
            mid_item = "├─",
            -- When the child item is the last in the list
            last_item = "└─",
            -- When there are nested child guides to the right
            nested_top = "│ ",
            -- Raw indentation
            whitespace = "  ",
        },

        -- Options for opening aerial in a floating win
        float = {
            -- Controls border appearance. Passed to nvim_open_win
            border = "rounded",

            -- Enum: cursor, editor, win
            --   cursor - Opens float on top of the cursor
            --   editor - Opens float centered in the editor
            --   win    - Opens float centered in the window
            relative = "cursor",

            -- These control the height of the floating window.
            -- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
            -- min_height and max_height can be a list of mixed types.
            -- min_height = {8, 0.1} means "the greater of 8 rows or 10% of total"
            max_height = 0.9,
            height = nil,
            min_height = { 8, 0.1 },

            override = function(conf)
                -- This is the config that will be passed to nvim_open_win.
                -- Change values here to customize the layout
                return conf
            end,
        },

        lsp = {
            -- Fetch document symbols when LSP diagnostics update.
            -- If false, will update on buffer changes.
            diagnostics_trigger_update = true,

            -- Set to false to not update the symbols when there are LSP errors
            update_when_errors = true,

            -- How long to wait (in ms) after a buffer change before updating
            -- Only used when diagnostics_trigger_update = false
            update_delay = 300,
        },

        treesitter = {
            -- How long to wait (in ms) after a buffer change before updating
            update_delay = 300,
        },

        markdown = {
            -- How long to wait (in ms) after a buffer change before updating
            update_delay = 300,
        },
    })
end

function config.cmp()
    local cmp = require("cmp")
    cmp.setup({
        sorting = {
            comparators = {
                cmp.config.compare.offset,
                cmp.config.compare.exact,
                cmp.config.compare.score,
                require("cmp-under-comparator").under,
                cmp.config.compare.kind,
                cmp.config.compare.sort_text,
                cmp.config.compare.length,
                cmp.config.compare.order,
            },
        },
        formatting = {
            format = function(entry, vim_item)
                local lspkind_icons = {
                    Text          = "",
                    Method        = "",
                    Function      = "",
                    Constructor   = "",
                    Field         = "",
                    Variable      = "",
                    Class         = "ﴯ",
                    Interface     = "",
                    Module        = "",
                    Property      = "ﰠ",
                    Unit          = "",
                    Value         = "",
                    Enum          = "",
                    Keyword       = "",
                    Snippet       = "",
                    Color         = "",
                    File          = "",
                    Reference     = "",
                    Folder        = "",
                    EnumMember    = "",
                    Constant      = "",
                    Struct        = "",
                    Event         = "",
                    Operator      = "",
                    TypeParameter = "",
                }
                -- load lspkind icons
                vim_item.kind = string.format("%s %s", lspkind_icons[vim_item.kind], vim_item.kind)

                vim_item.menu = ({
                    -- cmp_tabnine = "[TN]",
                    buffer   = "[BUF]",
                    orgmode  = "[ORG]",
                    nvim_lsp = "[LSP]",
                    nvim_lua = "[LUA]",
                    path     = "[PATH]",
                    tmux     = "[TMUX]",
                    luasnip  = "[SNIP]",
                    spell    = "[SPELL]",
                })[entry.source.name]

                return vim_item
            end,
        },
        -- You can set mappings if you want
        mapping = cmp.mapping.preset.insert({
            ["<Tab>"] = cmp.mapping.confirm({ select = true }),
            -- ["<C-d>"] = cmp.mapping.scroll_docs(-4),
            -- ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-j>"] = cmp.mapping(function()
                local luasnip = require("luasnip")
                if luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                end
            end, { "i", "s" }),
            ["<C-k>"] = cmp.mapping(function(fallback)
                local luasnip = require("luasnip")
                if luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { "i", "s" }),
        }),
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end,
        },
        -- You should specify your *installed* sources.
        sources = {
            { name = "nvim_lsp" },
            { name = "nvim_lua" },
            { name = "luasnip" },
            { name = "path" },
            { name = "spell" },
            { name = "tmux" },
            { name = "orgmode" },
            { name = "buffer" },
            { name = "latex_symbols" },
            -- {name = 'cmp_tabnine'}
        },
    })
end

function config.luasnip()
    local luasnip = require("luasnip")
    luasnip.config.set_config({
        -- This tells LuaSnip to remember to keep around the last sniptpet.
        -- You can jump back into it even if you move outside of the selection
        history = true,

        -- This one is cool cause if you have dynamic snippets, it updates as you type!
        updateevents = "TextChanged,TextChangedI",
        enable_autosnippets = true,
    })
    vim.keymap.set("i", "<c-l>", function ()
        if luasnip.choice_active() then
            luasnip.change_choice(1)
        end
    end)
    require("luasnip.loaders.from_snipmate").lazy_load()
end

-- function config.tabnine()
--     local tabnine = require('cmp_tabnine.config')
--     tabnine:setup({max_line = 1000, max_num_results = 20, sort = true})
-- end

function config.autopairs()
    require("nvim-autopairs").setup({})

    -- If you want insert `(` after select function or method item
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local cmp = require("cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
    cmp_autopairs.lisp[#cmp_autopairs.lisp + 1] = "racket"
end

return config
