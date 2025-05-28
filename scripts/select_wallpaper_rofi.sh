WALLPAPER_DIR="$HOME/wallpapers"

SELECTED_WALLPAPER=$(ls "$WALLPAPER_DIR" | rofi -dmenu -replace -config ~/.config/rofi/config-wallpaper.rasi -p "∂" )
 
if [ -n "$SELECTED_WALLPAPER" ]; then

   # hyprctl hyprpaper preload "$WALLPAPER_DIR/$SELECTED_WALLPAPER"
   # hyprctl hyprpaper wallpaper ", $WALLPAPER_DIR/$SELECTED_WALLPAPER"
 
   SYMLINK_CONFIG_FILE="$HOME/.config/hypr/hyprpaper.conf"
   SYMLINK_LOCK_CONFIG="$HOME/.config/hypr/hyprlock.conf"
   TARGET_FILE=$(readlink -f "$SYMLINK_CONFIG_FILE")
   TARGET_FILE2=$(readlink -f "$SYMLINK_LOCK_CONFIG")

   wal -i "$HOME/wallpapers/$SELECTED_WALLPAPER"

   sed -i -e "s|preload = .*|preload = $HOME/wallpapers/$SELECTED_WALLPAPER|" \
          -e "s|wallpaper = ,.*|wallpaper = ,$HOME/wallpapers/$SELECTED_WALLPAPER|" "$TARGET_FILE"
   sed -i -e "s|path = .*|path = $HOME/wallpapers/$SELECTED_WALLPAPER|" "$TARGET_FILE2"

    killall hyprpaper
    hyprpaper

   eww --restart open bar

fi

