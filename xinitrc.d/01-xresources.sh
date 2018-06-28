#!/bin/sh
# Load Xresources
: "${HOME?Need to set HOME}"
xrdb -merge "$HOME/.Xresources"
