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
hl.bind("SUPER + RETURN", hl.dsp.exec_cmd("kitty"))
hl.bind("SUPER + SHIFT + RETURN", hl.dsp.exec_cmd("kitty --class FastfetchTerminal zsh -c \"fastfetch; exec zsh\""))
hl.bind("SUPER + SPACE", hl.dsp.exec_cmd(applauncher))
hl.bind("SUPER + W", hl.dsp.window.close())
hl.bind("SUPER + B", hl.dsp.exec_cmd("helium-browser --profile-directory=Default"))
hl.bind("SUPER + SHIFT + B", hl.dsp.exec_cmd("helium-browser --profile-directory=\"School\""))
hl.bind("SUPER + E", hl.dsp.exec_cmd("nautilus --new-window"))
hl.bind("SUPER + SHIFT + E", hl.dsp.exec_cmd("hypremoji"))
hl.bind("SUPER + SHIFT + M", hl.dsp.exec_cmd(minecraft))
hl.bind("SUPER + L", hl.dsp.exec_cmd("localsend"))
hl.bind("SUPER + SHIFT + A", hl.dsp.exec_cmd("spotify"))
hl.bind("SUPER + grave", hl.dsp.exec_cmd("code"))
-- Note: removed snap visualboyadvance-m as per user instruction
-- hl.bind("CONTROL SHIFT", "G", "exec", "[float; size 800 600; center] /snap/bin/visualboyadvance-m")

-- WebApps
hl.bind("SUPER + I", hl.dsp.exec_cmd(webapp .. " \"https://www.instagram.com/\""))
hl.bind("SUPER + C", hl.dsp.exec_cmd(webapp .. " \"https://calendar.google.com/\""))
hl.bind("SUPER + SHIFT + F", hl.dsp.exec_cmd(webapp .. " \"https://www.facebook.com/\""))
hl.bind("SUPER + A", hl.dsp.exec_cmd(webapp .. " \"https://chatgpt.com\""))
hl.bind("SUPER + G", hl.dsp.exec_cmd(webapp .. " \"https://mail.google.com\""))
hl.bind("SUPER + Y", hl.dsp.exec_cmd(webapp .. " \"https://youtube.com/\""))
hl.bind("SUPER + M", hl.dsp.exec_cmd(webapp .. " \"https://facebook.com/messages/\""))
hl.bind("SUPER + N", hl.dsp.exec_cmd(watch))
hl.bind("SUPER + SHIFT + G", hl.dsp.exec_cmd(webapp .. " \"https://github.com/juswa005\""))
hl.bind("SUPER + SHIFT + K", hl.dsp.exec_cmd(webapp .. " \"https://gemini.google.com/app\""))
hl.bind("SUPER + D", hl.dsp.exec_cmd("firefox \"https://discord.com/channels/@me\""))
hl.bind("SUPER + SHIFT + O", hl.dsp.exec_cmd(webapp .. " \"https://github.com/BitSync-Devs\""))
hl.bind("SUPER + SHIFT + W", hl.dsp.exec_cmd(webapp .. " \"http://192.168.254.254\""))
hl.bind("SUPER + U", hl.dsp.exec_cmd(webapp .. " \"http://100.108.14.11:3001/dashboard\""))

-- Hyprland
hl.bind("SUPER + SHIFT + CONTROL + Q", hl.dsp.exit())
hl.bind("SUPER + F", hl.dsp.window.fullscreen())
hl.bind("SUPER + ESCAPE", hl.dsp.exec_cmd(powermenu))
hl.bind("SUPER + SHIFT + ESCAPE", hl.dsp.exec_cmd(powermode))
hl.bind("SUPER + CONTROL + V", hl.dsp.exec_cmd(clipboard))
hl.bind("SUPER + Z", hl.dsp.exec_cmd(wb_toggle))
hl.bind("CONTROL + SHIFT + ESCAPE", hl.dsp.exec_cmd("[float; size 800 600; center] kitty -e btop"))
hl.bind("SUPER + SHIFT + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind("SUPER + CONTROL + L", hl.dsp.exec_cmd(hypridle_toggle .. " disable"))
hl.bind("SUPER + ALT + L", hl.dsp.exec_cmd(hypridle_toggle .. " enable"))
hl.bind("SUPER + CONTROL + K", hl.dsp.exec_cmd(kb_toggle))
hl.bind("SUPER + SHIFT + T", hl.dsp.exec_cmd(screenocr))

-- Mouse
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Switch Workspaces
for i = 1, 9 do
    hl.bind("SUPER + " .. i, hl.dsp.focus({ workspace = i }))
end
hl.bind("SUPER + 0", hl.dsp.focus({ workspace = 10 }))

-- Move windows
for i = 1, 9 do
    hl.bind("SUPER + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end
hl.bind("SUPER + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

-- Brightness
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +10%"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 10%-"))
hl.bind("SUPER + SHIFT + U", hl.dsp.exec_cmd("brightnessctl set +10%"))
hl.bind("SUPER + SHIFT + D", hl.dsp.exec_cmd("brightnessctl set 10%-"))

-- Volume (main controls)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
-- Volume (secondary controls)
hl.bind("SUPER + up", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bind("SUPER + down", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bind("SUPER + right", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))

-- Toggle floating for the active window
hl.bind("SUPER + T", hl.dsp.window.float({ action = "toggle" }))

-- Move floating window
hl.bind("SUPER + SHIFT + LEFT", hl.dsp.exec_cmd("hyprctl dispatch moveactive -20 0"))
hl.bind("SUPER + SHIFT + RIGHT", hl.dsp.exec_cmd("hyprctl dispatch moveactive 20 0"))
hl.bind("SUPER + SHIFT + UP", hl.dsp.exec_cmd("hyprctl dispatch moveactive 0 -20"))
hl.bind("SUPER + SHIFT + DOWN", hl.dsp.exec_cmd("hyprctl dispatch moveactive 0 20"))

-- Resize floating window
hl.bind("SUPER + ALT + LEFT", hl.dsp.exec_cmd("hyprctl dispatch resizeactive -20 0"))
hl.bind("SUPER + ALT + RIGHT", hl.dsp.exec_cmd("hyprctl dispatch resizeactive 20 0"))
hl.bind("SUPER + ALT + UP", hl.dsp.exec_cmd("hyprctl dispatch resizeactive 0 -20"))
hl.bind("SUPER + ALT + DOWN", hl.dsp.exec_cmd("hyprctl dispatch resizeactive 0 20"))

-- Alt tab to change focus
hl.bind("ALT + Tab", hl.dsp.window.cycle_next())
hl.bind("ALT + SHIFT + Tab", hl.dsp.window.cycle_next({ direction = "prev" }))

-- Screenshot and screenrecord
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region --output-folder ~/Pictures/Screenshots"))
hl.bind("SUPER + ALT + S", hl.dsp.exec_cmd(screenrecord .. " start-audio"))
hl.bind("SUPER + CTRL + S", hl.dsp.exec_cmd(screenrecord .. " start-noaudio"))
hl.bind("SUPER + SHIFT + C", hl.dsp.exec_cmd(screenrecord .. " stop"))

-- Websearc
hl.bind("SUPER + ALT + SPACE", hl.dsp.exec_cmd(websearch))

-- Keybinds viewer & Cheatsheets
hl.bind("SUPER + K", hl.dsp.exec_cmd(openbinds))
hl.bind("SUPER + H", hl.dsp.exec_cmd(tmux_cheatsheet))
hl.bind("SUPER + SHIFT + H", hl.dsp.exec_cmd(nvim_cheatsheet))

-- What music is playing
hl.bind("SUPER + SHIFT + N", hl.dsp.exec_cmd(spotify_notify))

-- Wallpaper selector (note)
hl.bind("SUPER + CONTROL + N", hl.dsp.exec_cmd(quicknote))

-- Focus movement
hl.bind("SUPER + CONTROL + LEFT", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + CONTROL + RIGHT", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + CONTROL + UP", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + CONTROL + DOWN", hl.dsp.focus({ direction = "down" }))

-- Swap tiled windows
hl.bind("SUPER + CONTROL + SHIFT + LEFT", hl.dsp.exec_cmd("hyprctl dispatch swapwindow l"))
hl.bind("SUPER + CONTROL + SHIFT + RIGHT", hl.dsp.exec_cmd("hyprctl dispatch swapwindow r"))
hl.bind("SUPER + CONTROL + SHIFT + UP", hl.dsp.exec_cmd("hyprctl dispatch swapwindow u"))
hl.bind("SUPER + CONTROL + SHIFT + DOWN", hl.dsp.exec_cmd("hyprctl dispatch swapwindow d"))

-- Quick workspace cycling with the mouse wheel
hl.bind("SUPER + Tab", hl.dsp.focus({ workspace = "e+1" }))

-- Extra screenshot modes
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m output --output-folder ~/Pictures/Screenshots"))
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m window --output-folder ~/Pictures/Screenshots"))

-- Media controls
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))

-- Extra layout toggles
hl.bind("SUPER + ALT + T", hl.dsp.window.pseudo())
hl.bind("SUPER + SHIFT + P", hl.dsp.window.pin())
