local ok, statuscol = pcall(require, "statuscol")
if not ok then
    return
end

local builtin = require "statuscol.builtin"

statuscol.setup {
    setopt = true,
    ft_ignore = { "qf" },
    segments = {
        { text = { "%s" }, click = "v:lua.ScSa" },
        {
            text = { builtin.lnumfunc, " " },
            condition = { true, builtin.not_empty },
            click = "v:lua.ScLa",
        },
        { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
        { text = { " " } },
    },
}
