local ok, lsp_lines = pcall(require, "lsp_lines")
if not ok then
    return
end

lsp_lines.setup()

local DEFAULT_CONFIG = {
    virtual_text = true,
    warden = {
        line_highlight = true,
    },
    virtual_lines = false,
    underline = true,
    signs = false,
    severity_sort = true,
    float = {
        header = false,
        source = "always",
    },
}

-- Default config
vim.diagnostic.config(DEFAULT_CONFIG)

local Mode = {
    "Default",
    "Lines",
    "None",
}

local current_mode = 1

vim.keymap.set("n", "<M-d>", function()
    current_mode = (current_mode % #Mode) + 1
    if Mode[current_mode] == "Default" then
        vim.diagnostic.config(DEFAULT_CONFIG)
    elseif Mode[current_mode] == "Lines" then
        vim.diagnostic.config {
            virtual_lines = true,
        }
    elseif Mode[current_mode] == "None" then
        vim.diagnostic.config {
            signs = false,
            underline = false,
            line_highlight = false,
            virtual_lines = false,
            virtual_text = false,
        }
    end
end, { desc = "Toggle lsp_lines" })
