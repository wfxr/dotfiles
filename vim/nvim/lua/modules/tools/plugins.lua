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

return tools
