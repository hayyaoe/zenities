sink=$(pactl get-default-sink)

muted=$(pactl get-sink-mute "$sink" | awk '{print $2}')

volume=$(pactl get-sink-volume "$sink" | awk '/Volume: front-left/ { gsub(/%/, "", $5); print $5; exit }')

if [[ "$muted" == "yes" ]]; then
  echo ""
else
  if (( volume > 50 )); then
    echo ""
  elif (( volume > 0 )); then
    echo ""
  else
    echo ""
  fi
fi

