local deps_ok, lualine = pcall(function()
    return require "lualine"
end)
if not deps_ok then
    return
end

local function attached_clients()
    return "(" .. vim.tbl_count(vim.lsp.buf_get_clients(0)) .. ")"
end

local function cwd()
    return vim.fn.fnamemodify(vim.loop.cwd(), ":~")
end

local mini_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { "location" },
}
local simple_sections = {
    lualine_a = { "mode" },
    lualine_b = { "filetype" },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { "location" },
}
local minimap = {
    sections = mini_sections,
    filetypes = { "minimap" },
}
local aerial = {
    sections = mini_sections,
    filetypes = { "aerial" },
}
local dapui_scopes = {
    sections = simple_sections,
    filetypes = { "dapui_scopes" },
}

local dapui_breakpoints = {
    sections = simple_sections,
    filetypes = { "dapui_breakpoints" },
}

local dapui_stacks = {
    sections = simple_sections,
    filetypes = { "dapui_stacks" },
}

local dapui_watches = {
    sections = simple_sections,
    filetypes = { "dapui_watches" },
}

lualine.setup {
    options = {
        icons_enabled = true,
        theme = "auto",
        disabled_filetypes = {},
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        globalstatus = true,
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { { "branch" }, { "diff" } },
        lualine_c = {},
        lualine_x = {
            {
                "diagnostics",
                sources = { "nvim_diagnostic" },
                symbols = global.symbols.diagnostic,
                diagnostics_color = {
                    error = "DiagnosticSignError",
                    warn  = "DiagnosticSignWarn",
                    info  = "DiagnosticSignInfo",
                    hint  = "DiagnosticSignHint",
                },
                colored = true,
            },
            {
                require("lazy.status").updates,
                cond = require("lazy.status").has_updates,
                color = { fg = "#ff9e64" },
            },
        },
        lualine_y = {
            {
                "filetype",
                "encoding",
            },
            {
                "fileformat",
                icons_enabled = true,
                symbols = {
                    unix = "LF",
                    dos = "CRLF",
                    mac = "CR",
                },
            },
        },
        lualine_z = { "progress", "location" },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {
        lualine_a = {
            {
                "buffers",
                mode = 2,
                show_modified_status = true,
            },
        },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
    extensions = {
        "quickfix",
        "nvim-tree",
        "toggleterm",
        "fugitive",
        minimap,
        aerial,
        dapui_scopes,
        dapui_breakpoints,
        dapui_stacks,
        dapui_watches,
    },
}

local keymap = vim.keymap.set
keymap("n", "<A-1>", ":LualineBuffersJump 1<CR>", { silent = true })
keymap("n", "<A-2>", ":LualineBuffersJump 2<CR>", { silent = true })
keymap("n", "<A-3>", ":LualineBuffersJump 3<CR>", { silent = true })
keymap("n", "<A-4>", ":LualineBuffersJump 4<CR>", { silent = true })
keymap("n", "<A-5>", ":LualineBuffersJump 5<CR>", { silent = true })
keymap("n", "<A-6>", ":LualineBuffersJump 6<CR>", { silent = true })
keymap("n", "<A-7>", ":LualineBuffersJump 7<CR>", { silent = true })
keymap("n", "<A-8>", ":LualineBuffersJump 8<CR>", { silent = true })
keymap("n", "<A-9>", ":LualineBuffersJump 9<CR>", { silent = true })
