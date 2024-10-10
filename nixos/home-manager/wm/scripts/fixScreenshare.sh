#!/usr/bin/env bash

monitor=$(hyprctl activeworkspace | head -n 1 | cut -d' ' -f7)
monitor=${monitor::-1}

props=$(hyprctl monitors | grep -A 1 -e $monitor | tail -n 1)
resoultion=$(echo $props | cut -d'@' -f1)

format=$(hyprctl monitors | grep -A 16 -e $monitor | tail -n 1)

echo PROPS: $props
at=$(echo $props | cut -d' ' -f3)

echo $format
format=$(echo $format | grep -oe '8888')

if [[ -z $format ]]; then
  hyprctl keyword monitor $monitor, $resoultion, $at, 1,
  notify-send Screenshare Unfixed
else
  hyprctl keyword monitor $monitor, $resoultion, $at, 1, bitdepth, 10
  notify-send Screenshare Fixed
fi
