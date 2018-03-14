# autorandr
autorandr --change

# Gnome Keyring
dbus-update-activation-environment --systemd DISPLAY
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# Load Xresources
xrdb -merge $HOME/.Xresources

# Screensaver / Locker
xset s 180 180
xset dpms 300 600 900
xss-lock -l -- "$HOME/.i3/i3lock-multimonitor.sh" "$HOME/.i3/lockscreen.jpg" -c 000000 -f -t &

# Wallpaper
nitrogen --restore

# Auto-Hide mouse pointer
( command -v "unclutter" >/dev/null 2>&1 ) && unclutter &

exec i3
