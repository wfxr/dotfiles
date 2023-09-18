local deps_ok, dialmap, dialconfig, augend = pcall(function()
    return require "dial.map", require "dial.config", require "dial.augend"
end)
if not deps_ok then
    return
end

dialconfig.augends:register_group {
    default = {
        augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
        augend.constant.alias.bool, -- boolean value (true <-> false)
        augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
        augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
    },
}

vim.keymap.set("n", "<Up>", dialmap.inc_normal())
vim.keymap.set("n", "<Down>", dialmap.dec_normal())
vim.keymap.set("v", "<Up>", dialmap.inc_visual())
vim.keymap.set("v", "<Down>", dialmap.dec_visual())
vim.keymap.set("v", "g<Up>", dialmap.inc_gvisual())
vim.keymap.set("v", "g<Down>", dialmap.dec_gvisual())
