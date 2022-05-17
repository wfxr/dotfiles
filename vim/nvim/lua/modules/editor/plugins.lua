local editor = {}
local conf = require("modules.editor.config")

editor['rhysd/clever-f.vim']              = {}
editor['ivyl/vim-bling']                  = {}
editor['rhysd/git-messenger.vim']         = {}
editor['junegunn/vim-peekaboo']           = {}
editor['tpope/vim-rsi']                   = {} -- emacs key bindings
editor['tpope/vim-surround']              = {}
editor['tpope/vim-endwise']               = {}
editor['tpope/vim-repeat']                = {}
editor['ConradIrwin/vim-bracketed-paste'] = {}
editor['AndrewRadev/switch.vim']          = {}
editor["junegunn/vim-easy-align"] = { opt = true, cmd = "EasyAlign" }
editor["AndrewRadev/splitjoin.vim"] = {
    config = function()
        vim.g.splitjoin_split_mapping = ''
        vim.g.splitjoin_join_mapping = ''
        vim.cmd [[
            nnoremap gss :SplitjoinSplit<cr>
            nnoremap gsj :SplitjoinJoin<cr>
        ]]
    end
}

editor["RRethy/vim-illuminate"] = {
    event = "BufRead",
    config = function()
        vim.g.Illuminate_highlightUnderCursor = 0
        vim.g.Illuminate_ftblacklist = {
            "help",
            "dashboard",
            "alpha",
            "packer",
            "norg",
            "DoomInfo",
            "NvimTree",
            "Outline",
            "toggleterm",
        }
    end,
}
editor["numToStr/Comment.nvim"] = {
    config = function()
        require('Comment').setup()
        vim.cmd [[
            nnoremap <c-_> <Plug>(comment_toggle_current_linewise)j
            vnoremap <c-_> <Plug>(comment_toggle_linewise_visual)'>j
        ]]
    end
}
editor["nvim-treesitter/nvim-treesitter"] = {
    opt = true,
    run = ":TSUpdate",
    event = "BufRead",
    config = conf.nvim_treesitter,
}
editor["nvim-treesitter/nvim-treesitter-textobjects"] = {
    opt = true,
    after = "nvim-treesitter",
}
editor["JoosepAlviste/nvim-ts-context-commentstring"] = {
    opt = true,
    after = "nvim-treesitter",
}
editor["mfussenegger/nvim-ts-hint-textobject"] = {
    opt = true,
    after = "nvim-treesitter",
}
editor["windwp/nvim-ts-autotag"] = {
    opt = true,
    ft = { "html", "xml" },
    config = conf.autotag,
}
editor["andymass/vim-matchup"] = {
    opt = true,
    after = "nvim-treesitter",
    config = conf.matchup,
}
editor["romainl/vim-cool"] = {
    opt = true,
    event = { "CursorMoved", "InsertEnter" },
}
editor["phaazon/hop.nvim"] = {
    opt = true,
    branch = "v1",
    cmd = {
        "HopLine",
        "HopLineStart",
        "HopWord",
        "HopPattern",
        "HopChar1",
        "HopChar2",
    },
    config = function()
        require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
    end,
}
editor["karb94/neoscroll.nvim"] = {
    config = conf.neoscroll,
}
editor["vimlab/split-term.vim"] = { opt = true, cmd = { "Term", "VTerm" } }
editor["akinsho/toggleterm.nvim"] = {
    opt = true,
    event = "BufRead",
    config = conf.toggleterm,
}
editor["numtostr/FTerm.nvim"] = {
    opt = false,
    config = function ()
        require("FTerm").setup({
            border = { "┏", "─", "┓", "│", "┛", "─", "┗", "│" },
        })
    end
}
editor["norcalli/nvim-colorizer.lua"] = {
    opt = true,
    event = "BufRead",
    config = conf.nvim_colorizer,
}
editor["rcarriga/nvim-dap-ui"] = {
    opt = false,
    config = conf.dapui,
    requires = {
        { "mfussenegger/nvim-dap", config = conf.dap },
        {
            "Pocco81/dap-buddy.nvim",
            opt = true,
            cmd = { "DIInstall", "DIUninstall", "DIList" },
            commit = "24923c3819a450a772bb8f675926d530e829665f",
            config = conf.dapinstall,
        },
    },
}
editor["tpope/vim-fugitive"] = { opt = true, cmd = { "Git", "G" } }
editor["abecodes/tabout.nvim"] = {
    opt = true,
    event = "InsertEnter",
    wants = "nvim-treesitter",
    after = "nvim-cmp",
    config = conf.tabout,
}
editor["sindrets/diffview.nvim"] = {
    opt = true,
    cmd = { "DiffviewOpen" },
}

return editor
