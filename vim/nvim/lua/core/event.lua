local vim = vim
local autocmd = {}

function autocmd.nvim_create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
        vim.api.nvim_command("augroup " .. group_name)
        vim.api.nvim_command("autocmd!")
        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten({ "autocmd", def }), " ")
            vim.api.nvim_command(command)
        end
        vim.api.nvim_command("augroup END")
    end
end

function autocmd.load_autocmds()
    local definitions = {
        packer = {},
        bufs = {
            { "BufWritePre", "/tmp/*", "setlocal noundofile" },
            { "BufWritePre", "COMMIT_EDITMSG", "setlocal noundofile" },
            { "BufWritePre", "MERGE_MSG", "setlocal noundofile" },
            { "BufWritePre", "*.tmp", "setlocal noundofile" },
            { "BufWritePre", "*.bak", "setlocal noundofile" },
            {
                "BufEnter",
                "*",
                [[++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif]],
            },
        },
        wins = {
            -- Highlight current line only on focused window
            {
                "WinEnter,BufEnter,InsertLeave",
                "*",
                [[if ! &cursorline && &filetype !~# '^\(dashboard\|clap_\)' && ! &pvw | setlocal cursorline | endif]],
            },
            {
                "WinLeave,BufLeave,InsertEnter",
                "*",
                [[if &cursorline && &filetype !~# '^\(dashboard\|clap_\)' && ! &pvw | setlocal nocursorline | endif]],
            },
            -- Check if file changed when its window is focus, more eager than 'autoread'
            { "FocusGained", "* checktime" },
            -- Equalize window dimensions when resizing vim window
            { "VimResized", "*", [[tabdo wincmd =]] },
        },
        ft = {
            { "FileType", "*",        "setlocal formatoptions-=c formatoptions-=r formatoptions-=o" },
            { "FileType", "c,cpp",    "nnoremap <leader>h :ClangdSwitchSourceHeader<CR>" },
            { "FileType", "go",       "setl nolist noexpandtab" },
            { "FileType", "make",     "setl nolist noexpandtab  shiftwidth=8 softtabstop=0" },
            { "FileType", "dap-repl", "lua require('dap.ext.autocompl').attach()" },
        },
        yank = {
            {
                "TextYankPost",
                "*",
                [[silent! lua vim.highlight.on_yank({higroup="IncSearch", timeout=100})]],
            },
        },
    }

    autocmd.nvim_create_augroups(definitions)
end

autocmd.load_autocmds()
