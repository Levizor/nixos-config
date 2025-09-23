{
  pkgs,
  inputs,
  lib,
  myopts,
  config,
  ...
}:
let
  toggleSessionScript = pkgs.writeShellApplication {
    name = "toggleTmuxSessionScript";
    runtimeInputs = with pkgs; [
      tmux
      tmuxp
    ];
    text = ''
      current_session=$(tmux display-message -p '#{session_name}'); 
      dashboard_exists=$(tmux list-sessions | grep -c '^dashboard:'); 
      last_session=$(tmux show-options -gqv @last_session); 
      if [ "$current_session" = "dashboard" ]; then 
        if [ -n "$last_session" ] && tmux has-session -t "$last_session" 2>/dev/null; then 
          tmux set-option -g @last_session "$current_session"; 
          tmux switch-client -t "$last_session"; 
        else 
          tmux switch-client -t dev; 
        fi; 
      else 
        tmux set-option -g @last_session "$current_session"; 
        if [ "$dashboard_exists" -eq 0 ]; then 
          tmuxp load -d dashboard; 
          sleep 0.5; 
        fi; 
        tmux switch-client -t dashboard; 
      fi
    '';
  };

  rebuildScript = pkgs.writeShellApplication {
    name = "rebuild";
    runtimeInputs = with pkgs; [
      libnotify
    ];

    text = ''
      host="laptop"

      notify-send -t 3000 "🔧 Starting NixOS rebuild on $host..."

      if nh os switch -H "$host"; then
        notify-send -t 5000 "✅ NixOS rebuild on $host succeeded!"
      else
        notify-send -t 5000 "❌ NixOS rebuild on $host failed!"
      fi

    '';

  };

  tmuxRebuildBind = pkgs.writeShellApplication {
    name = "rebuildBind";
    runtimeInputs = with pkgs; [
      tmux
      tmuxp
      libnotify
    ];

    text = ''
      # Usage:
      silent=false

      # Parse optional -s flag
      if [[ "''${1:-}" == "-s" ]]; then
        silent=true
        shift
      fi

      TARGET_WINDOW="nix-rebuild"
      CMD="${lib.getExe rebuildScript}"

      current_session=$(tmux display-message -p '#{session_name}')
      dashboard_exists=$(tmux list-sessions | grep -c '^dashboard:')

      if $silent; then
        # Silent mode: only send command to dashboard
        if [[ "$dashboard_exists" -eq 0 ]]; then
          echo "Dashboard session not running!"
          exit 1
        fi
        tmux send-keys -t "dashboard:''${TARGET_WINDOW}" "$CMD" C-m
        exit 0
      fi

      # Normal toggle mode
      if [ "$current_session" = "dashboard" ]; then
        # Already in dashboard → switch to target window + run command
        tmux select-window -t "dashboard:''${TARGET_WINDOW}"
        tmux send-keys -t "dashboard:''${TARGET_WINDOW}" "$CMD" C-m
      else
        # Coming from another session
        tmux set-option -g @last_session "$current_session"
        if [ "$dashboard_exists" -eq 0 ]; then
          tmuxp load -d dashboard
          sleep 0.5
        fi
        tmux switch-client -t dashboard
        tmux select-window -t "dashboard:''${TARGET_WINDOW}"
        tmux send-keys -t "dashboard:''${TARGET_WINDOW}" "$CMD" C-m
      fi

    '';

  };
in
{
  programs.tmux = {
    shortcut = if myopts.server then "a" else "b";
    enable = true;
    focusEvents = true;
    mouse = true;
    keyMode = "vi";
    clock24 = true;
    tmuxp.enable = true;
    newSession = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "xterm-kitty";

    extraConfig = ''

      set -s set-clipboard on
      set -gq allow-passthrough on
      set -g visual-activity off

      bind-key C-p display-popup -E -w 80% -h 80% -T "TMS" "tms"
      bind-key C-s display-popup -E -w 80% -h 80% -T "Switch session" "tms switch"
      bind -n C-S-p display-popup -E -w 80% -h 80% -T "TMS" "tms"
      bind -n C-S-s display-popup -E -w 80% -h 80% -T "Switch session" "tms switch"

      # Switch between windows using Alt + [number]
      bind -n M-1 select-window -t 1
      bind -n M-2 select-window -t 2
      bind -n M-3 select-window -t 3
      bind -n M-4 select-window -t 4
      bind -n M-5 select-window -t 5
      bind -n M-6 select-window -t 6
      bind -n M-7 select-window -t 7
      bind -n M-8 select-window -t 8
      bind -n M-9 select-window -t 9
      bind -n M-0 select-window -t 0


      # Move between windows 
      bind -n M-C-Left previous-window
      bind -n M-C-Right next-window
      bind -n M-C-h previous-window
      bind -n M-C-l next-window

      # Swap windows

      bind -n M-C-S-Left swap-window -t -1 \; select-window -t -1

      bind -n M-C-S-Right swap-window -t +1 \; select-window -t +1

      # Vim-style pane navigation (Alt + h/j/k/l)
      bind -n M-h select-pane -L
      bind -n M-j select-pane -D
      bind -n M-k select-pane -U
      bind -n M-l select-pane -R

      # Arrow key analogs (Alt + ← ↓ ↑ →)
      bind -n M-Left  select-pane -L
      bind -n M-Down  select-pane -D
      bind -n M-Up    select-pane -U
      bind -n M-Right select-pane -R

      bind -n M-H swap-pane -t -1
      bind -n M-L swap-pane -t +1
      bind -n M-J swap-pane -D
      bind -n M-K swap-pane -U


      bind -n M-q kill-pane
      bind -n C-q kill-window

      bind -n M-f resize-pane -Z 
      bind-key f resize-pane -Z 

      bind c new-window -c "#{pane_current_path}"
      bind '"' split-window -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"     
      set -g escape-time 0

      bind -n M-d run-shell "${lib.getExe toggleSessionScript}"
      bind -n M-r run-shell "${lib.getExe tmuxRebuildBind}"
      bind -n M-R run-shell "${lib.getExe tmuxRebuildBind} -s"
    '';

    plugins = with pkgs.tmuxPlugins; [
      better-mouse-mode

      {
        plugin = extrakto;
      }

      {
        plugin = inputs.minimal-tmux.packages.${pkgs.system}.default;
        extraConfig =
          if !myopts.server then
            ''
              set -g status-bg black
              set -g @minimal-tmux-fg "black"
              set -g @minimal-tmux-bg "blue"
              set -g @minimal-tmux-use-arrow true
              bind-key b set-option status
              set -g @minimal-tmux-expanded-icon "󰊓 "
              set -g @minimal-tmux-show-expanded-icons-for-all-tabs true

              set -g @minimal-tmux-indicator-str "  #S  "
              set -g @minimal-tmux-status-left-extra "#(${lib.getExe pkgs.hyprland-workspaces-tui} plain -p true)"
              set -g @minimal-tmux-status-right "\
              #( \
                vol=\$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print \$2}'); \
                if [ \"\$vol\" = yes ]; then \
                  echo -n '🔇'; \
                else \
                  echo -n '🔊'; \
                fi; \
                echo -n ' | '; \
                upower -i \$(upower -e | grep 'BAT') | \
                  awk '/state:/ { if (\$2==\"discharging\") icon=\"🔋\"; else if (\$2==\"fully-charged\") icon=\"✅\"; else icon=\"⚡\" } \
                       /percentage:/ { print icon \$2 }'; \
              ) | %H:%M"
              set -g status-left-length 20
              set -g status-interval 1
            ''
          else
            "";
      }
    ];

  };

  home.file.".tmuxp/dashboard.yaml".text = ''
    session_name: dashboard
    windows:
      - window_name: nix-rebuild
        panes: 
          - shell_command:
              - cd ~/nix/; ${lib.getExe pkgs.neofetch}
      - window_name: btop
        panes:
          - shell_command:
              - btop
      - window_name: tray-tui
        panes:
          - shell_command:
              - tray-tui
  '';

  home.file.".tmuxp/dev.yaml".text = ''
    session_name: dev
    windows:
      - window_name: main
        panes:
          - shell_command:
              - # empty, bare shell
      - window_name: nix
        panes:
          - shell_command:
              - cd ~/nix/ 
  '';

  home.file.".tmuxp/pw.yaml".text = ''
    session_name: pw
    windows:
      - window_name: nvim
        layout: main-horizontal
        options:
          main-pane-height: 99%
        panes:
          - cd ~/Projects/pw/; nvim
      - window_name: server
        shell_command_before:
          - cd ~/Projects/pw/
        panes:
          - shell_command:
              - nohup floorp http://localhost:1111
              - zola serve
  '';

  home.file.".config/hyprland-workspaces-tui/config.toml".text = ''
    [plain_text_mode]
    separator = " "
    print_once = true
  '';

  home.file.".config/tms/config.toml".text = ''
    default_session = "scratchpad"

    [[search_dirs]]
    path = "${config.home.homeDirectory}/Projects"
    depth = 10
  '';

  home.packages = with pkgs; [
    tmux-sessionizer
  ];
}
