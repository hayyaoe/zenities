#!/bin/bash

# Install necessary packages via pacman
cd $HOME
sudo pacman -S --noconfirm github-cli stow pamixer brightnessctl playerctl ncspot rofi-wayland hyprlock hypridle hyprpaper yazi neovim bottom networkmanager rustup zsh imagemagick acpi pavucontrol

# Backup Existing Config
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

echo "Backing up individual files in $HOME"
for file in "${FILES[@]}"; do
  if [ -f "$HOME/$file" ]; then
    echo "Backing up file: $file"
    mv "$HOME/$file" "$HOME/${file}${BACKUP_SUFFIX}"
  else
    echo "File $file not found; skipping backup"
  fi
done

CACHE_WAL="$HOME/.cache/wal"
CACHE_WAL_BAK="$HOME/.cache/wal.bak"

echo "Checking for $CACHE_WAL..."
if [ -d "$CACHE_WAL" ]; then
  echo "Backing up $CACHE_WAL to $CACHE_WAL_BAK"
  mv "$CACHE_WAL" "$CACHE_WAL_BAK"
else
  echo "$CACHE_WAL not found; skipping..."
fi

echo "Applying dotfiles with stow"
cd "$HOME/zenities" || { echo "Could not access $HOME/zenities"; exit 1; }
stow .

# Go back to home directory
cd $HOME

# Install yay (AUR helper)
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm

# Install additional packages via yay
yay -S --noconfirm neofetch cmatrix cava python-pywal ttf-iosevka otf-hermit-nerd gvfs dbus libdbusmenu-glib libdbusmenu-gtk3 gtk-layer-shell brave-bin zoxide eza fzf thefuck jq socat tmux nvm btop hyprshot bluez bluez-utils bluez-obex bluetuith python-gobject 

# Install Powerlevel10k for zsh
yay -S --noconfirm zsh-theme-powerlevel10k-git
echo 'source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc

# Eww installation
cd $HOME

curl --proto '=https' -- tlsv1.2 -sSf https://sh.rustup.rs | sh

git clone https://github.com/elkowar/eww
cd eww
cargo build --release --no-default-features --features=wayland
cd target/release
chmod +x ./eww
sudo cp ./eww /usr/local/bin/

# Network Manager setup
sudo systemctl disable systemd-resolved
sudo systemctl disable systemd-networkd
sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service

# Change shell to zsh
chsh -s /usr/bin/zsh

# Reboot the system
echo "Installation complete. The system will now reboot."
sudo reboot

