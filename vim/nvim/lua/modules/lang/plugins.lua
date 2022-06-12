local lang = {}
local conf = require("modules.lang.config")

lang["rust-lang/rust.vim"] = { opt = false }
lang["simrat39/rust-tools.nvim"] = {
    config = conf.rust_tools,
    requires = { { "nvim-lua/plenary.nvim", opt = false } },
}
lang["saecki/crates.nvim"] = {
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
        require('crates').setup()
    end
}
lang["iamcco/markdown-preview.nvim"] = {
    opt = true,
    ft = "markdown",
    run = "cd app && yarn install",
}
lang["solarnz/thrift.vim"] = {
    opt = true,
    ft = "thrift",
}
return lang
