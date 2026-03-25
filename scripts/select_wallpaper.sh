#!/bin/bash

NORMALIZE="$HOME/scripts/normalize_wallpaper.sh"
WINDOW_NAME="wallpaper"

if eww active-windows | grep -q "$WINDOW_NAME"; then
  eww close "$WINDOW_NAME"
else

  if [ -f "$NORMALIZE" ]; then
      bash "$NORMALIZE"
  fi

  eww open "$WINDOW_NAME"
fi

