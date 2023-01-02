local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
require("keymap.config")

function show_documentation()
    local filetype = vim.bo.filetype
    if vim.tbl_contains({ 'vim','help' }, filetype) then
        vim.cmd('h '..vim.fn.expand('<cword>'))
    elseif vim.tbl_contains({ 'man' }, filetype) then
        vim.cmd('Man '..vim.fn.expand('<cword>'))
    elseif vim.fn.expand('%:t') == 'Cargo.toml' then
        require('crates').show_popup()
    else
        vim.lsp.buf.hover()
    end
end

project_files = function()
  local ok = pcall(require"telescope.builtin".git_files)
  if not ok then require"telescope.builtin".find_files() end
end


local plug_map = {
    -- Lualine
    ["n|<A-1>"] = map_cr("LualineBuffersJump 1"):with_noremap():with_silent(),
    ["n|<A-2>"] = map_cr("LualineBuffersJump 2"):with_noremap():with_silent(),
    ["n|<A-3>"] = map_cr("LualineBuffersJump 3"):with_noremap():with_silent(),
    ["n|<A-4>"] = map_cr("LualineBuffersJump 4"):with_noremap():with_silent(),
    ["n|<A-5>"] = map_cr("LualineBuffersJump 5"):with_noremap():with_silent(),
    ["n|<A-6>"] = map_cr("LualineBuffersJump 6"):with_noremap():with_silent(),
    ["n|<A-7>"] = map_cr("LualineBuffersJump 7"):with_noremap():with_silent(),
    ["n|<A-8>"] = map_cr("LualineBuffersJump 8"):with_noremap():with_silent(),
    ["n|<A-9>"] = map_cr("LualineBuffersJump 9"):with_noremap():with_silent(),

    -- Packer
    ["n|<leader>ps"] = map_cr("PackerSync"):with_silent():with_noremap():with_nowait(),
    ["n|<leader>pu"] = map_cr("PackerUpdate"):with_silent():with_noremap():with_nowait(),
    ["n|<leader>pi"] = map_cr("PackerInstall"):with_silent():with_noremap():with_nowait(),
    ["n|<leader>pc"] = map_cr("PackerClean"):with_silent():with_noremap():with_nowait(),

    -- Lsp mapp work when insertenter and lsp start
    ["n|<leader>li"] = map_cr("LspInfo"):with_noremap():with_silent():with_nowait(),
    ["n|<leader>lr"] = map_cr("LspRestart"):with_noremap():with_silent():with_nowait(),
    ["n|g["]         = map_cr("lua vim.diagnostic.goto_next()"):with_noremap():with_silent(),
    ["n|g]"]         = map_cr("lua vim.diagnostic.goto_prev()"):with_noremap():with_silent(),
    ["n|K"]          = map_cr("lua show_documentation()"):with_noremap():with_silent(),
    ["n|gr"]         = map_cr("lua vim.lsp.buf.rename()"):with_noremap():with_silent(),
    ["n|<A-s>"]      = map_cr("lua vim.lsp.buf.document_symbol()"):with_noremap():with_silent(),
    ["n|<A-S>"]      = map_cr("lua vim.lsp.buf.workspace_symbol()"):with_noremap():with_silent(),
    ["n|<A-Enter>"]  = map_cr("lua vim.lsp.buf.code_action()"):with_noremap():with_silent(),
    ["v|<A-Enter>"]  = map_cu("lua vim.lsp.buf.range_code_action()"):with_noremap():with_silent(),
    ["n|gu"]         = map_cr("lua vim.lsp.buf.references()"):with_noremap():with_silent(),
    ["n|<Enter>"]    = map_cr("lua vim.lsp.buf.definition()"):with_noremap():with_silent(),
    ["n|<c-a-l>"]    = map_cr("lua vim.lsp.buf.format()"):with_noremap():with_silent(),
    ["n|<C-\\>"]     = map_cu('lua require("FTerm").toggle()'):with_noremap():with_silent(),
    ["t|<C-\\>"]     = map_cu([[<C-\><C-n><CMD>lua require("FTerm").toggle()]]):with_noremap():with_silent(),
    ["t|<C-S-\\>"]   = map_cu([[<C-\><C-n><CMD>lua require("FTerm").exit()]]):with_noremap():with_silent(),
    ["n|<Leader>g"]  = map_cu("lua require('FTerm').run('gitui')"):with_noremap():with_silent(),
    ["n|<Leader>G"]  = map_cu("Git"):with_noremap():with_silent(),
    ["n|gps"]        = map_cr("G push"):with_noremap():with_silent(),
    ["n|gpl"]        = map_cr("G pull"):with_noremap():with_silent(),

    -- Plugin trouble
    ["n|gt"]         = map_cr("TroubleToggle"):with_noremap():with_silent(),
    ["n|gR"]         = map_cr("TroubleToggle lsp_references"):with_noremap():with_silent(),
    ["n|<leader>cd"] = map_cr("TroubleToggle lsp_document_diagnostics"):with_noremap():with_silent(),
    ["n|<leader>cw"] = map_cr("TroubleToggle lsp_workspace_diagnostics"):with_noremap():with_silent(),
    ["n|<leader>cq"] = map_cr("TroubleToggle quickfix"):with_noremap():with_silent(),
    ["n|<leader>cl"] = map_cr("TroubleToggle loclist"):with_noremap():with_silent(),

    -- Plugin nvim-tree
    ["n|<C-n>"]      = map_cr("NvimTreeToggle"):with_noremap():with_silent(),
    ["n|<Leader>nf"] = map_cr("NvimTreeFindFile"):with_noremap():with_silent(),
    ["n|<Leader>nr"] = map_cr("NvimTreeRefresh"):with_noremap():with_silent(),

    -- Plugin Aerial
    ["n|<A-t>"] = map_cr("AerialToggle! right"):with_noremap():with_silent(),

    -- Plugin Minimap
    ["n|<A-n>"] = map_cr("MinimapToggle"):with_noremap():with_silent(),
    ["n|<A-r>"] = map_cr("MinimapRefresh"):with_noremap():with_silent(),

    -- Plugin Undotree
    ["n|<Leader>u"] = map_cr("UndotreeToggle"):with_noremap():with_silent(),

    -- Plugin Telescope
    ["n|<A-f>"]      = map_cu("lua project_files()"):with_noremap():with_silent(),
    ["n|<A-b>"]      = map_cu("Telescope buffers"):with_noremap():with_silent(),
    ["n|<A-g>"]      = map_cu("Telescope live_grep"):with_noremap():with_silent(),
    ["n|<Leader>fr"] = map_cu("lua require('telescope').extensions.frecency.frecency{}"):with_noremap():with_silent(),
    ["n|<Leader>fe"] = map_cu("DashboardFindHistory"):with_noremap():with_silent(),
    ["n|<Leader>ff"] = map_cu("DashboardFindFile"):with_noremap():with_silent(),
    ["n|<Leader>sc"] = map_cu("DashboardChangeColorscheme"):with_noremap():with_silent(),
    ["n|<Leader>fw"] = map_cu("DashboardFindWord"):with_noremap():with_silent(),
    ["n|<Leader>fn"] = map_cu("DashboardNewFile"):with_noremap():with_silent(),
    ["n|<Leader>fb"] = map_cu("Telescope file_browser"):with_noremap():with_silent(),
    ["n|<Leader>fg"] = map_cu("Telescope git_files"):with_noremap():with_silent(),
    ["n|<Leader>fz"] = map_cu("Telescope zoxide list"):with_noremap():with_silent(),

    -- Plugin Hop
    ["n|sj"]  = map_cu("HopVerticalAC"):with_noremap(),
    ["n|sk"]  = map_cu("HopVerticalBC"):with_noremap(),
    ["n|sw"]  = map_cu("HopWord"):with_noremap(),
    ["n|sc"]  = map_cu("HopChar1"):with_noremap(),
    ["n|scc"] = map_cu("HopChar2"):with_noremap(),

    -- Plugin EasyAlign
    ["n|ga"] = map_cmd("v:lua.enhance_align('nga')"):with_expr(),
    ["x|ga"] = map_cmd("v:lua.enhance_align('xga')"):with_expr(),

    -- Plugin split-term
    ["n|<F5>"]   = map_cr("VTerm"):with_noremap():with_silent(),
    ["n|<C-w>t"] = map_cr("VTerm"):with_noremap():with_silent(),

    -- Plugin SnipRun
    ["v|<leader>r"] = map_cr("SnipRun"):with_noremap():with_silent(),

    -- Plugin dap
    ["n|<F6>"]        = map_cr("lua require('dap').continue()"):with_noremap():with_silent(),
    ["n|<leader>dr"]  = map_cr("lua require('dap').continue()"):with_noremap():with_silent(),
    ["n|<leader>dd"]  = map_cr("lua require('dap').terminate() require('dapui').close()"):with_noremap():with_silent(),
    ["n|<leader>db"]  = map_cr("lua require('dap').toggle_breakpoint()"):with_noremap():with_silent(),
    ["n|<leader>dB"]  = map_cr("lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))"):with_noremap():with_silent(),
    ["n|<leader>dbl"] = map_cr("lua require('dap').list_breakpoints()"):with_noremap():with_silent(),
    ["n|<leader>drc"] = map_cr("lua require('dap').run_to_cursor()"):with_noremap():with_silent(),
    ["n|<leader>drl"] = map_cr("lua require('dap').run_last()"):with_noremap():with_silent(),
    ["n|<F9>"]        = map_cr("lua require('dap').step_over()"):with_noremap():with_silent(),
    ["n|<leader>dv"]  = map_cr("lua require('dap').step_over()"):with_noremap():with_silent(),
    ["n|<F10>"]       = map_cr("lua require('dap').step_into()"):with_noremap():with_silent(),
    ["n|<leader>di"]  = map_cr("lua require('dap').step_into()"):with_noremap():with_silent(),
    ["n|<F11>"]       = map_cr("lua require('dap').step_out()"):with_noremap():with_silent(),
    ["n|<leader>do"]  = map_cr("lua require('dap').step_out()"):with_noremap():with_silent(),
    ["n|<leader>dl"]  = map_cr("lua require('dap').repl.open()"):with_noremap():with_silent(),
    ["o|m"]           = map_cu([[lua require('tsht').nodes()]]):with_silent(),

    -- Plugin Tabout
    ["i|<A-l>"] = map_cmd([[<Plug>(TaboutMulti)]]):with_silent(),
    ["i|<A-h>"] = map_cmd([[<Plug>(TaboutBackMulti)]]):with_silent(),

    -- Plugin Diffview
    ["n|<leader>D"]         = map_cr("DiffviewOpen"):with_silent():with_noremap(),
    ["n|<leader><leader>D"] = map_cr("DiffviewClose"):with_silent():with_noremap(),
}

bind.nvim_load_mapping(plug_map)

-- FIXME: Rewrite using pure lua
vim.cmd 'source ~/.config/nvim/lua/keymap/config.vim'
