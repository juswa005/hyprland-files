-- Main Hyprland Configuration (Lua)
require("dump")

-- Source modular configs
require("binds")
require("inputs")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("GTK_THEME", "Adwaita:dark")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("LANG", "en_US.UTF-8")
hl.env("LC_ALL", "en_US.UTF-8")
require("windows")
require("autostart")
require("windowrules")
require("monitors")
require("workspaces")

-- General settings
hl.config({
    general = {
        gaps_in = 1,
        gaps_out = 2,
        border_size = 1,
        layout = "dwindle"
    },
    animations = {
        enabled = false
    },
    xwayland = {
        force_zero_scaling = true
    }
})


