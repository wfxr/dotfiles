local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    -- tpope
    {
        "tpope/vim-repeat",
        "tpope/vim-surround",
        "tpope/vim-fugitive",
        "tpope/vim-unimpaired",
        "tpope/vim-rsi",
        {
            "tpope/vim-dispatch",
            dependencies = { "radenling/vim-dispatch-neovim" },
        },
    },

    -- test & debugging
    {
        {
            "nvim-neotest/neotest",
            dependencies = {
                "nvim-lua/plenary.nvim",
                "haydenmeade/neotest-jest",
                "rouge8/neotest-rust",
                "nvim-neotest/neotest-plenary",
            },
        },
        "mfussenegger/nvim-dap",
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        "jbyuki/one-small-step-for-vimkind",
    },

    -- things that either enhance builtin behaviours or could easily be candidates for default behaviour
    {
        "folke/flash.nvim",
        {
            "luukvbaal/statuscol.nvim",
            event = "VeryLazy",
            keys = {
                { "s", mode = { "n", "x", "o" }, function() require("flash").jump()              end, desc = "Flash"             },
                { "+", mode = { "n", "x", "o" }, function() require("flash").treesitter()        end, desc = "Flash Treesitter"  },
                { "r", mode = { "o"           }, function() require("flash").remote()            end, desc = "Remote Flash"      },
                { "R", mode = { "o", "x"      }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            },
        },
        "airblade/vim-rooter",
        "ggandor/leap.nvim",
        "lewis6991/hover.nvim",
        {
            "lewis6991/satellite.nvim",
            enabled = function()
                return vim.fn.has("nvim-0.10") == 1
            end,
        },
        "lewis6991/spaceless.nvim",
        "monaqa/dial.nvim",
        "numToStr/Comment.nvim",
        "stevearc/aerial.nvim",
        "stevearc/dressing.nvim",
        "szw/vim-maximizer",
        {
            "windwp/nvim-autopairs",
            event = "InsertEnter",
        },
        "zbirenbaum/neodim",
        "kyazdani42/nvim-tree.lua",
        {
            "nvim-neo-tree/neo-tree.nvim",
            enabled = false, -- TODO: Cause screen flickering?
            dependencies = {
                "nvim-lua/plenary.nvim",
                "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
                "MunifTanjim/nui.nvim",
                "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
                's1n7ax/nvim-window-picker',
            },
            config = function()
                vim.keymap.set("n", "<c-n>", "<cmd>Neotree toggle<CR>")
            end
        },
        "farmergreg/vim-lastplace",
        "nvim-lualine/lualine.nvim",
        "karb94/neoscroll.nvim",
        { "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
        { "kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async" },
        { "kevinhwang91/nvim-bqf", ft = "qf", dependencies = "junegunn/fzf" },
        { "j-hui/fidget.nvim", enabled = true, tag = "legacy", event = "LspAttach" },
        {
            "Bekaboo/deadcolumn.nvim",
            config = function()
                require("deadcolumn").setup { blending = { threshold = 0.9 } } -- Call the setup function
            end,
        },
        {
            "simnalamburt/vim-mundo",
            config = function()
                vim.keymap.set("n", "U", "<cmd>MundoToggle<CR>")
            end,
        },
        {
            "gelguy/wilder.nvim",
            enabled = false, -- Python dependency is annoying
            event = "CmdlineEnter",
            build = ":UpdateRemotePlugins",
            config = function()
                vim.cmd [[
                    call wilder#setup({'modes': [':', '/', '?']})
                    call wilder#set_option('use_python_remote_plugin', 0)
                    call wilder#set_option('pipeline', [wilder#branch(wilder#cmdline_pipeline({'use_python': 0,'fuzzy': 1, 'fuzzy_filter': wilder#lua_fzy_filter()}),wilder#vim_search_pipeline(), [wilder#check({_, x -> empty(x)}), wilder#history(), wilder#result({'draw': [{_, x -> ' ' . x}]})])])
                    call wilder#set_option('renderer', wilder#renderer_mux({':': wilder#popupmenu_renderer({'highlighter': wilder#lua_fzy_highlighter(), 'left': [wilder#popupmenu_devicons()], 'right': [' ', wilder#popupmenu_scrollbar()]}), '/': wilder#wildmenu_renderer({'highlighter': wilder#lua_fzy_highlighter()})}))
                ]]
            end,
            dependencies = { "romgrk/fzy-lua-native", "wilder.nvim" },
        },
        {
            "junegunn/vim-easy-align",
            cmd = "EasyAlign",
        },
        {
            "andymass/vim-matchup",
            config = function()
                vim.g.matchup_matchparen_offscreen = {
                    method = "popup",
                    fullwidth = 1,
                    highlight = "OffscreenMatchPopup",
                }
            end,
        },

        {
            "L3MON4D3/LuaSnip",
            event = "InsertEnter",
            build = "make install_jsregexp",
            dependencies = {
                "rafamadriz/friendly-snippets",
            }
        },
        {
            "hrsh7th/nvim-cmp",
            event = "InsertEnter",
            dependencies = {
                "andersevenrud/cmp-tmux",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-calc",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-cmdline",
                "lukas-reineke/cmp-rg",
                "onsails/lspkind-nvim",
                "petertriho/cmp-git",
                "rcarriga/cmp-dap",
                "saadparwaiz1/cmp_luasnip",
            },
        },
        { "junegunn/vim-peekaboo" },
        {
            "ojroques/nvim-osc52",
            config = function()
                vim.keymap.set("n", "<leader>y", require("osc52").copy_operator, { expr = true })
                vim.keymap.set("n", "<c-y>", "<leader>y_", { remap = true })
                vim.keymap.set("x", "<c-y>", require("osc52").copy_visual)
            end,
        },
        {
            "iamcco/markdown-preview.nvim",
            ft = "markdown",
            build = function()
                vim.fn["mkdp#util#install"]()
            end,
        },
    },

    -- UI
    {
        { "sainnhe/gruvbox-material", enabled = false },
        "sainnhe/everforest",
        "nvim-tree/nvim-web-devicons",
        {
            "folke/noice.nvim",
            enabled = false,
            event = "VeryLazy",
            dependencies = {
                -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
                "MunifTanjim/nui.nvim",
                -- OPTIONAL:
                --   `nvim-notify` is only needed, if you want to use the notification view.
                --   If not available, we use `mini` as the fallback
                "rcarriga/nvim-notify",
            }
        },
        { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
        "NvChad/nvim-colorizer.lua",
        { "Bekaboo/dropbar.nvim", enabled = false, }, -- TODO: Wait https://github.com/wfxr/dotfiles/issues/4
        { "akinsho/toggleterm.nvim", version = '*' },
        {
            "numToStr/FTerm.nvim",
            config = function ()
                require('FTerm').setup({
                    border = global.borders.modern
                })
                vim.keymap.set('n', '<C-\\>', '<CMD>lua require("FTerm").toggle()<CR>')
                vim.keymap.set('t', '<C-\\>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
            end
        },
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/playground",
            "nvim-treesitter/nvim-treesitter-textobjects",
            "JoosepAlviste/nvim-ts-context-commentstring",
            "windwp/nvim-ts-autotag",
        },
    },

    -- Mason
    {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },

    -- LSP
    {
        "DNLHC/glance.nvim",
        "b0o/SchemaStore.nvim",
        "folke/neodev.nvim",
        "jmbuhr/otter.nvim",
        { "jose-elias-alvarez/null-ls.nvim", enabled = false  }, -- NOTE: replaced by conform.nvim & nvim-lint
        "stevearc/conform.nvim",
        "mfussenegger/nvim-lint",
        { "folke/trouble.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
        "neovim/nvim-lspconfig",
        "pmizio/typescript-tools.nvim",
        { "ray-x/lsp_signature.nvim", enabled = true },
        "simrat39/rust-tools.nvim",
        { "lvimuser/lsp-inlayhints.nvim", branch = "anticonceal" },
        {
            "github/copilot.vim",
            event = "InsertEnter",
            config = function()
                vim.g.copilot_filetypes = {
                    ['*'] = true,
                    DressingInput = false,
                    TelescopePrompt = false,
                    ['neo-tree-popup'] = false,
                    ['dap-repl'] = false,
                }
                vim.g.copilot_no_tab_map = true
                vim.g.copilot_assume_mapped = true

                local function accept_word()
                    vim.fn['copilot#Accept']('')
                    local suggestion = vim.fn['copilot#TextQueuedForInsertion']()
                    if suggestion == "" then
                        local forward_word = vim.api.nvim_replace_termcodes("<S-Right>", true, false, true)
                        vim.api.nvim_feedkeys(forward_word, "i", true)
                    else
                        suggestion = vim.fn.split(suggestion, [[\W\+\zs]])[1]
                        suggestion = vim.fn.split(suggestion, [[\n\zs]])[1]
                        return suggestion
                    end
                end

                local function accept_all()
                    local suggestion = vim.fn['copilot#Accept']()
                    if string.match(suggestion, "^%s*$") then
                        suggestion = vim.api.nvim_replace_termcodes("<END>", true, false, true)
                    end
                    vim.api.nvim_feedkeys(suggestion, "i", true)
                end

                vim.keymap.set("i", "<C-e>", accept_all, { expr = true, remap = false, desc = 'accept all' })
                vim.keymap.set('i', '<M-f>', accept_word, { expr = true, remap = false, desc = 'accept word' })
                vim.keymap.set('i', '<M-n>', '<Plug>(copilot-next)', { desc = 'next suggestion' })
                vim.keymap.set('i', '<M-p>', '<Plug>(copilot-previous)', { desc = 'previous suggestion' })
            end,
        },
    },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-project.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
    },

    -- git
    {
        "rhysd/git-messenger.vim",
        "rhysd/committia.vim",
        "ruifm/gitlinker.nvim",
        "lewis6991/gitsigns.nvim",
    },

    -- Misc
    {
        "tweekmonster/startuptime.vim",
        cmd = "StartupTime",
        init = function()
            vim.g.startuptime_tries = 10
        end,
    },
}

require("lazy").setup(plugins, {
    install = {
        colorscheme = { "everforest" },
    },
    ui = {
        border = nil,
    },
    checker = {
        -- automatically check for plugin updates
        enabled = true,
        notify = false,
    },
})
