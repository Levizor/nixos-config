#!/usr/bin/env bash

pid=$(hyprctl activewindow | grep -E 'pid:' | grep -oE '[0-9]+')
notify-send.sh -f -t 3000 "Process Killed" "$pid: $(ps -p $pid -o comm=)"
kill -9 $pid
