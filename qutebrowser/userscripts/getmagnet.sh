#!/bin/bash
set -o pipefail
function qute_run() {
    printf "$@" >> "$QUTE_FIFO"
}


URLS="$(grep -oP 'href="\Kmagnet:[^"]+' "$QUTE_HTML" | sed 's/&amp;/\&/g')"
if [ -z "$URLS" ]
then
    qute_run 'message-warning "Did not find any magnet links!"'
    exit 0
fi

IFS=$'\n'
for URL in $URLS
do
    if command transmission-remote "$TRANSMISSION_HOST" -a "$URL"
    then
        qute_run 'message-info "Added url: %s"' "$URL"
    else
        qute_run 'message-warning "Failed to add url: %s"' "$URL"
    fi
done
exit 0
