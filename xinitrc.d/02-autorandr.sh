#!/bin/sh
# Switch to preferred monitor setup
( command -v "autorandr" >/dev/null 2>&1 ) && [ -z "$(autorandr --current)" ] && autorandr --change
