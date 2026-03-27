#!/bin/bash

SELECTED_WALLPAPER=$1
MODE=$2
WALLPAPER_DIR="$HOME/wallpapers"

# MONITOR=$(hyprctl monitors | grep '^Monitor' | awk 'NR==1 {print $2}')

if [ -f "$WALLPAPER_DIR/$SELECTED_WALLPAPER.jpg" ]; then
 
    SYMLINK_CONFIG_FILE="$HOME/.config/hypr/service/hyprpaper.conf"
    SYMLINK_LOCK_CONFIG="$HOME/.config/hypr/service/hyprlock.conf"
    TARGET_FILE=$(readlink -f "$SYMLINK_CONFIG_FILE")
    TARGET_FILE2=$(readlink -f "$SYMLINK_LOCK_CONFIG")

  #  sed -i -e "s|monitor = .*|monitor = $MONITOR|" "$TARGET_FILE"
    sed -i -e "s|path = .*|path = \$HOME/wallpapers/$SELECTED_WALLPAPER.jpg|" "$TARGET_FILE"
    sed -i -e "s|path = .*|path = \$HOME/wallpapers/$SELECTED_WALLPAPER.jpg|" "$TARGET_FILE2"

    ~/.config/eww/scripts/update-color.sh "$SELECTED_WALLPAPER" "$MODE"
else
    echo "Wallpaper not found: $SELECTED_WALLPAPER"
fi

