# Hyprland Config

This repository contains the live `~/.config/hypr` directory for a modular Hyprland setup. Recently migrated to **Hyprland's new Lua API**, the config is split into small Lua modules, while most key behavior is driven by shell helpers in `scripts/`. App configs are mirrored under `others/` and are automatically symlinked during installation.

It is usable as a starting point, but it is not a drop-in "works everywhere" preset. Several bindings and autostart entries are personal and should be reviewed before first launch.

## What You Are Getting

- **Fully Automated Installer**: An `install.sh` script to set up everything on EndeavourOS.
- **Lua-Based Configuration**: Main Hyprland setup translated into `hl.*` Lua functions.
- Dwindle layout with small gaps, thin borders, and animations disabled.
- Separate modular `.lua` files for bindings, inputs, autostart, window rules, etc.
- Wofi-based launchers for apps, clipboard history, emoji, search, power menu, and cheatsheets.
- Region OCR, screenshots, and GPU-based screen recording helpers.
- Mirrored configs for Waybar, Kitty, and Dunst under `others/` that are automatically symlinked.
- Wallpaper and terminal art assets bundled in `wallpapers/` and `ff_logo/`.

## Live vs Non-Live Files

The main entrypoint is `init.lua`. It currently `require()`s:

- `binds`
- `inputs`
- `windows`
- `autostart`
- `windowrules`
- `monitors`
- `workspaces`

It also dynamically sources `hyprsunset.conf` and `~/.config/hypremoji/hypremoji.conf`.

Important notes:

- `hyprlock.conf`, `hypridle.conf`, and `hyprsunset.conf` remain in the traditional `.conf` format as those standalone tools do not currently support Lua. They are still live and actively used.
- `monitors.lua` and `workspaces.lua` were ported to Lua.
- `old-conf/` contains the deprecated `.conf` files prior to the Lua migration. They are kept for reference but are no longer active.

## Repository Layout

```text
.
├── init.lua                     # Main Hyprland entrypoint (replaces hyprland.conf)
├── binds.lua                    # Keybindings and helper script paths
├── inputs.lua                   # Keyboard, mouse, touchpad settings
├── windows.lua                  # Workspace declarations
├── windowrules.lua              # Float/size rules for selected apps
├── autostart.lua                # Session startup commands
├── monitors.lua                 # Monitor configurations
├── workspaces.lua               # Workspace rules
├── hyprsunset.conf              # Night light schedule
├── hyprlock.conf                # Lock screen appearance
├── hypridle.conf                # Idle timeout -> lock
├── install.sh                   # Automated installer script for EndeavourOS
├── scripts/                     # Launchers, toggles, capture, sync helpers
├── others/                      # Mirrored Waybar / Kitty / Dunst configs
├── wallpapers/                  # Wallpaper assets
├── ff_logo/                     # Optional terminal art assets
└── old-conf/                    # Deprecated .conf files prior to Lua migration
```

## Current Behavior

### `init.lua`

- Uses the `dwindle` layout
- Sets `gaps_in = 1`, `gaps_out = 2`, `border_size = 1`
- Disables animations
- Enables `xwayland { force_zero_scaling = true }`
- Sources external non-Lua configs (Hypremoji and hyprsunset)

### `autostart.lua`

The session currently starts:

- `nm-applet` & `blueman-applet`
- `waybar`
- `elephant`
- `swaybg` with `wallpapers/jap2.jpg`
- `dunst`
- `hyprsunset`
- `wl-paste` watchers for `cliphist` text and image history
- `ollama` via `systemctl --user start ollama || ollama serve`
- `hypridle`
- `scripts/sync-others.sh watch`
- `foot -e sh -c 'picoclaw agent 2>/dev/null'`

If any of those commands do not exist on your machine, remove or replace the line before using the config.

### `inputs.lua`

- Keyboard layout is `us`
- `follow_mouse = 1`
- Touchpad natural scroll and tap-to-click are enabled
- An external keyboard workflow option (`kb_options = altwin:swap_alt_win`) is available to uncomment.
- `scripts/keyboard-mode-toggle.sh` toggles that line and then reloads Hyprland.

### `windows.lua`

- Declares workspaces `1` through `10`

### `windowrules.lua`

Rules currently float and size:

- `wofi`
- `org.gnome.Calculator`
- `io.github.kaii_lb.Overskride`

### `hypridle.conf`

- Locks the session with `hyprlock` after 300 seconds

### `hyprlock.conf`

- Uses `wallpapers/jap2.jpg`
- Applies blur and a centered password field
- Shows time, date, username, and failure status
- Assumes `JetBrainsMono Nerd Font` is installed

### `hyprsunset.conf`

- Enabled
- Manual schedule with `sunrise = 06:00` and `sunset = 18:00`
- Night temperature set to `4000`

### `monitors.lua` and `workspaces.lua`

- The current repo snapshot expects monitors named `eDP-1` and `HDMI-A-1`
- The current workspace mapping is machine-specific and should be adjusted for your own setup

## Dependencies

This setup assumes a Wayland/Hyprland desktop with a fairly opinionated toolchain. Most of these will be handled by `install.sh`.

### Core session

- `hyprland`, `hyprlock`, `hypridle`, `hyprsunset`
- `kitty`, `foot`, `waybar`, `wofi`, `dunst`, `swaybg`
- `chromium`, `firefox`, `nautilus`
- `nm-applet`, `blueman-applet`
- `wl-copy`, `wl-paste`, `cliphist`
- `wpctl`, `brightnessctl`, `playerctl`, `powerprofilesctl`

### Script helpers

- `grim`, `slurp`, `hyprshot`, `gpu-screen-recorder`
- `tesseract`, `magick`
- `rsync`, `inotifywait`, `flock`, `lockfile`, `wtype`

### Optional apps referenced by bindings or startup

- `hypremoji` and a valid `~/.config/hypremoji/hypremoji.conf`
- `spotify`, `localsend`, `code`, `btop`, `fastfetch`, `nvtop`
- `pulsemixer`, `wifitui`, `ollama`, `picoclaw`, `elephant`
- `java` for TLauncher

### Fonts

Install at least these fonts if you want the setup to look right:
- `JetBrainsMono Nerd Font`
- `FiraCode Nerd Font`
- `Symbols Nerd Font`

## Installation

### 1. Run the Automated Installer

You no longer need to install dependencies or link folders manually! Just download and run the included `install.sh` script on your EndeavourOS machine:

```bash
git clone https://github.com/juswa005/dotfiles.git ~/hyprland-files-clone
cd ~/hyprland-files-clone
chmod +x install.sh
./install.sh
```

**The script will:**
- Update your system via `pacman`.
- Install all core dependencies via `pacman` and AUR tools via `yay` (installing `yay` if missing).
- Safely backup your existing `~/.config/hypr` and any app configs located in `others/` (e.g., `dunst`, `kitty`, `waybar`).
- Symlink the repository to `~/.config/hypr`.
- Symlink the `others/` directories directly into your `~/.config/` folder.

### 2. Review the machine-specific and personal values

Before launching the config, check these files and change anything that is personal to the original machine:

- `autostart.lua`
  - remove or replace `elephant` and `picoclaw`
  - change the wallpaper path if you do not want `wallpapers/jap2.jpg`
  - remove `ollama` startup if unused
- `init.lua`
  - comment out `hl.source("~/.config/hypremoji/hypremoji.conf")` if you do not use Hypremoji
- `binds.lua`
  - review all personal URLs opened by the webapp shortcuts
  - replace `chromium` profile names if yours differ
  - replace the LAN IP shortcuts if they are meaningless on your network
  - remove bindings you do not use
- `monitors.lua` and `workspaces.lua`
  - modify them for your specific monitor layout

### 3. Reload Hyprland

```bash
hyprctl reload
```

## Keybindings

This repo has a lot of bindings. The full source of truth is `binds.lua`. These are the main ones.

### Apps and launchers

- `SUPER + Return` -> Kitty
- `SUPER + Shift + Return` -> Kitty running `fastfetch`
- `SUPER + Space` -> app launcher
- `SUPER + E` -> Nautilus
- `SUPER + Shift + E` -> Hypremoji
- `SUPER + B` -> Chromium default profile
- `SUPER + Shift + B` -> Chromium "Profile 2"
- `SUPER + Shift + M` -> TLauncher menu
- `SUPER + L` -> LocalSend
- `SUPER + Shift + A` -> Spotify
- `SUPER + ~` -> VS Code

### Personal web shortcuts

Several `SUPER + <key>` bindings launch hardcoded web apps or URLs in Chromium or Firefox, including:

- ChatGPT
- Gmail
- YouTube
- Instagram
- Facebook / Messenger
- Google Calendar
- Discord
- GitHub profiles
- a local router page
- a LAN dashboard

Review and replace these in `binds.lua` before using the config on another machine.

### System controls

- `SUPER + Escape` -> power menu
- `SUPER + Shift + Escape` -> power profile selector
- `SUPER + Shift + L` -> lock screen
- `SUPER + Ctrl + L` -> disable `hypridle`
- `SUPER + Alt + L` -> enable `hypridle`
- `SUPER + Z` -> toggle Waybar
- `SUPER + Ctrl + V` -> clipboard history picker
- `SUPER + Ctrl + K` -> toggle the keyboard mode line in `inputs.lua`
- `SUPER + K` -> keybind viewer
- `SUPER + H` -> tmux cheatsheet
- `SUPER + Shift + H` -> Neovim cheatsheet
- `SUPER + Shift + N` -> show current Spotify track
- `SUPER + Ctrl + N` -> open a floating quick note in `~/Notes`

### Screenshots, OCR, and recording

- `SUPER + Shift + S` -> region screenshot via `hyprshot`
- `Print` -> full output screenshot
- `Shift + Print` -> active window screenshot
- `SUPER + Alt + S` -> start region recording with desktop audio
- `SUPER + Ctrl + S` -> start region recording without audio
- `SUPER + Shift + C` -> stop recording
- `SUPER + Shift + T` -> OCR a selected region and copy the detected text

### Workspaces and windows

- `SUPER + 1..0` -> switch workspace `1..10`
- `SUPER + Shift + 1..0` -> move active window to workspace `1..10`
- `SUPER + T` -> toggle floating
- `SUPER + Ctrl + Arrow` -> move focus
- `SUPER + Ctrl + Shift + Arrow` -> swap tiled windows
- `SUPER + Shift + Arrow` -> move floating windows
- `SUPER + Alt + Arrow` -> resize floating windows
- `ALT + Tab` -> cycle focus

### Hardware and media keys

- `XF86MonBrightnessUp` / `XF86MonBrightnessDown`
- `XF86AudioRaiseVolume` / `XF86AudioLowerVolume` / `XF86AudioMute`
- `XF86AudioMicMute`
- `XF86AudioPlay` / `XF86AudioNext` / `XF86AudioPrev`

## Helper Scripts

All custom helpers live in `scripts/`.

| Script | Purpose | Notes |
| --- | --- | --- |
| `applauncher.sh` | Opens Wofi app launcher | Uses `lockfile` for debouncing |
| `anime-movies.sh` | Menu for opening anime/movie sites | Hardcoded URLs |
| `clipboard.sh` | Clipboard history picker | Requires `cliphist`, `wofi`, `wl-copy` |
| `emoji-picker.sh` | Emoji picker and optional typed insertion | Uses `wtype` if available |
| `hypr-binds.sh` | Shows bindings from `binds.lua` in Wofi | Good quick reference |
| `hypridle-toggle.sh` | Starts or stops `hypridle` | Sends desktop notifications |
| `keyboard-mode-toggle.sh` | Comments/uncomments `kb_options = altwin:swap_alt_win` | Runs `hyprctl reload` |
| `launch-webapp.sh` | Opens a URL in Chromium app mode | Used by multiple keybinds |
| `notify-spotify.sh` | Shows current Spotify track | Silent when Spotify is not playing |
| `nvim-cheatsheet.sh` | Neovim cheatsheet picker | Read-only helper |
| `ocr-area.sh` | OCR for a selected screen region | Requires `grim`, `slurp`, `tesseract`, `wl-copy` |
| `powermenu.sh` | Shutdown / reboot menu | Uses `systemctl` |
| `powermode.sh` | Power profile menu | Requires `powerprofilesctl` |
| `preview-clipboard.sh` | Decodes clipboard entries for preview | Uses `magick` for image thumbnails |
| `quick-note.sh` | Opens a dated note in a floating Kitty + Neovim window | Writes to `$HOME/Notes` |
| `screenrecord.sh` | Region recorder with optional desktop audio | Uses `gpu-screen-recorder` |
| `search.sh` | Google search prompt in app mode Chromium | Hardcoded to Google |
| `shot-area` | Region screenshot helper | Separate from the `hyprshot` bindings |
| `sync-others.sh` | Mirrors `~/.config/{waybar,kitty,dunst}` into `others/` | Starts in watch mode at login |
| `tlauncher-launcher.sh` | TLauncher mode picker | Assumes `~/Games/tl.jar` |
| `tmux-cheatsheet.sh` | tmux cheatsheet picker | Read-only helper |
| `waybar-toggle.sh` | Starts or kills Waybar | Launches bare `waybar` |

## Mirrored App Configs in `others/`

These configurations are automatically symlinked to your `~/.config/` folder when you run `install.sh`. 

### `others/waybar`

- `config.jsonc` is the main mirrored Waybar config
- `style.css` is the main mirrored stylesheet
- `2.jsonc` is an alternate Waybar layout
- `backups/` contains older Waybar config/style snapshots
- `scripts/sysusage.sh` is a simple CPU/RAM script used by the alternate layout

The main mirrored Waybar setup expects click handlers for tools such as `fastfetch`, `nvtop`, `btop`, `pulsemixer`, `wifitui`, and `sigye`.

### `others/kitty`

- `kitty.conf` is a black-and-white leaning main config with transparency
- `colors.conf` contains a Tokyo Night palette
- `Kanagawa.conf` is a full alternate theme
- `kitty.conf.bak` is an older minimalist Kitty config
- `current-theme.conf` and `Default.conf` are stock/default theme references

### `others/dunst`

- `dunstrc` defines a monochrome notification look using JetBrainsMono

## Assets

- `wallpapers/jap2.jpg` is used by both `autostart.lua` and `hyprlock.conf`
- `wallpapers/` contains additional wallpapers you can swap in manually
- `ff_logo/` contains PNG art plus `frieren.txt`, which looks like ANSI/terminal art for tools such as Fastfetch

## Known Caveats

- The config is personalized. Some bindings open personal sites, LAN addresses, or apps that may not exist on your machine.
- `sync-others.sh watch` continuously mirrors your real `~/.config/waybar`, `~/.config/kitty`, and `~/.config/dunst` into this repo. If you do not want that behavior, remove the autostart line in `autostart.lua`.
- `waybar` is launched without a `-c` or `-s` path, so Waybar will use whatever config is installed in your real `~/.config/waybar`.
- `hyprland.conf` was migrated to `init.lua`, but `hyprsunset.conf` is still sourced explicitly as it's a standalone config file.
- `quick-note.sh` creates files in `$HOME/Notes`.

## Adapting It For Your Own Machine

If you want to reuse this setup cleanly:

1. Run the `install.sh` script to set up everything automatically.
2. Get the core session stable first: `init.lua`, `binds.lua`, `inputs.lua`, `autostart.lua`.
3. Remove personal app bindings and hardcoded URLs next.
4. Regenerate monitors/workspaces with `nwg-displays` if needed, and adapt them into `monitors.lua` and `workspaces.lua`.
5. Only keep startup services you actually use.

## Verification

There is no build, lint, or test runner in this repo. Verification is manual:

- run `hyprctl reload` after editing config files
- use `bash -n scripts/<name>.sh` when changing shell helpers
- exercise the relevant keybinding in a live Hyprland session
