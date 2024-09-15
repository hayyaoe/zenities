BAT=`ls /sys/class/power_supply | grep BAT | head -n 1`
	cat /sys/class/power_supply/${BAT}/capacity
