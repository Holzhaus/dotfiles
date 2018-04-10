#!/bin/sh
# Check which bars should be launched
PROFILE="$1"

if [ -z "$PROFILE" ]
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
    "")
        printf 'Using default polybar profile "docked"\n'
        POLYBAR_NAMES="primary secondary"
        ;;
    *)
        printf 'Usage: %s {none|docked|mobile}\n' "$0"
        exit 1
esac

# Kill old instances and wait for them to terminate
pkill -TERM -e polybar | grep -ioP '(pid \K\d+)' | while read -r PID
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
    polybar --reload "$POLYBAR_NAME" &
done
