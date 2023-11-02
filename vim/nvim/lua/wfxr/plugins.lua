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
        "luukvbaal/statuscol.nvim",
        "airblade/vim-rooter",
        "ggandor/leap.nvim",
        -- "levouh/tint.nvim",
        "lewis6991/hover.nvim",
        "lewis6991/satellite.nvim",
        "lewis6991/spaceless.nvim",
        -- "linty-org/readline.nvim",
        "monaqa/dial.nvim",
        "numToStr/Comment.nvim",
        "stevearc/aerial.nvim",
        "stevearc/dressing.nvim",
        "szw/vim-maximizer",
        "windwp/nvim-autopairs",
        "zbirenbaum/neodim",
        "kyazdani42/nvim-tree.lua",
        -- {
        --     "nvim-neo-tree/neo-tree.nvim",
        --     dependencies = {
        --         "nvim-lua/plenary.nvim",
        --         "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        --         "MunifTanjim/nui.nvim",
        --         "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        --         's1n7ax/nvim-window-picker',
        --     },
        --     config = function()
        --         vim.keymap.set("n", "<c-n>", "<cmd>Neotree toggle<CR>")
        --     end
        -- },
        "farmergreg/vim-lastplace",
        "nvim-lualine/lualine.nvim",
        "karb94/neoscroll.nvim",
        { "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
        { "kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async" },
        { "kevinhwang91/nvim-bqf", ft = "qf", dependencies = "junegunn/fzf" },
        { "j-hui/fidget.nvim", tag = "legacy", event = "LspAttach" },
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
            "hrsh7th/nvim-cmp",
            event = "InsertEnter",
            dependencies = {
                "andersevenrud/cmp-tmux",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-calc",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-path",
                "lukas-reineke/cmp-rg",
                "onsails/lspkind-nvim",
                "petertriho/cmp-git",
                "rcarriga/cmp-dap",
                "saadparwaiz1/cmp_luasnip",
                {
                    "L3MON4D3/LuaSnip",
                    dependencies = { "honza/vim-snippets" },
                },
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
        -- "williamboman/warden.nvim",
        "sainnhe/gruvbox-material",
        "nvim-tree/nvim-web-devicons",
        { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
        "NvChad/nvim-colorizer.lua",
        -- "Bekaboo/dropbar.nvim", -- TODO: re-enable after https://github.com/wfxr/dotfiles/issues/4 fixed
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
            -- "HiPhish/nvim-ts-rainbow2",
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
        -- "jose-elias-alvarez/null-ls.nvim",
        "stevearc/conform.nvim",
        "mfussenegger/nvim-lint",
        { "folke/trouble.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
        "neovim/nvim-lspconfig",
        "pmizio/typescript-tools.nvim",
        "ray-x/lsp_signature.nvim",
        "simrat39/rust-tools.nvim",
        { "lvimuser/lsp-inlayhints.nvim", branch = "anticonceal" },
        {
            "github/copilot.vim",
            event = "InsertEnter",
            config = function()
                vim.g.copilot_no_tab_map = true
                vim.g.copilot_assume_mapped = true
                vim.keymap.set("i", "<c-e>", function()
                    local copilot_keys = vim.fn["copilot#Accept"]()
                    if copilot_keys ~= "" then
                        vim.api.nvim_feedkeys(copilot_keys, "i", true)
                    else
                        local endkey = vim.api.nvim_replace_termcodes("<END>", true, false, true)
                        vim.api.nvim_feedkeys(endkey, "i", true)
                    end
                end)
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
    -- use "wakatime/vim-wakatime"
}

require("lazy").setup(plugins, {
    install = {
        colorscheme = { "gruvbox-material" },
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
