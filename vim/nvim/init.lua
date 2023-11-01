function P(...)
    local args = { n = select("#", ...), ... }
    for i = 1, args.n do
        args[i] = vim.inspect(args[i])
    end
    print(unpack(args))
end

vim.g.nvcode_termcolors = 256
vim.g.mapleader = ","
vim.o.termguicolors = true

global = require("wfxr.global")

require "wfxr.plugins"
