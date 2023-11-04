local ok, luasnip = pcall(function()
    return require "luasnip"
end)

if not ok then
    return
end

local types = require("luasnip.util.types")

luasnip.setup({
    keep_roots = true,
    link_roots = true,
    link_children = true,
    -- Update more often, :h events for more info.
    updateevents = "TextChanged,TextChangedI",
    -- Snippets aren't automatically removed if their text is deleted.
    -- `delete_check_events` determines on which events (:h events) a check for
    -- deleted snippets is performed.
    -- This can be especially useful when `history` is enabled.
    delete_check_events = "TextChanged",
    ext_opts = { [types.choiceNode] = { active = { virt_text = { { "choiceNode", "Comment" } } } } },
    -- treesitter-hl has 100, use something higher (default is 200).
    ext_base_prio = 300,
    -- minimal increase in priority.
    ext_prio_increase = 1,
    enable_autosnippets = true,
    -- mapping for cutting selected text so it's usable as SELECT_DEDENT,
    -- SELECT_RAW or TM_SELECTED_TEXT (mapped via xmap).
    -- store_selection_keys = "<Tab>",
    -- luasnip uses this function to get the currently active filetype. This
    -- is the (rather uninteresting) default, but it's possible to use
    -- eg. treesitter for getting the current filetype by setting ft_func to
    -- require("luasnip.extras.filetype_functions").from_cursor (requires
    -- `nvim-treesitter/nvim-treesitter`). This allows correctly resolving
    -- the current filetype in eg. a markdown-code block or `vim.cmd()`.
    ft_func = function()
        return vim.split(vim.bo.filetype, ".", true)
    end,
})

require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/luasnip" })

require("luasnip.loaders.from_vscode").lazy_load({
    paths = { vim.fn.stdpath("data") .. "/lazy/friendly-snippets" },
}) -- You can pass { paths = "./my-snippets/"} as well

 require("luasnip.loaders.from_snipmate").lazy_load({
    paths = "~/.config/nvim/snippets/snipmate/"
})

-- One peculiarity of honza/vim-snippets is that the file with the global snippets is _.snippets, so global snippets
-- are stored in `ls.snippets._`.
-- We need to tell luasnip that "_" contains global snippets:
luasnip.filetype_extend("all", { "_" })

vim.keymap.set("i", "<c-l>", function ()
    if luasnip.choice_active() then
        luasnip.change_choice(1)
    end
end)

function lua_snip_edit()
    require("luasnip.loaders").edit_snippet_files({
        ft_filter = function(ft)
            return ft == vim.bo.filetype
        end,
        format = function(path, _)
            path = path:gsub(
                vim.pesc(vim.fn.stdpath("data") .. "/lazy"),
                "$PLUGINS"
            )
            path = path:gsub(".*dotfiles.*(snippets/.*)", "$DOTFILES/%1") or path
            return path
        end,
        edit = function(file)
            vim.cmd("tabnew " .. file)
        end
    })
end

vim.cmd [[command! LuaSnipEdit :lua lua_snip_edit()]]
