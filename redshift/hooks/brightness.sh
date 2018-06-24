#!/bin/sh

# Set brightness via xbrightness when redshift status changes

# Set brightness values for each status.
# Range from 1 to 100 is valid
brightness_day="100"
brightness_transition="50"
brightness_night="10"
# Set fade time for changes to one minute
#fade_time=60000

set_brightness() {
  b_val=$(echo "$2 100" | awk '{printf "%f", $1 / $2}');
  xrandr --output "$1" --brightness "$b_val";
}

case $1 in
	period-changed)
		case $3 in
			night)
				set_brightness "LVDS-1" "$brightness_night"
				set_brightness "DP-3" "$brightness_night"
				;;
			transition)
				set_brightness "LVDS-1" "$brightness_transition"
				set_brightness "DP-3" "$brightness_transition"
				;;
			daytime)
				set_brightness "LVDS-1" "$brightness_day"
				set_brightness "DP-3" "$brightness_day"
				;;
		esac
		;;
esac

