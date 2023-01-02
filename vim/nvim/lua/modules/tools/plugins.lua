local tools = {}
local conf = require("modules.tools.config")

tools["nvim-lua/plenary.nvim"] = { opt = false }

tools["nvim-telescope/telescope.nvim"] = {
    config = conf.telescope,
    requires = {
        { "nvim-lua/plenary.nvim", opt = false },
        { "nvim-lua/popup.nvim", opt = true },
    },
}

tools["nvim-telescope/telescope-ui-select.nvim"] = {
    opt = true,
    after = "telescope.nvim",
}

tools["nvim-telescope/telescope-fzf-native.nvim"] = {
    opt = true,
    run = "make",
    after = "telescope.nvim",
}

tools["nvim-telescope/telescope-frecency.nvim"] = {
    opt = true,
    after = "telescope-fzf-native.nvim",
    requires = { { "tami5/sqlite.lua", opt = true } },
}

tools["jvgrootveld/telescope-zoxide"] = { opt = true, after = "telescope-frecency.nvim" }

tools["michaelb/sniprun"] = {
    opt = true,
    run = "bash ./install.sh",
    cmd = { "SnipRun", "'<,'>SnipRun" },
}

tools["folke/trouble.nvim"] = {
    opt = true,
    cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" },
    config = conf.trouble,
}

tools["dstein64/vim-startuptime"] = { opt = true, cmd = "StartupTime" }

tools["gelguy/wilder.nvim"] = {
    event = "CmdlineEnter",
    config = conf.wilder,
    requires = { { "romgrk/fzy-lua-native", after = "wilder.nvim" } },
}

-- tools["nathom/filetype.nvim"] = {
--     opt = false,
--     config = conf.filetype,
-- }

tools["farmergreg/vim-lastplace"] = {
    opt = false,
}

tools["MunifTanjim/exrc.nvim"] = {
    opt = false,
    config = function()
        require("exrc").setup({
            files = {
                ".nvimrc.lua",
                ".nvimrc",
                ".exrc.lua",
                ".exrc",
            },
        })
    end,
}

tools["jbyuki/venn.nvim"] = {
    opt = true,
    cmd = { "VBox", "'<,'>VBox" },
}

tools["chentoast/marks.nvim"] = {
    opt = false,
    config = function()
        require("marks").setup({
            -- whether to map keybinds or not. default true
            default_mappings = true,
            -- which builtin marks to show. default {}
            -- builtin_marks = { ".", "<", ">", "^" },
            -- whether movements cycle back to the beginning/end of buffer. default true
            cyclic = true,
            -- whether the shada file is updated after modifying uppercase marks. default false
            force_write_shada = false,
            -- how often (in ms) to redraw signs/recompute mark positions. 
            -- higher values will have better performance but may cause visual lag, 
            -- while lower values may cause performance penalties. default 150.
            refresh_interval = 250,
            -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
            -- marks, and bookmarks.
            -- can be either a table with all/none of the keys, or a single number, in which case
            -- the priority applies to all marks.
            -- default 10.
            sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
            -- disables mark tracking for specific filetypes. default {}
            excluded_filetypes = {},
            mappings = {}
        })
    end,
}

return tools
