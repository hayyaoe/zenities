CHOICE=$(printf "Fullscreen\nRegion\nActive Window\nClipboard (Region)" | rofi -dmenu -p "∂")

case "$CHOICE" in
  "Fullscreen")
    hyprshot -m output ;;
  "Region")
    hyprshot -m region ;;
  "Active Window")
    hyprshot -m window ;;
  "Clipboard (Region)")
    hyprshot -m region -c ;;
  *)
    exit 0 ;;
esac

