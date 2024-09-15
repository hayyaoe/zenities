hyprctl workspaces -j | jq -c

socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line; do
  hyprctl workspaces -j | jq -c 'sort_by(.id)'
done
