#!/bin/sh
if ! pgrep -f "polybar .* primary" >/dev/null; then
    echo "Starting primary polybar..."
    polybar --reload primary &
fi

if ! xrandr -q | grep -q "VGA-0 connected"; then
    echo "Killing secondary polybar..."
    pkill -f "polybar .* secondary"
else
    if ! pgrep -f "polybar .* secondary" >/dev/null; then
        echo "Starting secondary polybar..."
        polybar --reload secondary &
    fi
fi
