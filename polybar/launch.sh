#!/bin/sh
if ! pgrep -f "polybar .* primary"; then
    polybar --reload primary &
fi

if ! pgrep -f "polybar .* secondary"; then
    polybar --reload secondary &
fi
