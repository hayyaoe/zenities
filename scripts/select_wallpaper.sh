#!/bin/bash

# Name of the EWW window
WINDOW_NAME="wallpaper"

# Check if the window is open
if eww active-windows | grep -q "$WINDOW_NAME"; then
  # If open, close it
  eww close "$WINDOW_NAME"
else
  # If not open, open it
  eww open "$WINDOW_NAME"
fi

