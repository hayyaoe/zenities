STRENGTH=$(nmcli -f IN-USE,SIGNAL dev wifi | grep '*' | awk '{print $2}')

if (( STRENGTH > 80 )); then
    echo "󰤨"
elif (( STRENGTH > 60 )); then
    echo "󰤥"
elif (( STRENGTH > 40 )); then
    echo "󰤢"
elif (( STRENGTH > 20 )); then
    echo "󰤟"
elif (( STRENGTH >= 0 )); then
    echo "󰤯"
else
    echo "󰤭"
fi
