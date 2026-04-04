# Hyprland Files

This repository contains a modular Hyprland setup plus companion configs for Waybar, Kitty, and Dunst.

The main Hyprland config is intentionally split into small files so it is easier to copy, maintain, and tweak per machine. The current setup is built around a personal dual-monitor workflow with Wofi launchers, Chromium web-app shortcuts, quick note capture, screenshots, screen recording, media controls, and a simple lock/idle stack.

## Overview

- Window manager: Hyprland with the `dwindle` layout
- Style: minimal gaps, thin borders, animations disabled
- Lock/idle stack: `hyprlock` + `hypridle`
- Screen warmth: `hyprsunset`
- Launcher/UI helpers: `wofi`, `waybar`, `dunst`
- Clipboard flow: `wl-paste` + `cliphist`
- Capture tools: `hyprshot`, `grim`, `slurp`, `wf-recorder`
- Browser workflow: Chromium app windows plus a small anime/movie selector
- Extra configs: bundled Dunst, Kitty, and Waybar files in `others/`
- Extra assets: wallpapers and terminal/logo art in `ff_logo/`

## Repository Layout

### Top-level Hyprland config

| File | Purpose |
| --- | --- |
| `hyprland.conf` | Main entry point. Sources the modular config files and sets the core layout defaults. |
| `binds.conf` | Main keybindings for apps, web shortcuts, screenshots, recording, music, quick notes, and helper scripts. |
| `binds-qol.conf` | Extra keybindings for focus movement, swapping tiled windows, workspace cycling, extra screenshots, media keys, and layout toggles. |
| `autostart.conf` | Starts tray applets, Waybar, wallpaper, notifications, clipboard watchers, `hyprsunset`, `hypridle`, Ollama, and a PicoClaw terminal. |
| `inputs.conf` | Keyboard layout, pointer sensitivity, and touchpad behavior. |
| `windows.conf` | Declares workspaces `1` through `10`. |
| `windowrules.conf` | Floats and centers `wofi` with a fixed size. |
| `monitors.conf` | `nwg-displays` generated monitor layout for `eDP-1` and `HDMI-A-1`. |
| `workspaces.conf` | `nwg-displays` generated workspace-to-monitor assignments. |
| `hypridle.conf` | Locks the session with `hyprlock` after 300 seconds of inactivity. |
| `hyprlock.conf` | Lock screen background, password box, clock, date, username, and failure label styling. |
| `hyprsunset.conf` | Blue-light reduction config with manual sunrise/sunset times and a 4000K night temperature. |

### `scripts/`

| File | Purpose |
| --- | --- |
| `scripts/anime-movies.sh` | Opens a Wofi menu that launches either Aniwatch or a movie site in Chromium app mode. |
| `scripts/applauncher.sh` | Opens a Wofi `drun` launcher with a simple lockfile debounce. |
| `scripts/hypr-binds.sh` | Displays `bind` lines from `binds.conf` inside Wofi. |
| `scripts/hypridle-toggle.sh` | Enables or disables `hypridle` and sends a notification about the current state. |
| `scripts/launch-webapp.sh` | Launches a URL in Chromium app mode. |
| `scripts/notify-spotify.sh` | Sends a desktop notification with the current Spotify track if Spotify is playing. |
| `scripts/powermenu.sh` | Opens a Wofi shutdown/reboot menu. |
| `scripts/powermode.sh` | Switches between `performance`, `balanced`, and `power-saver` profiles. |
| `scripts/preview-clipboard.sh` | Decodes clipboard history items and renders image previews through ImageMagick when needed. |
| `scripts/quick-note.sh` | Opens a floating Kitty + Neovim window on a timestamped note in `~/Notes`. |
| `scripts/screenrecord.sh` | Starts or stops region recording with `wf-recorder`, with or without audio, and notifies the result. |
| `scripts/search.sh` | Opens a one-line Wofi prompt and launches a Google search in Chromium app mode. |
| `scripts/shot-area` | Saves a region screenshot to `~/Pictures/Screenshots` and copies it to the clipboard. |
| `scripts/tlauncher-launcher.sh` | Launches TLauncher normally or through NVIDIA offload modes. |
| `scripts/waybar-toggle.sh` | Toggles Waybar on and off by PID. |
| `scripts/yt-dlp` | Bundled `yt-dlp` executable. Not wired into the current Hyprland config. |
| `scripts/bin` | Empty placeholder file in the current snapshot. |

### `others/`

These files are not sourced by Hyprland automatically. They are companion configs you can copy into their normal locations under `~/.config`.

| Path | Purpose |
| --- | --- |
| `others/dunst/dunstrc` | Minimal monochrome Dunst config with top-right placement and rounded corners. |
| `others/kitty/kitty.conf` | Main Kitty config using `FiraCode Nerd Font`, light transparency, and a black-and-white palette. |
| `others/kitty/*.conf` | Extra Kitty color/theme files, including `Kanagawa.conf` and a backup `kitty.conf.bak`. |
| `others/waybar/2.jsonc` | Current Waybar config with workspaces, power profile, sysusage, audio, network, battery, calendar, and tray modules. |
| `others/waybar/style.css` | Waybar stylesheet for the current bar layout. |
| `others/waybar/scripts/sysusage.sh` | Small helper script that prints CPU and RAM usage for Waybar. |
| `others/waybar/backups/` | Older Waybar config and style backups. |
| `others/waybar/config.jsonc` | Fastfetch-style preset stored in this folder. It is not the active Waybar config. |

### Assets

| Path | Contents |
| --- | --- |
| `wallpapers/` | 13 wallpapers in JPG, JPEG, and PNG formats. The current default wallpaper is `wallpapers/jap2.jpg`. |
| `ff_logo/` | 5 PNG art assets plus `frieren.txt`, an ANSI-colored text-art file for terminal or Fastfetch use. |

## Current Behavior

### Hyprland core

`hyprland.conf` keeps the desktop style compact and minimal:

- `gaps_in = 1`
- `gaps_out = 2`
- `border_size = 1`
- `layout = dwindle`
- animations are fully disabled

It currently sources:

- `binds.conf`
- `binds-qol.conf`
- `inputs.conf`
- `windows.conf`
- `autostart.conf`
- `windowrules.conf`
- `hyprsunset.conf`
- `monitors.conf`
- `workspaces.conf`

### Monitors and workspaces

The current monitor layout assumes:

- `eDP-1` at `1920x1080@60`, scale `1.25`
- `HDMI-A-1` at `1920x1080@144`, scale `1.0`

Workspaces are pinned by monitor:

- `1` to `8` live on `HDMI-A-1`
- `9` and `10` live on `eDP-1`
- default workspaces are `1` on the external display and `10` on the laptop display

Both `monitors.conf` and `workspaces.conf` are generated by `nwg-displays`, so they should usually be regenerated there instead of hand-edited.

### Input behavior

`inputs.conf` currently sets:

- US keyboard layout
- `follow_mouse = 1`
- neutral sensitivity
- touchpad natural scrolling
- touchpad tap-to-click
- touchpad disable-while-typing

There is also a commented `altwin:swap_alt_win` line kept for an external keyboard workflow.

### Idle, lock, and screen warmth

- `hypridle` locks the session after 5 minutes
- `hyprlock` uses `wallpapers/jap2.jpg` with blur and a centered password box
- the lock screen shows time, full date, current user, and fail-state text
- `hyprsunset` is enabled with a 4000K night temperature, 10 second transitions, and manual `06:00` / `18:00` switching

### Autostart programs

On session start, the current setup tries to launch:

- `nm-applet`
- `blueman-applet`
- `waybar`
- `elephant`
- `swaybg` with `wallpapers/jap2.jpg`
- `dunst`
- `hyprsunset`
- text and image clipboard watchers via `wl-paste` + `cliphist`
- `ollama` through `systemctl --user start ollama || ollama serve`
- `hypridle`
- `foot -e sh -c 'picoclaw agent 2>/dev/null'`

That means this setup assumes a few custom or optional tools already exist on the machine, especially `elephant`, `ollama`, and `picoclaw`.

## Keybindings

`SUPER` is the main modifier.

### App launchers and desktop tools

| Key | Action |
| --- | --- |
| `SUPER + Return` | Open `kitty` |
| `SUPER + Shift + Return` | Open a Kitty terminal that runs `fastfetch` |
| `SUPER + Space` | Open the Wofi app launcher |
| `SUPER + B` | Open Chromium |
| `SUPER + E` | Open Nautilus |
| `SUPER + L` | Open LocalSend |
| `SUPER + Shift + A` | Open Spotify via `spotify-launcher` |
| `SUPER + Shift + M` | Open the TLauncher mode selector |
| `SUPER + grave` | Open VS Code |
| `Ctrl + Shift + Escape` | Open `btop` in Kitty |
| `SUPER + Alt + Space` | Open the Google search prompt |
| `SUPER + Ctrl + N` | Open a floating quick note |

### Web shortcuts

| Key | Action |
| --- | --- |
| `SUPER + I` | Instagram |
| `SUPER + C` | Google Calendar |
| `SUPER + Shift + F` | Facebook |
| `SUPER + A` | ChatGPT |
| `SUPER + G` | Gmail |
| `SUPER + Y` | YouTube |
| `SUPER + M` | Facebook Messenger |
| `SUPER + N` | Open the anime/movie launcher menu |
| `SUPER + Shift + G` | Personal GitHub profile |
| `SUPER + Shift + K` | Kimi |
| `SUPER + D` | Discord in Firefox |
| `SUPER + Shift + O` | BitSync-Devs GitHub |
| `SUPER + Shift + W` | Router/admin page at `http://192.168.254.254` |
| `SUPER + Shift + T` | Telegram Web |

### Window manager and system controls

| Key | Action |
| --- | --- |
| `SUPER + W` | Kill the active window |
| `SUPER + F` | Toggle fullscreen |
| `SUPER + T` | Toggle floating |
| `SUPER + Escape` | Open the power menu |
| `SUPER + Shift + Escape` | Open the power-profile menu |
| `SUPER + Shift + L` | Lock with `hyprlock` |
| `SUPER + Ctrl + L` | Disable `hypridle` |
| `SUPER + Alt + L` | Enable `hypridle` |
| `SUPER + Z` | Toggle Waybar |
| `SUPER + Ctrl + V` | Pick a clipboard item from `cliphist` through Wofi |
| `SUPER + K` | Show the keybindings viewer |
| `SUPER + Shift + N` | Notify the currently playing Spotify track |
| `SUPER + Shift + Ctrl + Q` | Exit Hyprland |

### Workspaces and navigation

| Key | Action |
| --- | --- |
| `SUPER + 1..0` | Switch to workspace `1..10` |
| `SUPER + Shift + 1..0` | Move the active window to workspace `1..10` |
| `SUPER + Ctrl + Left/Right/Up/Down` | Move focus between tiled windows |
| `SUPER + Ctrl + Shift + Left/Right/Up/Down` | Swap tiled windows |
| `SUPER + mouse wheel` | Cycle workspaces |
| `SUPER + Tab` | Move to the next workspace |
| `Alt + Tab` | Cycle focus backward |

### Floating window and layout controls

| Key | Action |
| --- | --- |
| `SUPER + Shift + Arrow` | Move the active floating window |
| `SUPER + Alt + Arrow` | Resize the active floating window |
| `SUPER + Alt + T` | Toggle pseudo tiling |
| `SUPER + Shift + P` | Pin the active window |
| `SUPER + left mouse button` | Move window |
| `SUPER + right mouse button` | Resize window |

### Brightness, audio, and media

| Key | Action |
| --- | --- |
| `XF86MonBrightnessUp` | Increase brightness by 10% |
| `XF86MonBrightnessDown` | Set brightness to 10% |
| `SUPER + Shift + U` | Increase brightness by 10% |
| `SUPER + Shift + D` | Decrease brightness by 10% |
| `XF86AudioRaiseVolume` | Raise volume by 5% |
| `XF86AudioLowerVolume` | Lower volume by 5% |
| `XF86AudioMute` | Toggle output mute |
| `XF86AudioMicMute` | Toggle microphone mute |
| `XF86AudioPlay` | Play/pause media |
| `XF86AudioNext` | Next track |
| `XF86AudioPrev` | Previous track |
| `SUPER + Up` | Raise volume by 5% |
| `SUPER + Down` | Lower volume by 5% |
| `SUPER + Right` | Toggle output mute |

### Screenshots and recording

| Key | Action |
| --- | --- |
| `SUPER + Shift + S` | Region screenshot through `hyprshot` |
| `Print` | Screenshot the current output |
| `Shift + Print` | Screenshot the active window |
| `SUPER + Alt + S` | Start region recording with audio |
| `SUPER + Ctrl + S` | Start region recording without audio |
| `SUPER + Shift + C` | Stop recording |

## Dependencies

This setup relies on more than Hyprland itself.

### Core Wayland and desktop stack

- `hyprland`
- `hyprlock`
- `hypridle`
- `hyprsunset`
- `waybar`
- `wofi`
- `dunst`
- `swaybg`
- `wl-clipboard`
- `cliphist`

### Capture and media helpers

- `hyprshot`
- `grim`
- `slurp`
- `wf-recorder`
- `playerctl`
- `imagemagick`
- PipeWire with `wpctl`

### Desktop utilities

- `kitty`
- `foot`
- `nautilus`
- `chromium`
- `firefox`
- `brightnessctl`
- `powerprofilesctl` / `power-profiles-daemon`
- `fastfetch`
- `btop`
- `libnotify`
- `nm-applet`
- `blueman-applet`
- `localsend`

### Companion config extras

- `JetBrainsMono Nerd Font`
- `FiraCode Nerd Font`
- `pavucontrol` if you want the included Waybar audio click action
- `gnome-system-monitor` or `htop` if you want the included Waybar sysusage click action
- `gnome-calendar` if you want the included Waybar calendar hover action

### Optional or user-specific tools

- `spotify-launcher`
- `code`
- `ollama`
- `picoclaw`
- `elephant`
- `java`
- `prime-run` or NVIDIA PRIME offload support
- `nwg-displays`
- a `lockfile` utility for `scripts/applauncher.sh`

## Installation

The Hyprland config expects to live at `~/.config/hypr`.

```bash
git clone https://github.com/juswa005/hyprland-files.git ~/.config/hypr
chmod +x ~/.config/hypr/scripts/*
```

If you also want the bundled companion configs, copy them into their usual config locations:

```bash
mkdir -p ~/.config/waybar ~/.config/kitty ~/.config/dunst
cp ~/.config/hypr/others/waybar/2.jsonc ~/.config/waybar/config.jsonc
cp ~/.config/hypr/others/waybar/style.css ~/.config/waybar/style.css
cp -r ~/.config/hypr/others/waybar/scripts ~/.config/waybar/
cp ~/.config/hypr/others/dunst/dunstrc ~/.config/dunst/dunstrc
cp -r ~/.config/hypr/others/kitty/* ~/.config/kitty/
```

Before logging in, review the user-specific paths and commands:

- replace `/home/amiel/.config/hypr/...` in `binds.conf` and `autostart.conf`
- review `~/Games/tl.jar` in `scripts/tlauncher-launcher.sh`
- review `~/Notes` in `scripts/quick-note.sh`
- review `~/Videos/Recordings` in `scripts/screenrecord.sh`
- review `~/Pictures/Screenshots` in the screenshot binds and `scripts/shot-area`

If you do not use some personal tools, comment them out or remove their binds:

- `elephant`
- `ollama`
- `picoclaw`
- TLauncher / Java / NVIDIA launch modes
- Spotify or LocalSend keybinds if those apps are absent

## Notes and Caveats

- `binds.conf` defines `$clipboard = /home/amiel/.config/hypr/scripts/clipboard.sh`, but there is no matching `scripts/clipboard.sh` in this repository and that variable is not used by any bind.
- `scripts/preview-clipboard.sh` exists, but the current clipboard bind uses `cliphist` inline instead of that script.
- `scripts/shot-area` exists, but screenshots are currently handled by `hyprshot` binds instead.
- `scripts/yt-dlp` is bundled in the repo but not called from the Hyprland config.
- `scripts/bin` is currently an empty file.
- the comment above `SUPER + Ctrl + N` still says `wallpaper selector`, but the bind actually launches the quick-note script.
- `autostart.conf` is UTF-8 with BOM, while most other files are plain text without it.
- `others/waybar/config.jsonc` is not the current Waybar config even though the filename suggests it is. The active bar config in this repo is `others/waybar/2.jsonc`.

## Suggested First Edits

1. Fix all `/home/amiel/...` paths.
2. Update `monitors.conf` and `workspaces.conf` for your displays.
3. Copy the `others/` configs you actually want to use.
4. Remove or comment out apps you do not have installed.
5. Pick your wallpaper and update both `autostart.conf` and `hyprlock.conf`.
6. Test launcher, clipboard, screenshot, recording, Waybar, and lockscreen flows one by one.
