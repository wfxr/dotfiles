local ok, conform = pcall(require, "conform")
if not ok then
    return
end

conform.setup ({
    formatters_by_ft = {
        -- lua  = { "stylua" },

        rust = { "rustfmt"           },
        c    = { "clang_format"      },
        cpp  = { "clang_format"      },
        go   = { "goimports-reviser" },
        yaml = { "yamlfix"           },

        markdown = { "deno_fmt",  "injected"  },
        sql      = { "sqlformat", "pg_format" },
    },
    format_on_save = function(bufnr)
        -- Disable autoformat on certain filetypes
        local ignore_filetypes = { "sql", "java" }
        if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
            return
        end
        return { timeout_ms = 500, lsp_fallback = true }
    end,
    formatters = {
        ["goimports-reviser"] = {
            prepend_args = { "-rm-unused", "-set-alias" },
        },
    }
})

vim.api.nvim_create_user_command("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  conform.format({ async = true, lsp_fallback = true, range = range })
end, { range = true })
