SYMLINK_CONFIG_FILE="$HOME/.config/hypr/hyprpaper.conf"

TARGET_FILE=$(readlink -f "$SYMLINK_CONFIG_FILE")

if [ ! -f "$TARGET_FILE" ]; then
    echo "Target configuration file does not exist: $TARGET_FILE"
    exit 1
fi

CURRENT_SETTING=$(grep "^ipc" "$TARGET_FILE" | awk '{print $3}')

if [ "$CURRENT_SETTING" = "on" ]; then
    NEW_SETTING="off"
else
    NEW_SETTING="on"
fi

sed -i "s/^ipc = .*/ipc = $NEW_SETTING/" "$TARGET_FILE"


