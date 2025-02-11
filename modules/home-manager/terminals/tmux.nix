{ pkgs, inputs, ... }:
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

      bind-key f resize-pane -Z 
    '';

    plugins = with pkgs.tmuxPlugins; [
      better-mouse-mode
      battery
      {
        plugin = extrakto;
      }

      {
        plugin = inputs.minimal-tmux.packages.${pkgs.system}.default;
        extraConfig = ''
          bind-key b set-option status
          set -g @minimal-tmux-status-right "%H:%M"
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
