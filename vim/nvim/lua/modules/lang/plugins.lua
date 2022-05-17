local lang = {}
local conf = require("modules.lang.config")

lang["crispgm/nvim-go"] = {
    opt = true,
    ft = "go",
    config = function ()
        vim.wo.list = false
        require('go').setup({
            -- notify: use nvim-notify
            notify = false,
            -- auto commands
            auto_format = true,
            auto_lint = true,
            -- linters: revive, errcheck, staticcheck, golangci-lint
            linter = 'revive',
            -- linter_flags: e.g., {revive = {'-config', '/path/to/config.yml'}}
            linter_flags = {},
            -- lint_prompt_style: qf (quickfix), vt (virtual text)
            lint_prompt_style = 'qf',
            -- formatter: goimports, gofmt, gofumpt
            formatter = 'goimports',
            -- test flags: -count=1 will disable cache
            test_flags = {'-v'},
            test_timeout = '30s',
            test_env = {},
            -- show test result with popup window
            test_popup = true,
            test_popup_auto_leave = false,
            test_popup_width = 80,
            test_popup_height = 10,
            -- test open
            test_open_cmd = 'edit',
            -- struct tags
            tags_name = 'json',
            tags_options = {'json=omitempty'},
            tags_transform = 'snakecase',
            tags_flags = {'-skip-unexported'},
            -- quick type
            quick_type_flags = {'--just-types'},
        })
    end,
}
lang["rust-lang/rust.vim"] = { opt = false }
lang["simrat39/rust-tools.nvim"] = {
    config = conf.rust_tools,
    requires = { { "nvim-lua/plenary.nvim", opt = false } },
}
lang["saecki/crates.nvim"] = {
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
        require('crates').setup()
    end
}
lang["iamcco/markdown-preview.nvim"] = {
    opt = true,
    ft = "markdown",
    run = "cd app && yarn install",
}
lang["solarnz/thrift.vim"] = {
    opt = true,
    ft = "thrift",
}
return lang
