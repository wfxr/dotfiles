local wezterm = require 'wezterm';

local keybinds = {
    { key = "=", mods = "CTRL",  action = "IncreaseFontSize" },
    { key = "-", mods = "CTRL",  action = "DecreaseFontSize" },
    { key = "0", mods = "CTRL",  action = "ResetFontSize"    },
    { key = "c", mods = "SUPER", action = "Copy"             },
    { key = "v", mods = "SUPER", action = "Paste"            },
}

local config =  {
    font = wezterm.font({
        "JetBrainsMono Nerd Font",
    }),
    window_decorations = "NONE",
    disable_default_key_bindings = true,
    enable_tab_bar = true,
    hide_tab_bar_if_only_one_tab = true,
    allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace",
    adjust_window_size_when_changing_font_size = false,
    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
    },

    keys = keybinds,

    color_scheme = "gruvbox_material_dark_hard",
    color_schemes = {
        gruvbox_material_dark_hard = {
            background    = "#282828",
            foreground    = "#D4BE98",
            cursor_bg     = "#D4BE98",
            cursor_border = "#D4BE98",
            selection_bg  = "#D4BE98" ,
            cursor_fg     = "#1D2021",
            selection_fg  = "#3C3836",

            ansi    = {"#665c54", "#ea6962", "#a9b665", "#e78a4e", "#7daea3", "#d3869b", "#89b482", "#d4be98"},
            brights = {"#928374", "#ea6962", "#a9b665", "#e78a4e", "#7daea3", "#d3869b", "#89b482", "#d4be98"},
        }
    },
}

local function load_config(module)
    local m = package.searchpath(module, package.path)
    if m == nil then
        return {}
    end
    return dofile(m)
end

local function merge_tables(t1, t2)
    for k, v in pairs(t2) do
        if (type(v) == "table") and (type(t1[k] or false) == "table") then
            merge_tables(t1[k], t2[k])
        else
            t1[k] = v
        end
    end
    return t1
end

return merge_tables(config, load_config("darwin"))
