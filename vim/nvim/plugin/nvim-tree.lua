local ok, nvimtree = pcall(function()
    return require "nvim-tree"
end)
if not ok then
    return
end

local function on_attach(bufnr)
    local api = require('nvim-tree.api')
    local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    vim.keymap.set('n', '<CR>',      api.node.open.edit,               opts('Open'))
    vim.keymap.set('n', 'o',         api.node.open.preview,            opts('Open    Preview'))
    vim.keymap.set('n', 'K',         api.node.show_info_popup,         opts('Info'))
    vim.keymap.set('n', '<c-x>',     api.node.open.horizontal,         opts('Split   Horizontal'))
    vim.keymap.set('n', '<c-v>',     api.node.open.vertical,           opts('Split   Vertical'))
    vim.keymap.set('n', 'yy',        api.fs.copy.node,                 opts('Copy'))
    vim.keymap.set('n', 'dd',        api.fs.cut,                       opts('Cut'))
    vim.keymap.set('n', '<leader>r', api.fs.rename_basename,           opts('Rename: Basename'))
    vim.keymap.set('n', '<leader>R', api.fs.rename,                    opts('Rename'))
    vim.keymap.set('n', 'p',         api.fs.paste,                     opts('Paste'))
    vim.keymap.set('n', 'c',         api.fs.create,                    opts('Create'))
    vim.keymap.set('n', 'D',         api.fs.remove,                    opts('Delete'))
    vim.keymap.set('n', '<BS>',      api.tree.change_root_to_parent,   opts('Up'))
    vim.keymap.set('n', 'H',         api.tree.toggle_hidden_filter,    opts('Toggle  Filter: Dotfiles'))
    vim.keymap.set('n', 'I',         api.tree.toggle_gitignore_filter, opts('Toggle  Filter: Git Ignore'))
    vim.keymap.set('n', '?',         api.tree.toggle_help,             opts('Help'))
end

nvimtree.setup {
    on_attach = on_attach,
    auto_reload_on_write = true,
    disable_netrw = false,
    hijack_cursor = true,
    hijack_netrw = true,
    hijack_unnamed_buffer_when_opening = false,
    open_on_tab = false,
    sort_by = "name",
    update_cwd = true,
    view = {
        width = 30,
        side = "left",
        preserve_window_proportions = false,
        number = false,
        relativenumber = false,
        signcolumn = "no",
    },
    renderer = {
        add_trailing = false,
        group_empty = false,
        highlight_git = false,
        highlight_opened_files = "none",
        root_folder_modifier = ":~",
        indent_markers = {
            enable = false,
            icons = {
                corner = "└ ",
                edge = "│ ",
                none = "  ",
            },
        },
        icons = {
            web_devicons = {
                file = {
                    enable = true,
                    color = true,
                },
                folder = {
                    enable = false,
                    color = true,
                },
            },
            git_placement = "after",
            padding = " ",
            symlink_arrow = " ➛ ",
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
            },
            glyphs = {
                default = "",
                symlink = "",
                folder = {
                    arrow_closed = "",
                    arrow_open = "",
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                    symlink_open = "",
                },
                git = {
                    unstaged  = "",
                    staged    = "",
                    unmerged  = "",
                    renamed   = "",
                    untracked = "",
                    deleted   = "",
                    ignored   = "",
                },
            },
        },
        special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
    },
    hijack_directories = {
        enable = true,
        auto_open = true,
    },
    update_focused_file = {
        enable = true,
        update_cwd = true,
        ignore_list = {},
    },
    filters = {
        dotfiles = false,
        custom = { ".DS_Store" },
        exclude = {},
    },
    actions = {
        change_dir = {
            enable = true,
            global = false,
            restrict_above_cwd = true,
        },
        open_file = {
            quit_on_open = false,
            resize_window = false,
            window_picker = {
                enable = true,
                chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                exclude = {
                    filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                    buftype = { "nofile", "terminal", "help" },
                },
            },
        },
    },
}

vim.keymap.set("n", "<C-n>", "<cmd>NvimTreeToggle<cr>")
