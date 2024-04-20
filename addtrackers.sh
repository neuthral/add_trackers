################################
#
#   add trackers for torrents in transmission from a curated list
#   github.com/neuthral
#

#!/bin/bash
# Get transmission credentials, if set
if [[ -n "$TRANSMISSION_USER" && -n "$TRANSMISSION_PASS" ]]; then
    auth="${TRANSMISSION_USER:-user}:${TRANSMISSION_PASS:-password}"
else
    auth=
fi

LIST="$HOME/.trackers.txt" # set this to your tracker list path
HOST="localhost:9091"

add_trackers () {
    torrent_hash=$1
    echo "adding trackers for $torrent_name"
    while read tracker; do
        echo -en "\e[0m"
        echo -ne "\e[93m*\e[0m ${tracker} ..."
        if transmission-remote "$HOST" --torrent "${torrent_hash}" -td "${tracker}" | grep -q 'success'; then
            echo -e '\e[92m done.'
            echo -en "\e[0m"
        else
            echo -e '\e[93m already added.'
            echo -en "\e[0m"
        fi
        sleep 0.05
    done < "${LIST}"
}

# Get list of active torrents
IDS=$(transmission-remote localhost:9091 --list | grep -vE 'Seeding|Stopped|Finished' | grep '^ ' | awk '{ print $1 }' | tr -d -c 0-9)

for id in $IDS ; do
    hash="$(transmission-remote "$HOST" --torrent "$id" --info | grep '^  Hash: ' | awk '{ print $2 }')"
    torrent_name="$(transmission-remote "$HOST" --torrent "$id" --info | grep '^  Name: ' | cut -c 9-)"
    add_trackers "$hash"
done
