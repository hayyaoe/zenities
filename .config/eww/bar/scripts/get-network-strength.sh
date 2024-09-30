
CONNECTION_TYPE=$(nmcli -t -f TYPE,STATE device | grep -E "^ethernet:connected$|^wifi:connected$" | awk -F: '{print $1}')

if [[ "$CONNECTION_TYPE" == "ethernet" ]]; then
    echo "󰈀"  # Replace with your preferred LAN icon
elif [[ "$CONNECTION_TYPE" == "wifi" ]]; then
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
else
    echo "󰤭"
fi

