#!/bin/bash

CHOICE=$(printf "\n\n\n\n" | rofi -dmenu -replace -config ~/.config/rofi/config-power.rasi)

case "$CHOICE" in
  "")
    cd "$HOME" || exit 1
    sleep 1
    shutdown now
  ;;
  "")
    cd "$HOME" || exit 1
    sleep 1
    reboot 
  ;;
  "") 
    sleep 1
    hyprlock -c $HOME/.config/hypr/service/hyprlock.conf
  ;;
  "")
    cd "$HOME" || exit 1
    sleep 1
    systemctl suspend
  ;;
  "")
    cd "$HOME" || exit 1
    sleep 1
    hyprctl dispatch exit
  ;;
  *) 
    exit 1
  ;;
esac
