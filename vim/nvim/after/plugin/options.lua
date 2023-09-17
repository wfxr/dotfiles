-- vim.o.inccommand = "split"
-- vim.wo.wrap = true
-- vim.wo.cursorline = true
-- vim.o.ruler = true
-- vim.o.startofline = false
-- vim.o.backspace = "indent,eol,start"

local global = require("wfxr.global")

vim.opt.termguicolors  = true
vim.opt.mouse          = "a"
vim.opt.title          = true
vim.opt.splitkeep      = "screen"
vim.opt.errorbells     = false
vim.opt.visualbell     = true
vim.opt.hidden         = true
vim.opt.fileformats    = "unix,mac,dos"
vim.opt.magic          = true
vim.opt.virtualedit    = "block"
vim.opt.encoding       = "utf-8"
vim.opt.wildignorecase = true
vim.opt.wildignore     = ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**"
vim.opt.wildmode       = 'full'
vim.opt.smartindent    = true
vim.opt.cindent        = true
vim.opt.backup         = false
vim.opt.writebackup    = false
vim.opt.swapfile       = false
vim.opt.undodir        = global.cache_dir .. "undo/"
vim.opt.history        = 2000
vim.opt.backupskip     = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim"
vim.opt.smarttab       = true
vim.opt.shiftround     = true
vim.opt.timeout        = true
vim.opt.ttimeout       = true
vim.opt.timeoutlen     = 400
vim.opt.ttimeoutlen    = 0
vim.opt.updatetime     = 100
vim.opt.redrawtime     = 1500
vim.opt.ignorecase     = false
vim.opt.smartcase      = true
vim.opt.infercase      = true
vim.opt.incsearch      = true
vim.opt.wrapscan       = true
vim.opt.complete       = ".,w,b,k"
vim.opt.inccommand     = "nosplit"
vim.opt.grepformat     = "%f:%l:%c:%m,%f:%l:%m"
vim.opt.grepprg        = "rg --vimgrep --no-heading --smart-case --"
vim.opt.breakat        = [[\ \    ;:,!?]]
vim.opt.whichwrap      = "h,l,<,>,[,],~"
vim.opt.splitbelow     = true
vim.opt.splitright     = true
vim.opt.switchbuf      = "useopen"
vim.opt.backspace      = "indent,eol,start"
vim.opt.diffopt        = "filler,iwhite,internal,algorithm:patience"
-- voptm.o.completeopt    = "menuone,noselect"
vim.opt.completeopt    = "menu,menuone,noselect"
vim.opt.jumpoptions    = "stack"
vim.opt.showmode       = false
vim.opt.shortmess      = "aoOTIcF"
vim.opt.scrolloff      = 5
vim.opt.sidescrolloff  = 15
vim.opt.foldlevel      = 0
vim.opt.ruler          = true
vim.opt.cursorline     = true
vim.opt.list           = true
vim.opt.showtabline    = 2
vim.opt.winwidth       = 30
vim.opt.winminwidth    = 10
vim.opt.pumheight      = 15
vim.opt.helpheight     = 12
vim.opt.previewheight  = 12
vim.opt.showcmd        = true
vim.opt.cmdheight      = 2
vim.opt.cmdwinheight   = 5
vim.opt.equalalways    = false
vim.opt.laststatus     = 3
vim.opt.display        = "lastline"
vim.opt.showbreak      = "↳  "
vim.opt.listchars      = "tab:··,nbsp:+,trail:·,extends:»,precedes:«"
vim.opt.wildmenu       = true
vim.opt.autoread       = true
vim.opt.autowrite      = true
vim.opt.lazyredraw     = true
vim.opt.hlsearch       = true
vim.opt.showmatch      = true -- show matching brackets when text indicator is over them
vim.opt.matchtime      = 2 -- how many tenths of a second (i.e. x/10 s) to blink when matching brackets
vim.opt.foldcolumn     = "1"
vim.opt.foldlevel      = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable     = true
vim.opt.number         = true
vim.opt.fillchars = {
    eob = " ",
    fold = " ",
    foldopen = "",
    foldsep = " ",
    foldclose = "›",
}
vim.opt.formatoptions:remove "t"
vim.opt.formatoptions:remove "o"
-- vim.opt.statuscolumn = "%=%{&nu?(&rnu&&v:relnum?v:relnum:v:lnum):''}%s%C"
-- vim.opt.pumblend = 10, -- popup_menu
-- vim.opt.winblend = 10, -- floating window

vim.opt_local.undofile       = true
vim.opt_local.synmaxcol      = 2500
vim.opt_local.textwidth      = 80
vim.opt_local.expandtab      = true
vim.opt_local.autoindent     = true
vim.opt_local.tabstop        = 4
vim.opt_local.shiftwidth     = 4
vim.opt_local.softtabstop    = -1
vim.opt_local.wrap           = false
vim.opt_local.linebreak      = true
vim.opt_local.signcolumn     = "yes"
vim.opt_local.conceallevel   = 2
vim.opt_local.concealcursor  = "c"


if vim.fn.has "win32" == 1 then
    vim.o.shell = "powershell.exe"
end

-- Fixate cmdheight to 2
-- vim.api.nvim_create_autocmd({ "WinScrolled" }, {
--     pattern = "*",
--     command = "set cmdheight=2",
-- })
