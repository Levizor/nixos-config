#!/usr/bin/env sh
HYPRGAMEMODE=$(hyprctl getoption decoration:blur:enabled | awk 'NR==1{print $2}')
if [ "$HYPRGAMEMODE" = 1 ]; then
  hyprctl --batch "\
        keyword decoration:blur:enabled 0;"
  notify-send -t 1000 Decorations: Off
  exit
fi
hyprctl --batch "\
        keyword decoration:blur:enabled 1;"
notify-send -t 1000 Decorations: On
