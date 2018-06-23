#!/bin/sh
# Check which bars should be launched
PROFILE="$1"

if [ -z "$PROFILE" ]
then
    PROFILE="$(autorandr --dry-run  2>&1 | grep -Po '^\w+(?=.*\s\(current\))')"
    if [ -z "$PROFILE" ]
    then
        printf 'Current profile not detected!\n'
        PROFILE="default"
    else
        printf 'Using detected polybar profile "%s"\n' "$PROFILE"
    fi
fi

if [ "$PROFILE" = "default" ]
then
    PROFILE="docked"
    printf 'Using default polybar profile "%s"\n' "$PROFILE"
fi

case "$PROFILE" in
    "none")
        POLYBAR_NAMES=""
        ;;
    "docked")
        POLYBAR_NAMES="primary secondary"
        ;;
    "mobile")
        POLYBAR_NAMES="primary"
        ;;
    *)
        printf 'Usage: %s {none|docked|mobile}\n' "$0"
        exit 1
esac

# Kill old instances and wait for them to terminate
pkill -TERM -e -x polybar | grep -ioP '(pid \K\d+)' | while read -r PID
do
    while ps --pid "$PID" > /dev/null
    do
        printf 'Waiting for polybar with pid %d to terminate...\n' "$PID"
        sleep 0.1
    done
    printf 'Polybar with pid %d terminated\n' "$PID"
done

# Early exit if no polybar should be launched
[ -z "$POLYBAR_NAMES" ] && exit 0

for POLYBAR_NAME in $POLYBAR_NAMES
do
    printf 'Launching polybar "%s"\n' "$POLYBAR_NAME"
    setsid --fork polybar --reload "$POLYBAR_NAME"
done
