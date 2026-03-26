#!/bin/bash

exec > >(tee -a install-log.txt) 2>&1

# Hearder Configuuration
BLUE='\033[0;34m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

header() {
    echo -e "${BLUE}================================================================${NC}"
    echo -e "${CYAN}TASK: $1${NC}"
    echo -e "${BLUE}================================================================${NC}"
    echo -e "${NC}\n"
}

# Password Initialization for Sudo
clear
echo "         • •"
echo "    ┓┏┓┏┓┓╋┓┏┓┏"
echo "    ┗┗ ┛┗┗┗┗┗ ┛"
echo -e "${NC}"

while true; do
    echo -n "Input sudo password: "
    read -s MY_PASS
    echo ""

    # Cek apakah password valid dengan mencoba command sudo sederhana (sudo -k untuk reset timestamp)
    if echo "$MY_PASS" | sudo -S -k -v > /dev/null 2>&1; then
        echo -e "${GREEN}[ OK ] Password confirmed. Deployment started...${NC}\n"
        break
    else
        echo -e "${RED}[ ERROR ] Wrong password! Please try again.${NC}"
    fi
done

run_sudo() {
  echo "$PASSWORD" | sudo -S $@
}

# Install necessary packages via pacman
cd $HOME
header "Syncing mirror & Installing base packages"
run_sudo pacman -Syu --needed --noconfirm base-devel rustup github-cli stow pamixer brightnessctl playerctl ncspot rofi-wayland hyprlock hypridle hyprpaper yazi neovim bottom networkmanager rustup zsh imagemagick acpi pavucontrol lua51 lua51-luarocks xdg-desktop-portal-hyprland xdg-desktop-portal-gtk gtk4 gtk3 qt6ct kvantum noto-fonts matugen

# Install Rust toolchain
header "Setting up Rust Toolchain"
rustup default stable

# Backup Existing Config
header "Backing up existing Configurations"
CONFIG_DIR="$HOME/.config"
DOTFILES_CONFIG="$HOME/zenities/.config"
BACKUP_SUFFIX=".bak"

echo "Backing up configuration directories in $CONFIG_DIR based on dotfiles in $DOTFILES_CONFIG"
# Change to the .config folder
cd "$CONFIG_DIR" || { echo "Could not access $CONFIG_DIR"; exit 1; }

# Loop over every directory in the dotfiles repo
for dir in "$DOTFILES_CONFIG"/*/; do
  folder_name=$(basename "$dir")
  if [ -d "$CONFIG_DIR/$folder_name" ]; then
    echo "Backing up directory: $folder_name"
    mv "$CONFIG_DIR/$folder_name" "$CONFIG_DIR/${folder_name}${BACKUP_SUFFIX}"
  else
    echo "Directory $folder_name not found in $CONFIG_DIR; skipping backup"
  fi
done

FILES=(.zshrc .zshenv .tmux.conf .p10k.zsh wallpapers scripts screenshots)

for file in "${FILES[@]}"; do
  if [ -f "$HOME/$file" ]; then
    echo "Backing up file: $file"
    mv "$HOME/$file" "$HOME/${file}${BACKUP_SUFFIX}"
  else
    echo "File $file not found; skipping backup"
  fi
done

header "Applying zenities dotfiles via Stow"
cd "$HOME/zenities" || { echo "Could not access $HOME/zenities"; exit 1; }
stow .

# Go back to home directory
cd $HOME

header "Installing yay (AUR Helper)"
# Install yay (AUR helper)
if ! command -v yay >/dev/null; then
  git clone https://aur.archlinux.org/yay.git
  cd yay
  
  makepkg -s --noconfirm
fi 

# Install additional packages via yay
header "Installing AUR Packages"
yay -S --needed --noconfirm fastfetch cmatrix cava ttf-iosevka otf-hermit-nerd gvfs dbus libdbusmenu-glib libdbusmenu-gtk3 gtk-layer-shell brave-bin zoxide eza fzf thefuck jq socat tmux nvm btop hyprshot bluez bluez-utils bluez-obex bluetuith python-gobject zsh-theme-powerlevel10k-git

# Eww installation
header "Building EWW (Elkowar's Wacky Widgets"
cd $HOME

git clone https://github.com/elkowar/eww
cd eww
cargo build --release --no-default-features --features=wayland
cd target/release
chmod +x ./eww
run_sudo cp ./eww /usr/local/bin/

header "Running cconfiguration scripts"
# Run hypr-setup script
bash $HOME/scripts/hypr_setup.sh

# Run zsh-setup script
bash $HOME/scripts/zsh_setup.sh

# Run normalize wallpaper script for wallpaper selector preview
bash $HOME/scripts/normalize_wallpaper.sh

header "Configuring Network & DNS"
# Network Manager setup
run_sudo systemctl disable --now systemd-resolved 2>/dev/null
run_sudo systemctl disable systemd-networkd

run_sudo rm -f /etc/resolv.conf

echo "nameserver 8.8.8.8" | run_sudo tee /etc/resolv.conf
echo "nameserver 1.1.1.1" | run_sudo tee -a /etc/resolv.conf

run_sudo chattr +i /etc/resolv.conf 

run_sudo systemctl enable --now NetworkManager

header "Finalizing Services"
# Bluetooth Setup
run_sudo systemctl enable bluetooth.service
run_sudo systemctl start bluetooth.service

# Change shell to zsh

if ! grep -q "/usr/bin/zsh" /etc/shells; then
    echo "/usr/bin/zsh" | run_sudo tee -a /etc/shells
fi

run_sudo chsh -s /usr/bin/zsh $USER

header "Initializing Wallpaper & Colors"
#Run Wallpaper and Color Initialization
bash $HOME/.config/eww/scripts/change-wallpaper.sh 7 

# Reboot the system
echo "\n${GREEN}Installation complete. The system will now reboot. ${NC}"
sleep 3 
run_sudo reboot

