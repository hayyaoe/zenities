CHOICE=$(printf "\n\n\n\n" | rofi -dmenu -replace -config ~/.config/rofi/config-power.rasi)

case "$CHOICE" in
  "")
    cd /$HOME
    sleep 1
    shutdown now
  ;;
  "")
    cd /$HOME
    sleep 1
    reboot 
  ;;
  "") 
    sleep 1
    hyprlock
  ;;
  "") 
    sleep 1
    killall Hyprland
  ;;
  "")
    cd /$HOME
    sleep 1
    systemctl suspend
  ;;
  *) 
    exit 1
  ;;
esac
