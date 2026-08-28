-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "desc:Samsung Electric Company Odyssey G80SD H1AK500000",
    mode     = "3840x2160@119.88",
    position = "1440x-480",
    scale    = 1.5,
})

hl.monitor({
    output   = "desc:BOE NE135A1M-NY1",
    mode     = "2880x1920@120",
    position = "0x0",
    scale    = 2,
})

local mainKb = "keyd-virtual-keyboard"

--
-- My Programs
--

-- See https://wiki.hypr.land/Configuring/Basics/Binds/
local terminal = "alacritty"
local fileManager = "nautilus"
local menu = "wofi --show drun"
local browser = "chromium"
local lockCmd = "hyprctl switchxkblayout " .. mainKb .. " 0 && hyprlock"

local location = "42.373615:-71.109734" -- Cambridge, MA

--
-- Look and Feel
--

-- https://wiki.hypr.land/Configuring/Basics/Variables/#general
hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 20,
        border_size = 2,
        -- https://wiki.hypr.land/Configuring/Basics/Variables/#colors for info about colors
        -- Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,
        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,
        layout = "dwindle",
        col = {
            active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },
    },
})

-- https://wiki.hypr.land/Configuring/Basics/Variables/#decoration
hl.config({
    decoration = {
        rounding = 10,
        rounding_power = 2,
        -- Change transparency of focused and unfocused windows
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },
        -- https://wiki.hypr.land/Configuring/Basics/Variables/#decorationblur
        blur = {
            enabled = true,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },
})

-- https://wiki.hypr.land/Configuring/Basics/Variables/#animations
hl.config({
    animations = {
        enabled = true,
        -- Default animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/ for more
    },
})
hl.curve("easeOutQuint", {
    type = "bezier",
    points = { { 0.23, 1 }, { 0.32, 1 } },
})
hl.curve("easeInOutCubic", {
    type = "bezier",
    points = { { 0.65, 0.05 }, { 0.36, 1 } },
})
hl.curve("linear", {
    type = "bezier",
    points = { { 0, 0 }, { 1, 1 } },
})
hl.curve("almostLinear", {
    type = "bezier",
    points = { { 0.5, 0.5 }, { 0.75, 1.0 } },
})
hl.curve("quick", {
    type = "bezier",
    points = { { 0.15, 0 }, { 0.1, 1 } },
})
hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "quick" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
hl.workspace_rule({
    workspace = "w[tv1]",
    gaps_out = 0,
    gaps_in = 0,
    no_border = true,
    no_rounding = true,
})
hl.workspace_rule({
    workspace = "f[1]",
    gaps_out = 0,
    gaps_in = 0,
    no_border = true,
    no_rounding = true,
})

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        preserve_split = true,
        -- You probably want this
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
    master = {
        new_status = "master",
    },
})

-- https://wiki.hypr.land/Configuring/Basics/Variables/#misc
hl.config({
    misc = {
        force_default_wallpaper = 0,
        -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo = false,
        -- If true disables the random hyprland logo / anime girl background. :(
        disable_splash_rendering = true,
    },
})


--
-- Input
--

-- https://wiki.hypr.land/Configuring/Basics/Variables/#input
hl.config({
    input = {
        -- Keyboard
        kb_layout = "us,us,th",
        kb_variant = ",colemak,",
        kb_options = "grp:ctrl_space_toggle",
        -- Mouse
        follow_mouse = 2,
        accel_profile = "flat",
        force_no_accel = 1,
        sensitivity = 0.2,
        -- -1.0 - 1.0, 0 means no modification.
        touchpad = {
            natural_scroll = true,
        },
    },
})

-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Gestures/
hl.config({
    gestures = {
        workspace_swipe_distance = 100,
    },
})
hl.gesture({
    ["fingers"] = 3,
    ["direction"] = "horizontal",
    ["action"] = "workspace",
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more

hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.5,
})

-- Lock on lid open
hl.bind("switch:Lid Switch", hl.dsp.exec_cmd(lockCmd), { locked = true })

--
-- Keybindings
--

-- See https://wiki.hypr.land/Configuring/Basics/Binds/
-- Shortcuts
hl.bind("SUPER" .. " + " .. "T", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER" .. " + " .. "B", hl.dsp.exec_cmd(browser))
hl.bind("SUPER" .. " + " .. "Q", hl.dsp.window.close())
hl.bind("CTRL + SUPER + SHIFT" .. " + " .. "Q", hl.dsp.exit())
hl.bind("SUPER" .. " + " .. "E", hl.dsp.exec_cmd(fileManager))
hl.bind("SUPER" .. " + " .. "V", hl.dsp.window.float())
hl.bind("SUPER" .. " + " .. "P", hl.dsp.exec_cmd(menu))
hl.bind("SUPER" .. " + " .. "L", hl.dsp.exec_cmd(lockCmd))
hl.bind("SUPER" .. " + " .. "O", hl.dsp.exec_cmd("obsidian"))
hl.bind("SUPER" .. " + " .. "D", hl.dsp.exec_cmd("discord"))
hl.bind("SUPER" .. " + " .. "S", hl.dsp.exec_cmd("signal-desktop"))
hl.bind("SUPER" .. " + " .. "C", hl.dsp.exec_cmd("thunderbird"))
hl.bind("SUPER" .. " + " .. "M", hl.dsp.exec_cmd("chromium --new-window https://m.me/"))

-- Screenshot keys
hl.bind("CTRL + SHIFT" .. " + " .. 5, hl.dsp.exec_cmd("hyprshot -m window --freeze"))
hl.bind("CTRL + SHIFT" .. " + " .. 3, hl.dsp.exec_cmd("hyprshot -m output --freeze"))
hl.bind("CTRL + SHIFT" .. " + " .. 4, hl.dsp.exec_cmd("hyprshot -m region --freeze"))

-- Fix issue related to screenshot borders
hl.layer_rule({
    match = {
        class = "selector",
    },
    no_anim = true,
})

-- Use SUPER and arrow keys to manage windows

-- Move focus with SUPER + arrow keys
hl.bind("SUPER" .. " + " .. "left", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER" .. " + " .. "right", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER" .. " + " .. "up", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER" .. " + " .. "down", hl.dsp.focus({ direction = "down" }))

-- Move window by adding SHIFT
hl.bind("SUPER + SHIFT" .. " + " .. "left", hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER + SHIFT" .. " + " .. "right", hl.dsp.window.move({ direction = "right" }))
hl.bind("SUPER + SHIFT" .. " + " .. "up", hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER + SHIFT" .. " + " .. "down", hl.dsp.window.move({ direction = "down" }))

-- Resize window by holding CTRL+SUPER
hl.bind("CTRL + SUPER" .. " + " .. "left", hl.dsp.window.resize({ x = -10, y = 0, relative = true }))
hl.bind("CTRL + SUPER" .. " + " .. "right", hl.dsp.window.resize({ x = 10, y = 0, relative = true }))
hl.bind("CTRL + SUPER" .. " + " .. "up", hl.dsp.window.resize({ x = 0, y = -10, relative = true }))
hl.bind("CTRL + SUPER" .. " + " .. "down", hl.dsp.window.resize({ x = 0, y = 10, relative = true }))

-- Move/resize windows with SUPER + LMB/RMB and dragging
hl.bind("SUPER" .. " + " .. "mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER" .. " + " .. "mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Switch workspaces with mouse thumb keys
hl.bind("mouse:275", hl.dsp.focus({ workspace = -1 }))
hl.bind("mouse:276", hl.dsp.focus({ workspace = "+1" }))

-- Use SUPER and number keys to manage workspaces

-- Switch workspaces with SUPER + [0-9]
hl.bind("SUPER" .. " + " .. 1, hl.dsp.focus({ workspace = 1 }))
hl.bind("SUPER" .. " + " .. 2, hl.dsp.focus({ workspace = 2 }))
hl.bind("SUPER" .. " + " .. 3, hl.dsp.focus({ workspace = 3 }))
hl.bind("SUPER" .. " + " .. 4, hl.dsp.focus({ workspace = 4 }))
hl.bind("SUPER" .. " + " .. 5, hl.dsp.focus({ workspace = 5 }))
hl.bind("SUPER" .. " + " .. 6, hl.dsp.focus({ workspace = 6 }))
hl.bind("SUPER" .. " + " .. 7, hl.dsp.focus({ workspace = 7 }))
hl.bind("SUPER" .. " + " .. 8, hl.dsp.focus({ workspace = 8 }))
hl.bind("SUPER" .. " + " .. 9, hl.dsp.focus({ workspace = 9 }))
hl.bind("SUPER" .. " + " .. 0, hl.dsp.focus({ workspace = 10 }))

-- Move active window to a workspace with SUPER + SHIFT + [0-9]
hl.bind("SUPER + SHIFT" .. " + " .. 1, hl.dsp.window.move({ workspace = 1 }))
hl.bind("SUPER + SHIFT" .. " + " .. 2, hl.dsp.window.move({ workspace = 2 }))
hl.bind("SUPER + SHIFT" .. " + " .. 3, hl.dsp.window.move({ workspace = 3 }))
hl.bind("SUPER + SHIFT" .. " + " .. 4, hl.dsp.window.move({ workspace = 4 }))
hl.bind("SUPER + SHIFT" .. " + " .. 5, hl.dsp.window.move({ workspace = 5 }))
hl.bind("SUPER + SHIFT" .. " + " .. 6, hl.dsp.window.move({ workspace = 6 }))
hl.bind("SUPER + SHIFT" .. " + " .. 7, hl.dsp.window.move({ workspace = 7 }))
hl.bind("SUPER + SHIFT" .. " + " .. 8, hl.dsp.window.move({ workspace = 8 }))
hl.bind("SUPER + SHIFT" .. " + " .. 9, hl.dsp.window.move({ workspace = 9 }))
hl.bind("SUPER + SHIFT" .. " + " .. 0, hl.dsp.window.move({ workspace = 10 }))

-- Special workspace (scratchpad)
-- bind = SUPER, S, togglespecialworkspace, magi
-- bind = SUPER SHIFT, S, movetoworkspace, special:magic

-- Media keys

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2.5%+"), { locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2.5%-"), { locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 2.5%+"), { locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 2.5%-"), { locked = true })
-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

--
-- Windows and Workspaces
--

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/ for more
-- See https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/ for workspace rules

-- Ignore maximize requests from apps.
-- hl.window_rule({
--     name  = "suppress_event_maxim",
--     match = {
--     },
-- })

-- Fix some dragging issues with XWayland
hl.window_rule({
    name  = "match_focus_0",
    match = {
        focus = 0,
        class = "^$",
        title = "^$",
        xwayland = 1,
        float = 1,
        fullscreen = 0,
        pin = 0,
    },
})

hl.workspace_rule({
    workspace = 1,
    monitor = "DP-4",
})
hl.workspace_rule({
    workspace = 2,
    monitor = "DP-4",
})
hl.workspace_rule({
    workspace = 3,
    monitor = "DP-4",
})
hl.workspace_rule({
    workspace = 10,
    monitor = "eDP-1",
})
hl.workspace_rule({
    workspace = 9,
    monitor = "eDP-1",
})
hl.workspace_rule({
    workspace = 8,
    monitor = "eDP-1",
})

--
-- Xwayland
--

hl.config({
    xwayland = {
        force_zero_scaling = true,
    },
})

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
hl.env("HYPRSHOT_DIR", os.getenv("HOME") .. "/screenshots")
hl.env("GDK_SCALE", 2)
hl.env("QT_SCALE_FACTOR", 2)
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")

-- Autostart
hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("gammastep -l manual -l " .. location .. " -t 6500:2500 -m wayland")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user start graphical-session.target")
end)
