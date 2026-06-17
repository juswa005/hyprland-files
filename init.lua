-- Main Hyprland Configuration (Lua)

-- Source modular configs
require("binds")
require("inputs")
require("windows")
require("autostart")
require("windowrules")
require("monitors")
require("workspaces")

-- General settings
hl.setup({
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

-- Source external non-Lua configs
hl.source("/home/amiel/.config/hypr/hyprsunset.conf")
hl.source("/home/amiel/.config/hypremoji/hypremoji.conf")
