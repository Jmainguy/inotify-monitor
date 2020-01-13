#!/bin/sh
# Credit for the line= logic from https://raw.githubusercontent.com/fatso83/dotfiles/master/utils/scripts/inotify-consumers

while true; do

    count=0
    lines=$(
        find /opt/proc/*/fd \
        -lname anon_inode:inotify \
        -printf '%hinfo/%f\n' 2>/dev/null \
        \
        | xargs grep -c '^inotify'  \
        | sort -n -t: -k2 -r -u \
    )

    for line in $lines; do
        watcher_count=$(echo $line | sed -e 's/.*://')
        count=$(($count + $watcher_count))
    done

    if [ $count -gt 50000 ]; then
    	echo "{\"msg\": \"inotify is too damn high\", \"inotify-count\": $count}"
    else
    	echo "{\"msg\": \"inotify is fine\", \"inotify-count\": $count}"
    fi
    sleep 300
done
