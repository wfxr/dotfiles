local install_path = ("%s/site/pack/packer-lib/opt/packer.nvim"):format(vim.fn.stdpath "data")

local function install_packer()
    vim.fn.termopen(("git clone https://github.com/wbthomason/packer.nvim %q"):format(install_path))
end

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    install_packer()
end

vim.cmd.packadd { "packer.nvim" }

function _G.packer_upgrade()
    vim.fn.delete(install_path, "rf")
    install_packer()
end

vim.cmd.command { "PackerUpgrade", ":call v:lua.packer_upgrade()", bang = true }

local function spec(use)
    use { "lewis6991/impatient.nvim" }

    -- tpope
    use {
        "tpope/vim-repeat",
        "tpope/vim-surround",
        "tpope/vim-fugitive",
        "tpope/vim-unimpaired",
        "tpope/vim-rsi",
        {
            "tpope/vim-sleuth",
            setup = function()
                vim.g.sleuth_automatic = 0
            end,
        },
        {
            "tpope/vim-dispatch",
            requires = { "radenling/vim-dispatch-neovim" },
        },
    }

    -- test & debugging
    use {
        {
            "nvim-neotest/neotest",
            requires = {
                "haydenmeade/neotest-jest",
                "rouge8/neotest-rust",
                "nvim-neotest/neotest-plenary",
            },
        },
        "mfussenegger/nvim-dap",
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        "jbyuki/one-small-step-for-vimkind",
    }

    -- things that either enhance builtin behaviours or could easily be candidates for default behaviour
    use {
        "luukvbaal/statuscol.nvim",
        "airblade/vim-rooter",
        "akinsho/toggleterm.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "ggandor/leap.nvim",
        "levouh/tint.nvim",
        "lewis6991/hover.nvim",
        "lewis6991/satellite.nvim",
        -- "linty-org/readline.nvim",
        "monaqa/dial.nvim",
        "numToStr/Comment.nvim",
        "stevearc/aerial.nvim",
        "stevearc/dressing.nvim",
        "szw/vim-maximizer",
        "windwp/nvim-autopairs",
        "zbirenbaum/neodim",
        "s1n7ax/nvim-window-picker",
        "kyazdani42/nvim-tree.lua",
        "farmergreg/vim-lastplace",
        "nvim-lualine/lualine.nvim",
        "karb94/neoscroll.nvim",
        { "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
        { "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" },
        { "kevinhwang91/nvim-bqf", ft = "qf", requires = "junegunn/fzf" },
        -- { "https://git.sr.ht/~whynothugo/lsp_lines.nvim", as = "lsp_lines.nvim" },
        { "j-hui/fidget.nvim", tag = "legacy" },
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
            requires = { { "romgrk/fzy-lua-native", after = "wilder.nvim" } },
        },
        {
            "junegunn/vim-easy-align",
            cmd = "EasyAlign",
        },
        {
            "andymass/vim-matchup",
            setup = function()
                vim.g.matchup_matchparen_offscreen = {
                    method = "popup",
                    fullwidth = 1,
                    highlight = "OffscreenMatchPopup",
                }
            end,
        },
        {
            "hrsh7th/nvim-cmp",
            requires = {
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
                    requires = { "honza/vim-snippets" },
                },
            },
        },
        {
            "junegunn/vim-peekaboo",
            setup = function()
                vim.g.peekaboo_compact = 0
            end,
        },
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
            run = function()
                vim.fn["mkdp#util#install"]()
            end,
        },
    }

    -- UI
    use {
        -- "williamboman/warden.nvim",
        "sainnhe/gruvbox-material",
        "kyazdani42/nvim-web-devicons",
        { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
        "NvChad/nvim-colorizer.lua",
        "Bekaboo/dropbar.nvim",
    }

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        disable = vim.fn.has "win32" == 1,
        run = ":TSUpdate",
        requires = {
            "nvim-treesitter/playground",
            "nvim-treesitter/nvim-treesitter-textobjects",
            -- "HiPhish/nvim-ts-rainbow2",
            "JoosepAlviste/nvim-ts-context-commentstring",
            "windwp/nvim-ts-autotag",
        },
    }

    -- Mason
    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    }

    -- LSP
    use {
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
    }

    -- Telescope
    use {
        "nvim-telescope/telescope.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-project.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        },
    }

    -- git
    use {
        "rhysd/git-messenger.vim",
        "rhysd/committia.vim",
        "ruifm/gitlinker.nvim",
        "lewis6991/gitsigns.nvim",
    }

    -- Misc
    use { "tweekmonster/startuptime.vim", cmd = { "StartupTime" } }
    -- use "wakatime/vim-wakatime"
end

require("packer").startup {
    spec,
    config = {
        display = {
            open_fn = require("packer.util").float,
        },
        max_jobs = vim.fn.has "win32" == 1 and 5 or nil,
    },
}

-- use {
--   'myusername/example',        -- The plugin location string
--   -- The following keys are all optional
--   disable = boolean,           -- Mark a plugin as inactive
--   as = string,                 -- Specifies an alias under which to install the plugin
--   installer = function,        -- Specifies custom installer. See "custom installers" below.
--   updater = function,          -- Specifies custom updater. See "custom installers" below.
--   after = string or list,      -- Specifies plugins to load before this plugin. See "sequencing" below
--   rtp = string,                -- Specifies a subdirectory of the plugin to add to runtimepath.
--   opt = boolean,               -- Manually marks a plugin as optional.
--   bufread = boolean,           -- Manually specifying if a plugin needs BufRead after being loaded
--   branch = string,             -- Specifies a git branch to use
--   tag = string,                -- Specifies a git tag to use. Supports '*' for "latest tag"
--   commit = string,             -- Specifies a git commit to use
--   lock = boolean,              -- Skip updating this plugin in updates/syncs. Still cleans.
--   run = string, function, or table, -- Post-update/install hook. See "update/install hooks".
--   requires = string or list,   -- Specifies plugin dependencies. See "dependencies".
--   rocks = string or list,      -- Specifies Luarocks dependencies for the plugin
--   config = string or function, -- Specifies code to run after this plugin is loaded.
--   -- The setup key implies opt = true
--   setup = string or function,  -- Specifies code to run before this plugin is loaded. The code is ran even if
--                                -- the plugin is waiting for other conditions (ft, cond...) to be met.
--   -- The following keys all imply lazy-loading and imply opt = true
--   cmd = string or list,        -- Specifies commands which load this plugin. Can be an autocmd pattern.
--   ft = string or list,         -- Specifies filetypes which load this plugin.
--   keys = string or list,       -- Specifies maps which load this plugin. See "Keybindings".
--   event = string or list,      -- Specifies autocommand events which load this plugin.
--   fn = string or list          -- Specifies functions which load this plugin.
--   cond = string, function, or list of strings/functions,   -- Specifies a conditional test to load this plugin
--   module = string or list      -- Specifies Lua module names for require. When requiring a string which starts
--                                -- with one of these module names, the plugin will be loaded.
--   module_pattern = string/list -- Specifies Lua pattern of Lua module names for require. When
--                                -- requiring a string which matches one of these patterns, the plugin will be loaded.
-- }
