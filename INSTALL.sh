#!/usr/bin/env bash

set -e

# Debug Log
REPO_ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

LOG_FILE="$REPO_ROOT/install-log.txt"
exec > >(tee -a "$LOG_FILE") 2>&1

# Wrapper Configuration
BLUE='\033[0;34m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m'
SPIN='|/-\'

# Packages
CORE_PACKAGES=(
  "base-devel"
  "rustup"
  "github-cli"
  "stow"
  "pamixer"
  "brightnessctl"
  "playerctl"
  "ncspot"
  "rofi-wayland"
  "hyprlock"
  "hypridle"
  "hyprpaper"
  "yazi"
  "neovim"
  "bottom"
  "networkmanager"
  "zsh"
  "imagemagick"
  "acpi"
  "pavucontrol"
  "lua51"
  "lua51-luarocks"
  "xdg-desktop-portal-hyprland"
  "xdg-desktop-portal-gtk"
  "gtk4"
  "gtk3"
  "qt6ct"
  "kvantum"
  "noto-fonts"
  "go"
  "matugen"
  "hyprsunset"
  "fastfetch"
  "cava"
  "ttf-iosevka"
  "ttf-nerd-fonts-symbols-mono"
  "gvfs"
  "dbus"
  "libdbusmenu-glib"
  "libdbusmenu-gtk3"
  "gtk-layer-shell"
  "zoxide"
  "eza"
  "fzf"
  "thefuck"
  "jq"
  "socat"
  "tmux"
  "nvm"
  "btop"
  "hyprshot"
  "bluez"
  "bluez-utils"
  "bluez-obex"
  "bluetuith"
  "python-gobject"
  "zsh-theme-powerlevel10k"
)


# Helper Function
keep_sudo_alive() {
    while true; do
        sudo -n -v 2>/dev/null
        sleep 60
    done &
    SUDO_PID=$!
}

cleanup() {
    if [ -n "$SUDO_PID" ]; then
        kill "$SUDO_PID" 2>/dev/null
    fi
}

trap cleanup EXIT

# Executor
# Usage: execute "Task Name" "Command" [allow_retry]
execute() {
    local task_name=$1
    local cmd=$2
    local allow_retry=${3:-false}
    local attempt=1
    local SPIN='|/-\'

    echo -e "${BLUE}================================================================${NC}"
    echo -e "${CYAN}  TASK: $task_name${NC}"
    echo -e "${BLUE}================================================================${NC}"

    while true; do
        eval "$cmd" >> install-log.txt 2>&1 &
        local pid=$!
        while kill -0 $pid 2>/dev/null; do
            for i in {0..3}; do
                printf "\r${GREEN}  [%c] Working... (Attempt $attempt)${NC}" "${SPIN:$i:1}"
                sleep 0.1
            done
        done
        wait $pid
        local res=$?

        if [ $res -eq 0 ]; then
            printf "\r${GREEN}  [OK] Completed!                                     ${NC}\n\n"
            break
        else
            if [ "$allow_retry" = true ] && [ $attempt -lt 3 ]; then
                printf "\r${RED}  [!] Failed. Retrying in 5s...                      ${NC}"
                ((attempt++))
                sleep 5
            else
                printf "\r${RED}  [FATAL] Task '$task_name' failed. See install-log.txt${NC}\n"
                exit 1
            fi
        fi
    done
}

install_pkgs() {
    local pkgs=("$@")
    local to_install=()

    for pkg in "${pkgs[@]}"; do
        if ! pacman -Qq | grep -qwE "^($pkg|$pkg-git|$pkg-bin)$"; then
            to_install+=("$pkg")
        fi
    done

    if [ ${#to_install[@]} -gt 0 ]; then
	execute "Installing Repo Packages" "sudo pacman -S --noconfirm --needed ${to_install[*]}" true
    else
        echo -e "${YELLOW}  [SKIP] All packages are already present.${NC}"
    fi
}

is_symlink_to_repo() {
    local target="$1"
    if [ -L "$target" ]; then
        local link_target
        link_target=$(readlink -f "$target")
        if [[ "$link_target" == "$REPO_ROOT"* ]]; then
            return 0
        fi
    fi
    return 1
}

# Installation Functions
backup_configs() {
  echo -e "${CYAN}[INTERNAL TASK] Checking for pre-existing configurations to back up...${NC}"
  local TS
  TS=$(date +%Y%m%d_%H%M%S)
  local BACKUP_DIR="$HOME/.zenities_backups/backup_$TS"
  local CONFIG_DIR="$HOME/.config"
  local DOTFILES_CONFIG="$REPO_ROOT/.config"
  local has_backups=false

  if [ -d "$DOTFILES_CONFIG" ]; then
    for dir in "$DOTFILES_CONFIG"/*/; do
      local folder_name
      folder_name=$(basename "$dir")
      local target_path="$CONFIG_DIR/$folder_name"
      if [ -d "$target_path" ]; then
        if is_symlink_to_repo "$target_path"; then
          continue
        fi
        mkdir -p "$BACKUP_DIR"
        echo "Backing up: $folder_name"
        mv "$target_path" "$BACKUP_DIR/"
        has_backups=true
      fi
    done
  fi

  local ITEMS=(.zshrc .zshenv .tmux.conf .p10k.zsh wallpapers scripts screenshots)
  for item in "${ITEMS[@]}"; do
    local target_path="$HOME/$item"
    if [ -e "$target_path" ]; then
      if is_symlink_to_repo "$target_path"; then
        continue
      fi
      mkdir -p "$BACKUP_DIR"
      echo "Backing up: $item"
      mv "$target_path" "$BACKUP_DIR/"
      has_backups=true
    fi
  done
  
  if [ "$has_backups" = true ]; then
    echo -e "${GREEN}[OK] Backup completed successfully. Pre-existing configs moved to $BACKUP_DIR.${NC}\n"
  else
    echo -e "${GREEN}[OK] No pre-existing configs to back up.${NC}\n"
  fi
}

apply_dotfiles() {
  echo -e "${CYAN}[INTERNAL TASK] Applying dotfiles via Stow...${NC}"
  cd "$REPO_ROOT" || exit 1
  stow .
  cd "$HOME" || exit 1
  echo -e "${GREEN}[OK] Dotfiles applied.${NC}\n"
}

install_eww() {
    if command -v eww >/dev/null; then
        echo "Eww is already installed. Skipping build..."
        return 0
    fi

    execute "Cloning Eww Repository" 'cd "$HOME" && [ -d eww ] && rm -rf eww; git clone https://github.com/elkowar/eww' true

    execute "Compiling Eww (Cargo Build)" 'cd "$HOME/eww" && cargo build --release --no-default-features --features=wayland'

    execute "Installing Eww Binary" 'sudo cp "$HOME/eww/target/release/eww" /usr/local/bin/ && sudo chmod +x /usr/local/bin/eww'

    execute "Cleaning up Eww source" 'cd "$HOME" && rm -rf eww'
}

setup_scripts() {
    execute "Executing Hyprland Setup" "bash ${REPO_ROOT}/.scripts/setup/hypr.sh"

    execute "Executing Zsh Configuration" "bash ${REPO_ROOT}/scripts/zsh_setup.sh"

    execute "Normalizing Wallpapers" "bash ${REPO_ROOT}/scripts/normalize_wallpaper.sh"
}

setup_network() {
    execute "Disabling systemd-resolved to prevent conflicts" "sudo systemctl disable --now systemd-resolved 2>/dev/null || true"
    
    execute "Cleaning stale resolv.conf" "if [ -L /etc/resolv.conf ] && readlink /etc/resolv.conf | grep -q 'resolved'; then sudo rm -f /etc/resolv.conf; fi"
    
    execute "Enabling NetworkManager" "sudo systemctl enable --now NetworkManager"
}

setup_bluetooth() {
    execute "Enabling & Starting Bluetooth Service" "sudo systemctl enable --now bluetooth.service"

    execute "Configuring Bluetooth Audio modules" "sudo pactl load-module module-bluetooth-discover 2>/dev/null || true"
}

setup_shell() {
    execute "Adding Zsh to Valid Shells" "if ! grep -q '/usr/bin/zsh' /etc/shells; then echo '/usr/bin/zsh' | sudo tee -a /etc/shells; fi"
    
    execute "Changing Default Shell to Zsh" "if [ \"\$(getent passwd \$USER | cut -d: -f7)\" != '/usr/bin/zsh' ]; then sudo chsh -s /usr/bin/zsh \$USER; fi"
}

# Password Initialization for Sudo
clear
echo "         • •"
echo "    ┓┏┓┏┓┓╋┓┏┓┏"
echo "    ┗┗ ┛┗┗┗┗┗ ┛"
echo -e "${NC}"

if ! sudo -v; then
    echo -e "${RED}[ERROR] Sudo authentication failed.${NC}"
    exit 1
fi

keep_sudo_alive

# Install necessary packages via pacman
execute "System Update" "sudo pacman -Syu --noconfirm" true
install_pkgs "${CORE_PACKAGES[@]}"

# Install Rust toolchain
execute "Setting up Rust Toolchain" "rustup default stable" true

# Backup Existing Config
backup_configs

# Apply Zenities Dotfiles
apply_dotfiles

# Eww installation
install_eww

# Run Configuration Scripts
setup_scripts

# Network Manager setup
setup_network

# Bluetooth Setup
setup_bluetooth

# Change shell to zsh
setup_shell

#Run Wallpaper and Color Initialization
if [ "$GITHUB_ACTIONS" != "true" ]; then
    execute "Initializing Wallpaper & Colors" 'bash "$HOME/.config/eww/scripts/change-wallpaper.sh 7 -g"'
fi

if [ "$GITHUB_ACTIONS" = "true" ]; then
    echo -e "${YELLOW}Detected GitHub Actions environment.${NC}"
    echo -e "${GREEN}CI Test successful. Skipping system reboot.${NC}"
    # Exit dengan status 0 untuk menandakan sukses di pipeline
    exit 0
else
    echo -e "${CYAN}The system will reboot in 5 seconds to apply all changes.${NC}"
    echo -e "${YELLOW}Make sure to save any unsaved work in other windows.${NC}"
    
    for i in {5..1}; do
        printf "\rRebooting in %d... " "$i"
        sleep 1
    done
    echo -e "\n${GREEN}Rebooting now...${NC}"
    
    sudo reboot
fi
