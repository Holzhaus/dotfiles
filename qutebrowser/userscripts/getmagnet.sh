#!/bin/bash
set -o pipefail
function qute_run() {
    printf "$@" >> "$QUTE_FIFO"
}

if [ -z "$QUTE_HTML" ] && ! [ -z "$QUTE_URL" ]
then
    QUTE_HTML="$(curl -s "$QUTE_URL")"
    if [ "$?" -ne 0 ]
    then
        qute_run 'message-error "curl exited with code %d"' "$?"
    fi
fi

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
