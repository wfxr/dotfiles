local ok, null_ls = pcall(require, "null-ls")
if not ok then
    return
end

null_ls.setup {
    sources = {
        null_ls.builtins.diagnostics.actionlint,
        null_ls.builtins.diagnostics.codespell,
        null_ls.builtins.diagnostics.commitlint,
        null_ls.builtins.diagnostics.gitlint,
        null_ls.builtins.diagnostics.hadolint, -- dockerfile linter
        null_ls.builtins.diagnostics.selene,   -- lua linter
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.diagnostics.buf,      -- protobuf

        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.goimports,
        null_ls.builtins.formatting.rustfmt,
        null_ls.builtins.formatting.sql_formatter,
        null_ls.builtins.formatting.clang_format,

        null_ls.builtins.diagnostics.write_good, -- English prose linter.
        null_ls.builtins.diagnostics.yamllint,
        null_ls.builtins.formatting.cbfmt,       -- A tool to format codeblocks inside markdown and org documents.
        null_ls.builtins.formatting.jq,
        -- null_ls.builtins.formatting.ktlint,
        null_ls.builtins.formatting.markdownlint,
        null_ls.builtins.formatting.shellharden,
    },
}
