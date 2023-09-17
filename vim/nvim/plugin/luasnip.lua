local ok, luasnip, from_snipmate = pcall(function()
    return require "luasnip", require "luasnip.loaders.from_snipmate"
end)

if not ok then
    return
end

luasnip.config.set_config({
    -- This tells LuaSnip to remember to keep around the last sniptpet.
    -- You can jump back into it even if you move outside of the selection
    history = true,

    -- This one is cool cause if you have dynamic snippets, it updates as you type!
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
})

from_snipmate.lazy_load()

vim.keymap.set("i", "<c-l>", function ()
    if luasnip.choice_active() then
        luasnip.change_choice(1)
    end
end)
