{
  flake.lib.wm-scripts =
    {
      pkgs,
      monitors,
      myopts,
      ...
    }:
    let
      lib = pkgs.lib;
      monitorNames = map (m: m.name) monitors;
      monitorConfigs = map (m: m.config) monitors;
      commonDependencies = with pkgs; [
        libnotify
        jq
      ];
    in
    rec {
      monitorToggleScript = pkgs.writeShellApplication {
        name = "monitorToggleScript";
        runtimeInputs = commonDependencies;
        text = ''
          set -e
          monitors=(${lib.concatStringsSep " " (map lib.escapeShellArg monitorNames)})
          configs=(${lib.concatStringsSep " " (map lib.escapeShellArg monitorConfigs)})

          if [[ -z "$1" || "$1" -lt 0 || "$1" -ge "${toString (builtins.length monitors)}" ]]; then
            echo "Usage: $0 <monitor_index>"
            exit 1
          fi

          index="$1"
          monitor="''${monitors[$index]}"
          config="''${configs[$index]}"

          current_status=$(hyprctl monitors all | grep -A20 "$monitor" | grep "disabled")

          if [[ "$current_status" == *"false"* ]]; then
            echo "Disabling $monitor"
            notify-send -t 1000 Disabling "$monitor"
            hyprctl dispatch dpms off "$monitor"
            hyprctl keyword monitor "$monitor,disable"
          else
            echo "Enabling $monitor with config: $config"
            notify-send -t 1000 Enabling "$monitor"
            hyprctl keyword monitor "$monitor,$config"
            hyprctl dispatch dpms on "$monitor"
          fi
        '';
      };

      tmuxInitScript = pkgs.writeShellApplication {
        name = "tmuxInitScript";
        runtimeInputs = [ pkgs.tmux ];
        text = ''
          echo "Initializing tmux"
          tmux start-server
          tmux has-session -t dashboard 2>/dev/null || tmuxp load -d dashboard
          tmux has-session -t dev 2>/dev/null || tmuxp load -d dev
          while true;
          do
            pgrep tmux &>/dev/null || break
            tmux refresh-client -S;
            sleep 0.1;
          done & '';
      };

      animationsToggleScript = pkgs.writeShellApplication {
        name = "animationsToggleScript";
        runtimeInputs = commonDependencies;
        text = ''
          #!/usr/bin/env bash
          HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
          if [ "$HYPRGAMEMODE" = 1 ]; then
            hyprctl --batch "\
                  keyword animations:enabled 0;"
            notify-send -t 1000 Animations: Off
            exit
          fi
          hyprctl --batch "\
                  keyword animations:enabled 1;"
          notify-send -t 1000 Animations: On
        '';
      };

      decorationsToggleScript = pkgs.writeShellApplication {
        name = "decorationsToggleScript";
        runtimeInputs = commonDependencies;
        text = ''
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
        '';
      };

      gapsToggleScript = pkgs.writeShellApplication {
        name = "gapsToggleScript";
        runtimeInputs = commonDependencies;
        text = ''
          #!/usr/bin/env bash
          HYPRGAPSOUT=$(hyprctl getoption general:gaps_out | awk 'NR==1{print $3}')
          HYPRGAPSIN=$(hyprctl getoption general:gaps_in | awk 'NR==1{print $3}')
          HYPRROUNDING=$(hyprctl getoption decoration:rounding | awk 'NR==1{print $2}')

          if [ "$HYPRGAPSOUT" != 0 ]; then
            echo "$HYPRGAPSOUT" >~/.cache/gaps_out
            echo "$HYPRGAPSIN" >~/.cache/gaps_in
            echo "$HYPRROUNDING" >~/.cache/rounding
            hyprctl --batch "\
                  keyword general:gaps_in 0;\
                  keyword general:gaps_out 0;\
                  keyword decoration:rounding 0"
            notify-send  -t 1000 Gaps: off
            exit
          fi
          hyprctl --batch "\
            keyword general:gaps_in $(cat ~/.cache/gaps_in);\
            keyword general:gaps_out $(cat ~/.cache/gaps_out);\
            keyword decoration:rounding $(cat ~/.cache/rounding)"
          notify-send -t 1000 Gaps: on
        '';
      };

      forceKillScript = pkgs.writeShellApplication {
        name = "forceKillScript";
        runtimeInputs = commonDependencies;
        text = ''
          #!/usr/bin/env bash

          pid=$(hyprctl activewindow | grep -E 'pid:' | grep -oE '[0-9]+')
          notify-send -t 3000 "Process Killed" "$pid: $(ps -p "$pid" -o comm=)"
          kill -9 "$pid"
        '';
      };

      openOnFocusScript = pkgs.writeShellApplication {
        name = "openOnFocusScript";
        runtimeInputs = commonDependencies;
        text = ''
            #!/usr/bin/env bash
            # Map workspace ID to application command
          declare -A workspace_apps=(
                [1]="Telegram"
                [2]="keepassxc"
                [3]="youtube-music"
                [4]="vesktop"
                [5]="teams-for-linux"
                [6]="${myopts.browser}"
                [7]="kitty -1"
                [8]="steam"
            )

            last_ws=""

            while true; do
                wsid=$(hyprctl activeworkspace -j | jq -r '.id')

                if [[ "$wsid" != "$last_ws" ]]; then
                    last_ws="$wsid"

                    if [[ -n "''${workspace_apps[$wsid]}" ]]; then
                        # Check if workspace has any windows
                        clients=$(hyprctl clients -j | jq "[.[] | select(.workspace.id == $wsid)] | length")

                        if [[ "$clients" -eq 0 ]]; then
                            notify-send -t 2000 "Launching ''${workspace_apps[$wsid]}"
                            ''${workspace_apps[$wsid]} &
                        fi
                    fi
                fi

                sleep 0.3
            done
        '';
      };

      switchFocusedMachineScript = pkgs.writeShellApplication {
        name = "switchFocusedMachineScript";
        runtimeInputs = with pkgs; [ jq ];
        text = ''
          if [ "$#" -ne 1 ]; then
            echo "Usage: switchFocusedMachineScript <0|1>"
            exit 1
          fi

          TARGET="$1"

          # Get current cursor Y position
          Y=$(hyprctl cursorpos -j | jq '.y')

          case "$TARGET" in
            0)
              # Switch to laptop (move cursor far left)
              hyprctl dispatch movecursor -10 "$Y"
              ;;
            1)
              # Switch to PC (move cursor far right)
              hyprctl dispatch movecursor 10000 "$Y"
              ;;
            *)
              echo "Invalid argument: $TARGET (expected 0 or 1)"
              exit 1
              ;;
          esac
        '';
      };

      seamlessFocusNav = pkgs.writeShellApplication {
        name = "seamlessWorkspaceNav";
        runtimeInputs = commonDependencies;
        text = ''
          if [ "$#" -ne 2 ]; then
            echo "Usage: seamlessFocusNav <l|r> <0|1>"
            exit 1
          fi

          DIR="$1"
          FALLBACK="$2"

          # Try to move focus and capture output
          OUTPUT=$(hyprctl dispatch movefocus "$DIR" 2>&1 || true)

          # Hyprland prints this when there is nowhere to move
          if echo "$OUTPUT" | grep -q "does not make sense"; then
            # Get current cursor position
            X=$(hyprctl cursorpos -j | jq '.x')
            Y=$(hyprctl cursorpos -j | jq '.y')

            # Pre-nudge cursor away from edge to ensure crossing triggers lan-mouse
            if [ "$FALLBACK" -eq 1 ]; then
              # moving to PC, nudge left → right
              hyprctl dispatch movecursor $((X - 5)) "$Y"
            else
              # moving to laptop, nudge right → left
              hyprctl dispatch movecursor $((X + 5)) "$Y"
            fi

            # Call the switch script
            ${lib.getExe switchFocusedMachineScript} "$FALLBACK"
          fi
        '';
      };
    };
}
