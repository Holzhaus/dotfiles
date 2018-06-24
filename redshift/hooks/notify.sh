#!/bin/sh
case $1 in
    period-changed)
        if [ "$3" = "none" ]
        then
            exec notify-send "Redshift" "Temperature adjustment disabled"
        else
            exec notify-send "Redshift" "Period changed to $3"
        fi
esac
