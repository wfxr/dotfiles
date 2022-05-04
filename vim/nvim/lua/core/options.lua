local global = require("core.global")

local function bind_option(options)
    for k, v in pairs(options) do
        if v == true then
            vim.cmd("set " .. k)
        elseif v == false then
            vim.cmd("set no" .. k)
        else
            vim.cmd("set " .. k .. "=" .. v)
        end
    end
end

local function load_options()
    local global_local = {
        termguicolors = true,
        mouse = "a",
        errorbells = false,
        visualbell = true,
        hidden = true,
        fileformats = "unix,mac,dos",
        magic = true,
        virtualedit = "block",
        encoding = "utf-8",
        wildignorecase = true,
        wildignore = ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**",
        wildmode = 'full',
        smartindent = true,
        cindent = true,
        backup = false,
        writebackup = false,
        swapfile = false,
        undodir = global.cache_dir .. "undo/",
        history = 2000,
        backupskip = "/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim",
        smarttab = true,
        shiftround = true,
        timeout = true,
        ttimeout = true,
        timeoutlen = 400,
        ttimeoutlen = 0,
        updatetime = 100,
        redrawtime = 1500,
        ignorecase = true,
        smartcase = true,
        infercase = true,
        incsearch = true,
        wrapscan = true,
        complete = ".,w,b,k",
        inccommand = "nosplit",
        grepformat = "%f:%l:%c:%m",
        grepprg = "rg --hidden --vimgrep --smart-case --",
        breakat = [[\ \    ;:,!?]],
        whichwrap = "h,l,<,>,[,],~",
        splitbelow = true,
        splitright = true,
        switchbuf = "useopen",
        backspace = "indent,eol,start",
        diffopt = "filler,iwhite,internal,algorithm:patience",
        completeopt = "menuone,noselect",
        jumpoptions = "stack",
        showmode = false,
        shortmess = "aoOTIcF",
        scrolloff = 4,
        sidescrolloff = 15,
        foldlevel = 0,
        ruler = true,
        cursorline = true,
        list = true,
        showtabline = 2,
        winwidth = 30,
        winminwidth = 10,
        pumheight = 15,
        helpheight = 12,
        previewheight = 12,
        showcmd = false,
        cmdheight = 2,
        cmdwinheight = 5,
        equalalways = false,
        laststatus = 2,
        display = "lastline",
        showbreak = "↳  ",
        listchars = "tab:··,nbsp:+,trail:·,extends:»,precedes:«",
        pumblend = 10, -- popup_menu
        winblend = 10, -- floating window
        wildmenu = true,
        autoread = true,
        autowrite = true,
        lazyredraw = true,
        hlsearch = true,
        showmatch = true, -- show matching brackets when text indicator is over them
        matchtime = 2, -- how many tenths of a second (i.e. x/10 s) to blink when matching brackets
    }

    local bw_local = {
        undofile = true,
        synmaxcol = 2500,
        formatoptions = "1jcroql",
        textwidth = 80,
        expandtab = true,
        autoindent = true,
        tabstop = 4,
        shiftwidth = 4,
        softtabstop = -1,
        breakindentopt = "shift:2,min:20",
        wrap = false,
        linebreak = true,
        number = true,
        foldenable = false,
        foldmethod = 'syntax',
        signcolumn = "yes",
        conceallevel = 2,
        concealcursor = "c",
    }

    for name, value in pairs(global_local) do
        vim.o[name] = value
    end
    bind_option(bw_local)
end

load_options()
