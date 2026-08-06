while true 
do
	date="$(date +'%Y-%m-%d %X')"
	battery=$(cat /sys/class/power_supply/BAT0/capacity)
	echo ""$battery"%    $date"

	sleep 1 
done
