#!/bin/sh
# Screensaver / Locker
xset s 180 180
xset dpms 300 600 900
xss-lock -l -- "$HOME/.i3/i3lock-multimonitor.sh" "$HOME/.i3/lockscreen.jpg" -c 000000 -f -t &
