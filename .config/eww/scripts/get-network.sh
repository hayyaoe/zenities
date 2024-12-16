CONNECTION_TYPE=$(nmcli -t -f TYPE,STATE device | grep -E "^ethernet:connected$|^wifi:connected$" | awk -F: '{print $1}')

if [[ "$CONNECTION_TYPE" == "wifi" ]]; then
    SSID=$(nmcli -t -f ACTIVE,SSID dev wifi | awk -F: '$1=="yes"{print $2}')
    echo $SSID
elif [[ "$CONNECTION_TYPE" == "ethernet" ]]; then
    ETHERNET_NAME=$(nmcli -t -f NAME connection show --active | grep ethernet)
    echo $ETHERNET_NAME
else
    echo "None"
fi
