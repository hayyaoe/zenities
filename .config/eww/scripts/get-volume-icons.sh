muted=$(pactl list sinks | grep -E 'Name:|Mute:' | awk '/Name:/{sink=$2} /Mute:/{print $2}')
volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | sed 's/%//')
if [[ $muted == "no" ]]; then
  if (( volume > 50 )); then
    echo ""
  elif (( volume > 0 )); then
    echo ""
  else
    echo ""
  fi
else 
  echo ""
fi
