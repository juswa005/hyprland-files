#!/usr/bin/env bash
# EndeavourOS Hyprland setup installer
# This script installs all dependencies required for the Hyprland setup.

set -e

# Replace with your actual username and repository
REPO_URL="https://github.com/YOUR_USERNAME/YOUR_REPO.git"
CLONE_DIR="$HOME/hyprland-files-clone"

echo "========================================="
echo " Starting Hyprland Setup Installer"
echo "========================================="

echo "[1/4] Updating system..."
sudo pacman -Syu --noconfirm

echo "[2/4] Installing dependencies..."

# Core packages available in standard repos
CORE_PKGS=(
    "hyprland"
    "kitty"
    "git"
    "stow"
    "wl-clipboard"
    "cliphist"
    "waybar"
    "dunst"
    "swaybg"
    "network-manager-applet"
    "blueman"
    "hyprlock"
    "hypridle"
    "brightnessctl"
    "wireplumber"
    "playerctl"
    "zsh"
    "fastfetch"
    "btop"
    "foot"
    "nautilus"
    "firefox"
    "code"
    "grim"
    "slurp"
    "tesseract"
    "tesseract-data-eng"
    "imagemagick"
    "rsync"
    "inotify-tools"
    "wtype"
    "libnotify"
    "jre-openjdk"
    "power-profiles-daemon"
)

# Packages that might be in the AUR
AUR_PKGS=(
    "helium-browser-bin"
    "hypremoji-git"
    "localsend-bin"
    "spotify"
    "hyprshot"
    "hyprsunset-git"
    "ollama"
    "elephant"
    "picoclaw-bin"
    "gpu-screen-recorder-git"
)

# Install Core packages using pacman
for pkg in "${CORE_PKGS[@]}"; do
    if ! pacman -Qi "$pkg" &>/dev/null; then
        echo "Installing $pkg..."
        sudo pacman -S --noconfirm --needed "$pkg" || echo "Warning: Failed to install $pkg from standard repos."
    else
        echo "$pkg is already installed."
    fi
done

# Check for yay (AUR Helper)
if ! command -v yay &> /dev/null; then
    echo "Installing yay (AUR Helper)..."
    sudo pacman -S --needed --noconfirm base-devel git
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    cd -
    rm -rf /tmp/yay
fi

# Install AUR packages using yay
for pkg in "${AUR_PKGS[@]}"; do
    if ! yay -Qi "$pkg" &>/dev/null; then
        echo "Installing $pkg from AUR..."
        yay -S --noconfirm --needed "$pkg" || echo "Warning: Failed to install $pkg from AUR."
    else
        echo "$pkg is already installed."
    fi
done

echo "[3/4] Fetching configuration files..."

if [ -d "$CLONE_DIR" ]; then
    echo "Directory $CLONE_DIR already exists. Pulling latest changes..."
    cd "$CLONE_DIR"
    git pull
else
    echo "Cloning repository..."
    git clone "$REPO_URL" "$CLONE_DIR"
    cd "$CLONE_DIR"
fi

echo "[4/4] Setting up configuration..."

HYPR_CONFIG_DIR="$HOME/.config/hypr"
if [ -d "$HYPR_CONFIG_DIR" ] && [ ! -L "$HYPR_CONFIG_DIR" ]; then
    BACKUP_DIR="$HOME/.config/hypr_backup_$(date +%Y%m%d_%H%M%S)"
    echo "Backing up existing Hyprland configuration to $BACKUP_DIR"
    mv "$HYPR_CONFIG_DIR" "$BACKUP_DIR"
fi

# Ensure ~/.config exists
mkdir -p "$HOME/.config"

# Symlink the hyprland configuration
# Depending on repository structure, adjust the target
if [ -d "$CLONE_DIR/hypr" ]; then
    ln -sfn "$CLONE_DIR/hypr" "$HYPR_CONFIG_DIR"
else
    # Fallback: symlink the entire clone directory as hypr config directory
    ln -sfn "$CLONE_DIR" "$HYPR_CONFIG_DIR"
fi

# Setup other app configurations (from the 'others' folder)
if [ -d "$CLONE_DIR/others" ]; then
    echo "Setting up other app configurations..."
    for app_dir in "$CLONE_DIR/others"/*; do
        if [ -d "$app_dir" ]; then
            app_name=$(basename "$app_dir")
            target_dir="$HOME/.config/$app_name"
            
            if [ -d "$target_dir" ] && [ ! -L "$target_dir" ]; then
                BACKUP_APP_DIR="${target_dir}_backup_$(date +%Y%m%d_%H%M%S)"
                echo "Backing up existing $app_name configuration to $BACKUP_APP_DIR..."
                mv "$target_dir" "$BACKUP_APP_DIR"
            fi
            
            echo "Symlinking $app_name configuration..."
            ln -sfn "$app_dir" "$target_dir"
        fi
    done
fi


echo "========================================="
echo " Installation Complete!"
echo " Please log out and select Hyprland."
echo "========================================="
