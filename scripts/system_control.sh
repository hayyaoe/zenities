CHOICE=$(printf "\n󰖩\n\n\n" | rofi -dmenu -replace -config ~/.config/rofi/config-power.rasi)

case "$CHOICE" in "")
  sh ~/scripts/volume.sh
  ;;
"")
  sh ~/scripts/wifi_settings.sh
  ;;
"")
  sh ~/scripts/bluetooth.sh
  ;;
"")
  sh ~/scripts/brightness.sh
  ;;
"")
  sh ~/scripts/microphone.sh
  ;;
*)
    exit 1
  ;;
esac
