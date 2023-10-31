local ok, lint = pcall(require, "lint")
if not ok then
    return
end

lint.linters_by_ft = {
    sh         = { "shellcheck"   },
    bash       = { "shellcheck"   },
    zsh        = { "shellcheck"   },
    javascript = { "eslint_d"     },
    typescript = { "eslint_d"     },
    go         = { "golangcilint" },
    -- lua = { "selene" },
    -- gitcommit = { "gitlint" },
}

lint.try_lint()

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    callback = function()
        lint.try_lint()
    end,
})
