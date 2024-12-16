if brightnessctl -l | grep -q 'backlight'; then
  echo "true"
else
    echo "false"
fi

