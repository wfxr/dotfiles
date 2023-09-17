local ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not ok then
    return
end

treesitter.setup {
    ensure_installed = "all",
    ignore_install = { "haskell", "phpdoc" },
    highlight = { enable = true },
    indent = { enable = true },
    playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<S-Tab>", -- normal mode
            node_incremental = "<Tab>", -- visual mode
            node_decremental = "<S-Tab>", -- visual mode
        },
    },
    -- extensions
    textobjects = {
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ["<leader>s"] = "@parameter.inner",
            },
            swap_previous = {
                ["<leader>S"] = "@parameter.inner",
            },
        },

        select = {
            enable = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
            },
        },
    },
    autotag = {
        enable = true,
        filetypes = { "html", "javascript", "javascriptreact", "typescriptreact", "svelte", "vue" },
    },
    rainbow = { enable = true },
    context_commentstring = {
        enable = true,
        config = {
            javascriptreact = { style_element = "{/*%s*/}" },
        },
    },
    matchup = {
        enable = true,
    },
}
