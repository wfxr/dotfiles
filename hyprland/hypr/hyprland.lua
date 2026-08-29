-- Hyprland Lua configuration.
-- Migrated from hyprland.conf for Hyprland 0.56.2.

local terminal = "kitty"
local fileManager = "dolphin"
local browser = "firefox"

----------------
--- MONITORS ---
----------------

hl.monitor({
    output = "",
    mode = "highres",
    position = "auto",
    scale = 1.5,
    bitdepth = 10,
})

-----------------
--- AUTOSTART ---
-----------------

hl.on("hyprland.start", function()
    hl.exec_cmd("fcitx5 -d")
    hl.exec_cmd('tmux setenv -g HYPRLAND_INSTANCE_SIGNATURE "$HYPRLAND_INSTANCE_SIGNATURE"')
    hl.exec_cmd("xrdb -merge ~/.Xresources")
    hl.exec_cmd("wl-paste --watch cliphist store")
    hl.exec_cmd("swaync")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("waybar -c ~/.config/waybar/top.jsonc")
    hl.exec_cmd("waybar")
end)

-----------------------------
--- ENVIRONMENT VARIABLES ---
-----------------------------

-- TODO: Check whether this machine has an NVIDIA GPU before setting these.
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("NVD_BACKEND", "direct")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("MOZ_DISABLE_RDD_SANDBOX", "1")

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- The legacy config appended an undefined $scrPath to PATH. Do not carry that
-- broken mutation into the Lua config; add a concrete directory here if needed.
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")

hl.env("LANG", "en_US.UTF-8")
hl.env("LANGUAGE", "en_US:zh_CN")
hl.env("LC_CTYPE", "en_US.UTF-8")

hl.env("XMODIFIERS", "@im=fcitx")
hl.env("QT_IM_MODULE", "fcitx")

---------------------
--- LOOK AND FEEL ---
---------------------

hl.config({
    general = {
        gaps_in = 6,
        gaps_out = 6,
        border_size = 2,
        col = {
            active_border = "rgba(0b9481aa)",
            inactive_border = "rgba(59595988)",
        },
        resize_on_border = false,
        allow_tearing = false,
        layout = "master",
    },

    decoration = {
        rounding = 4,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        fullscreen_opacity = 1.0,
        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },
        blur = {
            enabled = true,
            size = 8,
            passes = 1,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
        orientation = "right",
        mfact = 0.50,
    },

    misc = {
        force_default_wallpaper = 1,
        disable_hyprland_logo = true,
    },

    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",
        follow_mouse = 1,
        mouse_refocus = false,
        sensitivity = 0,
        touchpad = {
            natural_scroll = false,
        },
    },

    xwayland = {
        force_zero_scaling = true,
    },
})

hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.5,
})

------------------
--- ANIMATIONS ---
------------------

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1.0 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 1.73, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.46, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })

-------------------
--- KEYBINDINGS ---
-------------------

local mainMod = "SUPER"

-- Keep a count while registering binds so this migration cannot silently lose
-- any of the 62 registrations from the legacy config.
local bindCount = 0
local function bind(keys, dispatcher, options)
    hl.bind(keys, dispatcher, options)
    bindCount = bindCount + 1
end

bind(mainMod .. " + Return", hl.dsp.layout("swapwithmaster auto"))
bind(mainMod .. " + CTRL + L", hl.dsp.layout("mfact -0.05"))
bind(mainMod .. " + CTRL + H", hl.dsp.layout("mfact +0.05"))

bind(mainMod .. " + backslash", hl.dsp.exec_cmd(terminal))
bind(mainMod .. " + Q", hl.dsp.window.close())
bind(mainMod .. " + SHIFT + Q", hl.dsp.exit())
bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
bind(mainMod .. " + SHIFT + F", hl.dsp.window.float({ action = "toggle" }))
bind(mainMod .. " + P", hl.dsp.window.pseudo())
bind(mainMod .. " + SHIFT + space", hl.dsp.layout("togglesplit"))

-- Toggle Hyprland's fullscreen state without changing the fullscreen state
-- communicated to the client.
bind(mainMod .. " + F", function()
    local window = hl.get_active_window()
    if window then
        local internal = 2
        local client = window.fullscreen_client
        if window.fullscreen == 2 then
            internal = 0
        end

        hl.dispatch(hl.dsp.window.fullscreen_state({
            internal = internal,
            client = client,
            action = "set",
            window = window,
        }))
    end
end)

bind(mainMod .. " + W", hl.dsp.exec_cmd(browser))
bind(mainMod .. " + CTRL + C", hl.dsp.exec_cmd("grimblast copy area"))
bind(mainMod .. " + B", hl.dsp.exec_cmd('pkill -SIGUSR1 -f "^waybar$"'))
bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd("hyprlock"))
bind(mainMod .. " + backspace", hl.dsp.exec_cmd("wlogout -b 6"))
bind(mainMod .. " + CTRL + O", hl.dsp.window.set_prop({ prop = "opaque", value = "toggle" }))

bind("ALT + space", hl.dsp.exec_cmd("pkill fuzzel || fuzzel"))
bind("CTRL + semicolon", hl.dsp.exec_cmd("pkill fuzzel || cliphist list | fuzzel --dmenu -w 80 | cliphist decode | wl-copy"))

bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces and move the active window with SUPER + [0-9].
for i = 1, 10 do
    local key = i % 10
    bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Preserve the five actions registered on the same key, including their order.
bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
bind(mainMod .. " + S", hl.dsp.window.move({ workspace = "+0" }))
bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
bind(mainMod .. " + S", hl.dsp.window.move({ workspace = "special:magic" }))
bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))

bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

local repeatWhileLocked = { locked = true, repeating = true }
bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), repeatWhileLocked)
bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), repeatWhileLocked)
bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), repeatWhileLocked)
bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), repeatWhileLocked)
bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 10%+"), repeatWhileLocked)
bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"), repeatWhileLocked)

local whileLocked = { locked = true }
bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), whileLocked)
bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), whileLocked)
bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), whileLocked)
bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), whileLocked)

assert(bindCount == 62, "expected 62 keybind registrations, got " .. bindCount)

--------------------------------
--- WINDOWS AND WORKSPACES ---
--------------------------------

local windowRuleCount = 0
local function windowRule(rule)
    hl.window_rule(rule)
    windowRuleCount = windowRuleCount + 1
end

windowRule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

windowRule({
    name = "float-empty-class-and-title",
    match = { class = "^$", title = "^$" },
    float = true,
})

windowRule({
    name = "float-image-viewers-and-meetings",
    match = { initial_class = "^$", initial_title = "(图片查看器|飞书会议|图片)" },
    float = true,
})

windowRule({
    name = "float-meeting-class",
    match = { initial_class = "Meeting" },
    float = true,
})

windowRule({
    name = "float-feishu-images",
    match = { class = "Feishu", title = "图片" },
    float = true,
})

windowRule({
    name = "float-wechat-preview",
    match = { class = "wechat", title = "预览" },
    float = true,
})

windowRule({
    name = "strip-feishu-meeting-decoration",
    match = { title = "^飞书会议$" },
    border_size = 0,
    no_blur = true,
    no_shadow = true,
})

windowRule({
    name = "strip-wechat-decoration",
    match = { class = "wechat" },
    border_size = 0,
    no_blur = true,
    no_shadow = true,
})

windowRule({
    name = "zathura-opacity",
    match = { class = "org.pwmt.zathura" },
    no_blur = true,
    opacity = "0.7",
})

windowRule({
    name = "strip-empty-xwayland-decoration",
    match = { class = "^$", title = "^$" },
    border_size = 0,
    no_blur = true,
    rounding = 0,
})

windowRule({
    name = "kitty-opacity",
    match = { class = "kitty" },
    opacity = "0.9 0.8 0.9",
})

windowRule({
    name = "logseq-opacity",
    match = { class = "Logseq" },
    opacity = "0.9 0.8 0.9",
})

windowRule({
    name = "clash-verge-workspace",
    match = { class = "clash-verge" },
    workspace = "5",
})

windowRule({
    name = "keep-pinentry-focused",
    match = { class = "(pinentry-)(.*)" },
    stay_focused = true,
})

assert(windowRuleCount == 14, "expected 14 window rules, got " .. windowRuleCount)
