local wezterm = require 'wezterm';

local keybinds = {
    { key = "=", mods = "CTRL", action = "IncreaseFontSize" },
    { key = "-", mods = "CTRL", action = "DecreaseFontSize" },
    { key = "0", mods = "CTRL", action = "ResetFontSize" },
}

return {
    font = wezterm.font_with_fallback({
        "JetBrainsMono Nerd Font",
        "Sarasa Mono SC Nerd",
        "FiraCode Nerd Font",
        "JetBrains Mono",
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
