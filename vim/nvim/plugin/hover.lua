local ok, hover = pcall(require, "hover")
if not ok then
    return
end

hover.setup {
    init = function()
        require "hover.providers.lsp"
        require "hover.providers.gh"
        require "hover.providers.man"
        require "hover.providers.dictionary"
    end,
    title = true,
    preview_window = true,
    preview_opts = {
        -- border = global.borders.none,
        border = global.borders.modern,
    }
}

require('hover').register {
   name = 'EN->ZH',
   enabled = function()
     return true
   end,
   execute = require('hover.async').void(function(done)
        local word = vim.fn.expand('<cword>')

        local job = require('hover.async.job').job

        local output = job {
            'clitrans', word,
        }

        local results = { output }
        done(results and {lines=results, filetype="markdown"})
   end)
}

vim.keymap.set("n", "K", hover.hover, { desc = "hover.nvim" })
vim.keymap.set("n", "gK", hover.hover_select, { desc = "hover.nvim (select)" })
