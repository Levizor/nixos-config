#!/usr/bin/env sh
HYPRGAPSOUT=$(hyprctl getoption general:gaps_out | awk 'NR==1{print $3}')
HYPRGAPSIN=$(hyprctl getoption general:gaps_in | awk 'NR==1{print $3}')
HYPRROUNDING=$(hyprctl getoption decoration:rounding | awk 'NR==1{print $2}')
echo $HYPRROUNDING

if [ "$HYPRGAPSOUT" != 0 ]; then
  echo $HYPRGAPSOUT >~/.cache/gaps_out
  echo $HYPRGAPSIN >~/.cache/gaps_in
  echo $HYPRROUNDING >~/.cache/rounding
  hyprctl --batch "\
        keyword general:gaps_in 0;\
        keyword general:gaps_out 0;\
        keyword decoration:rounding 0"
  notify-send.sh -f -t 1000 Gaps: off
  exit
fi
hyprctl --batch "\
  keyword general:gaps_in $(cat ~/.cache/gaps_in);\
  keyword general:gaps_out $(cat ~/.cache/gaps_out);\
  keyword decoration:rounding $(cat ~/.cache/rounding)"
notify-send.sh -f -t 1000 Gaps: on
