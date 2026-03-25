#!/bin/bash

# Variables
SELECTED_WALLPAPER=$1
WALLPAPER_DIR="$HOME/wallpapers"

# Ensure the wallpaper exists
if [ ! -f "$WALLPAPER_DIR/$SELECTED_WALLPAPER.jpg" ]; then
    echo "Error: Wallpaper not found: $SELECTED_WALLPAPER"
    exit 1
fi

# Apply pywal colors
matugen --source-color-index 0 -m dark image "$WALLPAPER_DIR/$SELECTED_WALLPAPER.jpg" || { echo "Error: wallust failed"; exit 1; }

# Reload eww
killall eww || echo "Warning: No eww process found"
eww open-many side-bar notifications

# Restart hyprpaper
killall hyprpaper || echo "Warning: No hyprpaper process found"
hyprpaper -c $HOME/.config/hypr/service/hyprpaper.conf &

# Apply Kitty Colors
SOCKET=$(ls /tmp | grep kitty | head -n 1)
kitty @ --to unix:/tmp/$SOCKET set-colors -a -c ~/.config/kitty/kitty-colors.conf

# Apply Nvim Colors if Exist
for sock in /tmp/nvim*; do
  nvim --server "$sock" --remote-send "<cmd>colorscheme lush-colors<CR>"
done
