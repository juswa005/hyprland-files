-- Apps and Scripts configurations
local webapp = "/home/amiel/.config/hypr/scripts/launch-webapp.sh"
local powermenu = "/home/amiel/.config/hypr/scripts/powermenu.sh"
local applauncher = "/home/amiel/.config/hypr/scripts/applauncher.sh"
local websearch = "/home/amiel/.config/hypr/scripts/search.sh"
local openbinds = "/home/amiel/.config/hypr/scripts/hypr-binds.sh"
local minecraft = "/home/amiel/.config/hypr/scripts/tlauncher-launcher.sh"
local clipboard = "/home/amiel/.config/hypr/scripts/clipboard.sh"
local screenrecord = "/home/amiel/.config/hypr/scripts/screenrecord.sh"
local screenocr = "/home/amiel/.config/hypr/scripts/ocr-area.sh"
local spotify_notify = "/home/amiel/.config/hypr/scripts/notify-spotify.sh"
local wb_toggle = "/home/amiel/.config/hypr/scripts/waybar-toggle.sh"
local quicknote = "/home/amiel/.config/hypr/scripts/quick-note.sh"
local powermode = "/home/amiel/.config/hypr/scripts/powermode.sh"
local watch = "/home/amiel/.config/hypr/scripts/anime-movies.sh"
local hypridle_toggle = "/home/amiel/.config/hypr/scripts/hypridle-toggle.sh"
local kb_toggle = "/home/amiel/.config/hypr/scripts/keyboard-mode-toggle.sh"
local tmux_cheatsheet = "/home/amiel/.config/hypr/scripts/tmux-cheatsheet.sh"
local nvim_cheatsheet = "/home/amiel/.config/hypr/scripts/nvim-cheatsheet.sh"

-- Apps
hl.bind("SUPER", "RETURN", "exec", "kitty")
hl.bind("SUPER SHIFT", "RETURN", "exec", "kitty --class FastfetchTerminal zsh -c \"fastfetch; exec zsh\"")
hl.bind("SUPER", "SPACE", "exec", applauncher)
hl.bind("SUPER", "W", "killactive")
hl.bind("SUPER", "B", "exec", "helium-browser --profile-directory=Default")
hl.bind("SUPER SHIFT", "B", "exec", "helium-browser --profile-directory=\"Profile 2\"")
hl.bind("SUPER", "E", "exec", "nautilus --new-window")
hl.bind("SUPER SHIFT", "E", "exec", "hypremoji")
hl.bind("SUPER SHIFT", "M", "exec", minecraft)
hl.bind("SUPER", "L", "exec", "localsend")
hl.bind("SUPER SHIFT", "A", "exec", "spotify")
hl.bind("SUPER", "~", "exec", "code")
-- Note: removed snap visualboyadvance-m as per user instruction
-- hl.bind("CONTROL SHIFT", "G", "exec", "[float; size 800 600; center] /snap/bin/visualboyadvance-m")

-- WebApps
hl.bind("SUPER", "I", "exec", webapp .. " \"https://www.instagram.com/\"")
hl.bind("SUPER", "C", "exec", webapp .. " \"https://calendar.google.com/\"")
hl.bind("SUPER SHIFT", "F", "exec", webapp .. " \"https://www.facebook.com/\"")
hl.bind("SUPER", "A", "exec", webapp .. " \"https://chatgpt.com\"")
hl.bind("SUPER", "G", "exec", webapp .. " \"https://mail.google.com\"")
hl.bind("SUPER", "Y", "exec", webapp .. " \"https://youtube.com/\"")
hl.bind("SUPER", "M", "exec", webapp .. " \"https://facebook.com/messages/\"")
hl.bind("SUPER", "N", "exec", watch)
hl.bind("SUPER SHIFT", "G", "exec", webapp .. " \"https://github.com/juswa005\"")
hl.bind("SUPER SHIFT", "K", "exec", webapp .. " \"https://www.kimi.com/\"")
hl.bind("SUPER", "D", "exec", "firefox \"https://discord.com/channels/@me\"")
hl.bind("SUPER SHIFT", "O", "exec", webapp .. " \"https://github.com/BitSync-Devs\"")
hl.bind("SUPER SHIFT", "W", "exec", webapp .. " \"http://192.168.254.254\"")
hl.bind("SUPER", "U", "exec", webapp .. " \"http://100.108.14.11:3001/dashboard\"")

-- Hyprland
hl.bind("SUPER SHIFT CONTROL", "Q", "exit")
hl.bind("SUPER", "F", "fullscreen")
hl.bind("SUPER", "ESCAPE", "exec", powermenu)
hl.bind("SUPER SHIFT", "ESCAPE", "exec", powermode)
hl.bind("SUPER CONTROL", "V", "exec", clipboard)
hl.bind("SUPER", "Z", "exec", wb_toggle)
hl.bind("CONTROL SHIFT", "ESCAPE", "exec", "[float; size 800 600; center] kitty -e btop")
hl.bind("SUPER SHIFT", "L", "exec", "hyprlock")
hl.bind("SUPER CONTROL", "L", "exec", hypridle_toggle .. " disable")
hl.bind("SUPER ALT", "L", "exec", hypridle_toggle .. " enable")
hl.bind("SUPER CONTROL", "K", "exec", kb_toggle)
hl.bind("SUPER SHIFT", "T", "exec", screenocr)

-- Mouse 
hl.bindm("SUPER", "mouse:272", "movewindow")
hl.bindm("SUPER", "mouse:273", "resizewindow")

-- Switch Workspaces
for i = 1, 9 do
    hl.bind("SUPER", tostring(i), "workspace", tostring(i))
end
hl.bind("SUPER", "0", "workspace", "10")

-- Move windows
for i = 1, 9 do
    hl.bind("SUPER SHIFT", tostring(i), "movetoworkspace", tostring(i))
end
hl.bind("SUPER SHIFT", "0", "movetoworkspace", "10")

-- Brightness
hl.bind("", "XF86MonBrightnessUp", "exec", "brightnessctl set +10%")
hl.bind("", "XF86MonBrightnessDown", "exec", "brightnessctl set 10%-")
hl.bind("SUPER SHIFT", "U", "exec", "brightnessctl set +10%")
hl.bind("SUPER SHIFT", "D", "exec", "brightnessctl set 10%-")

-- Volume (main controls)
hl.bind("", "XF86AudioRaiseVolume", "exec", "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+")
hl.bind("", "XF86AudioLowerVolume", "exec", "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")
hl.bind("", "XF86AudioMute", "exec", "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
-- Volume (secondary controls)
hl.bind("SUPER", "up", "exec", "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+")
hl.bind("SUPER", "down", "exec", "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")
hl.bind("SUPER", "right", "exec", "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")

-- Toggle floating for the active window
hl.bind("SUPER", "T", "togglefloating")

-- Move floating window
hl.bind("SUPER SHIFT", "LEFT", "moveactive", "-20 0")
hl.bind("SUPER SHIFT", "RIGHT", "moveactive", "20 0")
hl.bind("SUPER SHIFT", "UP", "moveactive", "0 -20")
hl.bind("SUPER SHIFT", "DOWN", "moveactive", "0 20")

-- Resize floating window
hl.bind("SUPER ALT", "LEFT", "resizeactive", "-20 0")
hl.bind("SUPER ALT", "RIGHT", "resizeactive", "20 0")
hl.bind("SUPER ALT", "UP", "resizeactive", "0 -20")
hl.bind("SUPER ALT", "DOWN", "resizeactive", "0 20")

-- Alt tab to change focus
hl.bind("ALT", "Tab", "cyclenext", "prev")

-- Screenshot and screenrecord
hl.bind("SUPER SHIFT", "S", "exec", "hyprshot -m region --output-folder ~/Pictures/Screenshots")
hl.bind("SUPER ALT", "S", "exec", screenrecord .. " start-audio")
hl.bind("SUPER CTRL", "S", "exec", screenrecord .. " start-noaudio")
hl.bind("SUPER SHIFT", "C", "exec", screenrecord .. " stop")

-- Websearch 
hl.bind("SUPER ALT", "SPACE", "exec", websearch)

-- Keybinds viewer & Cheatsheets
hl.bind("SUPER", "K", "exec", openbinds)
hl.bind("SUPER", "H", "exec", tmux_cheatsheet)
hl.bind("SUPER SHIFT", "H", "exec", nvim_cheatsheet)

-- What music is playing 
hl.bind("SUPER SHIFT", "N", "exec", spotify_notify)

-- Wallpaper selector (note)
hl.bind("SUPER CONTROL", "N", "exec", quicknote)

-- Focus movement
hl.bind("SUPER CONTROL", "LEFT", "movefocus", "l")
hl.bind("SUPER CONTROL", "RIGHT", "movefocus", "r")
hl.bind("SUPER CONTROL", "UP", "movefocus", "u")
hl.bind("SUPER CONTROL", "DOWN", "movefocus", "d")

-- Swap tiled windows
hl.bind("SUPER CONTROL SHIFT", "LEFT", "swapwindow", "l")
hl.bind("SUPER CONTROL SHIFT", "RIGHT", "swapwindow", "r")
hl.bind("SUPER CONTROL SHIFT", "UP", "swapwindow", "u")
hl.bind("SUPER CONTROL SHIFT", "DOWN", "swapwindow", "d")

-- Quick workspace cycling with the mouse wheel
hl.bind("SUPER", "Tab", "workspace", "e+1")

-- Extra screenshot modes
hl.bind("", "PRINT", "exec", "hyprshot -m output --output-folder ~/Pictures/Screenshots")
hl.bind("SHIFT", "PRINT", "exec", "hyprshot -m window --output-folder ~/Pictures/Screenshots")

-- Media controls
hl.bind("", "XF86AudioMicMute", "exec", "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle")
hl.bind("", "XF86AudioPlay", "exec", "playerctl play-pause")
hl.bind("", "XF86AudioNext", "exec", "playerctl next")
hl.bind("", "XF86AudioPrev", "exec", "playerctl previous")

-- Extra layout toggles
hl.bind("SUPER ALT", "T", "pseudo")
hl.bind("SUPER SHIFT", "P", "pin")
