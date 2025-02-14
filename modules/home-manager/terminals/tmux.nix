{
  pkgs,
  inputs,
  lib,
  ...
}:
{
  programs.tmux = {
    enable = true;
    mouse = true;
    keyMode = "vi";
    clock24 = true;
    tmuxp.enable = true;
    newSession = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "foot";

    extraConfig = ''

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
      bind -n C-Left previous-window
      bind -n C-Right next-window

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

      bind -n M-S-Left swap-pane -t -1
      bind -n M-S-Right swap-pane -t +1
      bind -n M-S-Down swap-pane -D
      bind -n M-S-Up swap-pane -U

      bind -n M-q kill-pane
      bind -n C-q kill-window

      bind -n M-f resize-pane -Z 
      bind-key f resize-pane -Z 
      set -g escape-time 0
    '';

    plugins = with pkgs.tmuxPlugins; [
      better-mouse-mode
      battery
      {
        plugin = extrakto;
      }

      {
        plugin = inputs.minimal-tmux.packages.${pkgs.system}.default;
        extraConfig =
          # let
          #   tmuxUpdateScript = pkgs.writeShellScriptBin "tmuxUpdateScript" ''
          #     while true;
          #     do
          #       pgrep tmux &>/dev/null || break
          #       tmux refresh-client -S;
          #       sleep 0.2;
          #     done &
          #   '';
          # in
          ''
            # run-shell "\$\{$\{lib.getExe tmuxUpdateScript}}"
            bind-key b set-option status
            set -g @minimal-tmux-status-right "%H:%M"
            set -g @minimal-tmux-status-left-extra "#(/home/levizor/Projects/hwt/target/release/hyprland-workspaces-tui plain -pa ⭐)"
            set -g status-left-length 20
            set -g status-interval 1
          '';
      }
    ];

  };

  home.file.".tmuxp/scratchpad.yaml".text = ''
    session_name: scratchpad
    windows:
      - window_name: dashboard
        layout: main-horizontal
        options:
          main-pane-height: 99%
        panes:
          - focus: true
          - hyprland-workspaces-tui -t dracula
      - window_name: nix
        panes:
          - cd ~/nix; nvim .
  '';
}
