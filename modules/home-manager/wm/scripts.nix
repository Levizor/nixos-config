{
  lib,
  monitors,
  path ? ".config/hypr/scripts",
  ...
}:
let
  monitorNames = map (m: m.name) monitors;
  monitorConfigs = map (m: m.config) monitors;
in
{
  home.file."${path}/toggleMonitor.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      set -e

      monitors=(${lib.concatStringsSep " " (map lib.escapeShellArg monitorNames)})
      configs=(${lib.concatStringsSep " " (map lib.escapeShellArg monitorConfigs)})

      if [[ -z "$1" || "$1" -lt 0 || "$1" -ge "${toString (builtins.length monitors)}" ]]; then
        echo "Usage: $0 <monitor_index>"
        exit 1
      fi

      index=$1
      monitor="''${monitors[$index]}"
      config="''${configs[$index]}"

      current_status=$(hyprctl monitors all | grep -A20 "$monitor" | grep "disabled")

      if [[ "$current_status" == *"false"* ]]; then
        echo "Disabling $monitor"
        notify-send -t 1000 Disabling $monitor
        hyprctl dispatch dpms off "$monitor"
        hyprctl keyword monitor "$monitor,disable"
      else
        echo "Enabling $monitor with config: $config"
        notify-send -t 1000 Enabling $monitor
        hyprctl keyword monitor "$monitor,$config"
        hyprctl dispatch dpms on "$monitor"
      fi
    '';
  };
}
