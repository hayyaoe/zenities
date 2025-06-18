#!/bin/bash

# Remove symlinked dotfiles installed by stow
cd $HOME/zenities
stow -D .

# Restore the original hypr and kitty configurations (if backups exist)
# Define paths and backup suffix
CONFIG_DIR="$HOME/.config"
BACKUP_SUFFIX=".bak"
DOTFILES_CONFIG="$HOME/zenities/.config"

echo "Restoring configuration directories from backups in $CONFIG_DIR"
cd "$CONFIG_DIR" || { echo "Could not access $CONFIG_DIR"; exit 1; }

# Loop over backup directories and restore them
for backup in *"$BACKUP_SUFFIX"; do
  # Remove the .bak suffix to get the original name
  original="${backup%$BACKUP_SUFFIX}"
  if [ -e "$original" ]; then
    echo "Warning: $original exists; skipping restoration of backup $backup to avoid overwriting."
  else
    echo "Restoring directory backup: $backup -> $original"
    mv "$backup" "$original"
  fi
done

FILES=(.zshrc .zshenv .tmux.conf .p10k.zsh wallpapers scripts screenshots)

echo "Restoring individual file backups in $HOME"
for file in "${FILES[@]}"; do
  backup_file="$HOME/${file}${BACKUP_SUFFIX}"
  if [ -f "$backup_file" ]; then
    if [ -f "$HOME/$file" ]; then
      echo "Warning: $file exists in $HOME; skipping restoration to avoid overwriting."
    else
      echo "Restoring file backup: $backup_file -> $HOME/$file"
      mv "$backup_file" "$HOME/$file"
    fi
  else
    echo "Backup for $file not found; nothing to restore."
  fi
done

CACHE_WAL="$HOME/.cache/wal"
CACHE_WAL_BAK="$HOME/.cache/wal.bak"

echo "Checking for $CACHE_WAL_BAK..."
if [ -d "$CACHE_WAL_BAK" ]; then
  if [ -d "$CACHE_WAL" ]; then
    echo "Warning: $CACHE_WAL already exists; skipping restoration to avoid overwriting."
  else
    echo "Restoring $CACHE_WAL_BAK to $CACHE_WAL"
    mv "$CACHE_WAL_BAK" "$CACHE_WAL"
  fi
else
  echo "$CACHE_WAL_BAK not found; nothing to restore."
fi


# Remove cloned zenities dotfiles
cd $HOME
rm -rf zenities

# Clean up Eww
# if [ -d "$HOME/eww" ]; then
#     rm -rf $HOME/eww
#     sudo rm /usr/local/bin/eww
# fi

# Restore default shell to bash
chsh -s /bin/bash

# Optionally stop and disable NetworkManager (comment these lines if you want to keep NetworkManager)
# sudo systemctl disable NetworkManager
# sudo systemctl stop NetworkManager

# Reboot the system
echo "Uninstallation complete. The system will now reboot."
sudo reboot

