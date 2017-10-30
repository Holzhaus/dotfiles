#!/bin/bash
CACHE_DIR="${HOME}/.cache/i3lock-multimonitor"
if ! [ -e "${CACHE_DIR}" ]; then
    mkdir -p "${CACHE_DIR}"
fi

function usage {
    printf "usage: $0 [-p] IMAGE_PATH [ I3LOCK_ARGS ... ]"
    exit 1
}

PREPARE_ONLY=0

if [ "$#" -eq 0 ]; then
    usage
fi

if [ "$1" == "-p" ]; then
    if [ "$#" -eq 1 ]; then
        usage
    fi
    PREPARE_ONLY=1
    printf "Flag -p given, only preparing image for later usage...\n"
    ORIGINAL_IMAGE_PATH="$2"
else
    ORIGINAL_IMAGE_PATH="$1"
fi

if ! [ -e "${ORIGINAL_IMAGE_PATH}" ]; then
    echo "Error: Image '${ORIGINAL_IMAGE_PATH}' not found"
    exit 2
fi

XRANDR="$(xrandr -q)"
CHECKSUM="$(cat "${ORIGINAL_IMAGE_PATH}" <(printf "${XRANDR}") | md5sum -)"
IMAGE_PATH="${CACHE_DIR}/${CHECKSUM%  *}.png"

if ! [ -e "${IMAGE_PATH}" ]; then
    printf "%s does not exist, creating...\n" "${IMAGE_PATH}"
    IMAGE_WIDTH=0
    IMAGE_HEIGHT=0
    IM_ARGS=""
    TEMP_DIR="$(mktemp -t -d "i3lock.XXXXXXXXXX")"
    #trap "rm -rf \"${TEMP_DIR}\"" EXIT
    while read LINE
    do
        if [[ "$LINE" =~ ([0-9]+)x([0-9]+)\+([0-9]+)\+([0-9]+) ]]; then
            SCREEN_WIDTH=${BASH_REMATCH[1]}
            SCREEN_HEIGHT=${BASH_REMATCH[2]}
            SCREEN_X=${BASH_REMATCH[3]}
            SCREEN_Y=${BASH_REMATCH[4]}
            printf "Found active screen: %s\n" "${BASH_REMATCH[0]}"

            TEMP_IMG="${TEMP_DIR}/${SCREEN_WIDTH}x${SCREEN_HEIGHT}.png"
            if ! [ -e "${TEMP_IMG}" ]
            then
                convert "${ORIGINAL_IMAGE_PATH}" -resize "${SCREEN_WIDTH}X${SCREEN_HEIGHT}^" -gravity center -crop "${SCREEN_WIDTH}X${SCREEN_HEIGHT}+0+0" +repage "${TEMP_IMG}" || {
                    SCREEN_WIDTH=0
                    SCREEN_HEIGHT=0
                    break
                }
            fi

            (( ${IMAGE_WIDTH} < ($SCREEN_WIDTH+$SCREEN_X) )) && IMAGE_WIDTH=$(($SCREEN_WIDTH+$SCREEN_X))
            (( ${IMAGE_HEIGHT} < ($SCREEN_HEIGHT+$SCREEN_Y) )) && IMAGE_HEIGHT=$(( $SCREEN_HEIGHT+$SCREEN_Y ))

            IM_ARGS="${IM_ARGS} ${TEMP_IMG} -geometry +${SCREEN_X}+${SCREEN_Y} -composite"
        fi
    done <<< "$(printf "${XRANDR}")"

    if (( ${IMAGE_WIDTH} > 0 )) && (( ${IMAGE_WIDTH} > 0 )); then
        TEMP_IMG="${TEMP_DIR}/${IMAGE_WIDTH}x${IMAGE_HEIGHT}-final.png"
        convert -size "${IMAGE_WIDTH}x${IMAGE_HEIGHT}" "xc:black" "${TEMP_IMG}"
        convert "${TEMP_IMG}" ${IM_ARGS} "${TEMP_IMG}"
        mv "${TEMP_IMG}" "${IMAGE_PATH}"
    fi
fi

if ! [ -e "${IMAGE_PATH}" ]; then
    printf "Warning: Image processing failed, using original image.\n"
    IMAGE_PATH="${ORIGINAL_IMAGE_PATH}"
fi

if [ "$PREPARE_ONLY" -eq 0 ]; then
    printf "Locking screen...\n"
    i3lock -i "${IMAGE_PATH}" "${@:2}"
fi
