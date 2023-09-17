local builtin = require "telescope.builtin"

local M = {}

M.status = function()
    builtin.git_status()
end

M.stash = function()
    builtin.git_stash {
        layout_strategy = "flex",
        layout_config = {
            flex = {
                flip_columns = 161, -- half 27" monitor, scientifically calculated
            },
            horizontal = {
                preview_cutoff = 0,
                preview_width = { padding = 17 },
            },
            vertical = {
                preview_cutoff = 0,
                preview_height = { padding = 5 },
            },
        },
    }
end

return M
