local ok, dressing = pcall(require, "dressing")
if not ok then
    return
end

dressing.setup {
    input = {
        default_prompt = "> ",
        border = { "┏", "─", "┓", "│", "┛", "─", "┗", "│" },
        win_options = {
            winblend = 5,
            winhighlight = "NormalFloat:Normal",
        },
    },
    select = {
        enabled = false, -- telescope-ui-select is better
        -- Priority list of preferred vim.select implementations
        backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },
        -- Options for built-in selector
        builtin = {
            border = { "┏", "─", "┓", "│", "┛", "─", "┗", "│" },
            win_options = {
                winblend = 5,
            },
        },
    }
}
