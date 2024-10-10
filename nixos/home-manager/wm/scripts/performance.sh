#!/usr/bin/env sh
HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
if [ "$HYPRGAMEMODE" = 1 ]; then
  hyprctl --batch "\
        keyword animations:enabled 0;\
        keyword decoration:drop_shadow 0;\
        keyword decoration:blur:enabled 0;"
  notify-send.sh -f -t 1000 Pretties: Off
  exit
fi
hyprctl --batch "\
        keyword animations:enabled 1;\
        keyword decoration:drop_shadow 1;\
        keyword decoration:blur:enabled 1;"
notify-send.sh -f -t 1000 Pretties: On
