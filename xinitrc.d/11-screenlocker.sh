#!/bin/sh
# Screensaver / Locker
xset s 180 180
xset dpms 180 180 180
xss-lock -l -- "$HOME/.local/bin/i3lock-multimonitor" "$HOME/.i3/lockscreen.jpg" -c 000000 -f -t &
