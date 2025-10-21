{
  pkgs,
  lib,
  inputs,
  ...
}:
let
  toggle_dir = "$HOME/.local/state/toggles";
in
rec {
  toggle = pkgs.writeShellScriptBin "toggle" ''
    #!/usr/bin/env bash
    set -e
    NAME="$1"
    ACTION="''${2:-status}"
    mkdir -p "${toggle_dir}"
    FILE="${toggle_dir}/$NAME"

    case "$ACTION" in
      toggle)
        if [ -f "$FILE" ]; then
          rm -f "$FILE"
          echo "$NAME is now OFF"
        else
          touch "$FILE"
          echo "$NAME is now ON"
        fi
        ;;
      on)
        touch "$FILE"
        echo "$NAME is now ON"
        ;;
      off)
        rm -f "$FILE" 2>/dev/null || true
        echo "$NAME is now OFF"
        ;;
      status)
        if [ -f "$FILE" ]; then
          echo "$NAME is ON"
          exit 0
        else
          echo "$NAME is OFF"
          exit 1
        fi
        ;;
      *)
        echo "Usage: $0 <toggle-name> [toggle|on|off|status]"
        exit 2
        ;;
    esac
  '';

  toggleable =
    name: script:
    let
      drv = pkgs.writeShellScriptBin name ''
        FILE="${toggle_dir}/${name}"
        if [ -f "$FILE" ]; then
          ${script} "$@"
        fi
      '';
    in
    lib.getExe drv;

  toggleableDerivation = name: drv: toggleable name "${lib.getExe drv}";
}
