################################
#
#   add trackers for torrents in transmission from a curated list
#   github.com/neuthral
#

#!/bin/bash
BLUE='\033[0;34m'
NC='\033[0m' # No Color
GREEN='\033[0;32m'

id=$1
LIST=$2
HOST="localhost:9091"

usage () {
    echo "Automatically add trackers for torrents in transmission from a curated list"
	echo "Usage: ${BLUE} $(basename "$0") ${GREEN}[id] [list.txt] ${NC} \n"
    echo "list of torrents from torrent-remote $HOST --list"
	transmission-remote "$HOST" --list
    exit
}

add_trackers () {
    torrent_hash="$(transmission-remote "$HOST" --torrent "$id" --info | grep '^  Hash: ' | awk '{ print $2 }')"
    torrent_name="$(transmission-remote "$HOST" --torrent "$id" --info | grep '^  Name: ' | cut -c 9-)"
    #torrent_hash=$1

    echo "adding trackers for $torrent_name"
	while read -r LINE; do
        echo "${LINE} ..."
        if (transmission-remote "$HOST" --torrent "${torrent_hash}" --tracker-add "${LINE}" | grep -q 'success'); then
            echo " done."
        else
            echo " already added"
        fi
        sleep 0.1
    done < ${LIST}
}

if [ !$1 ]; then
	usage
else
    add_trackers "$hash"
fi
