################################

automatically add trackers for torrents in transmission from a curated list (2024)

the new transmission-qt 3.00 disabled the addition of a custom list of trackers
so i spruced up this old bash script that uses transmission_remote to 
automatically add all trackers in a list to torrents in your transmission gui

(github.com/neuthral/add_trackers)[github.com/neuthral/add_trackers]

Usage:  addtrackers.sh [id] [list.txt]  

list of torrents from torrent-remote localhost:9091 --list
    ID   Done       Have  ETA           Up    Down  Ratio  Status       Name
     1   100%    1,01 GB  9 hrs      100.0     0.0   0,14  Seeding      Debian
     2    n/a       None  Unknown      0.0     0.0   None  Idle         Arch+Linux.iso

