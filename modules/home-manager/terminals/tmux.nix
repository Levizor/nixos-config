{ pkgs, inputs, ... }:
let
  latest = import (pkgs.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs";
    rev = "af5d88b95c92d42c7b9fa8405bb9a43ded847e32";
    hash = "sha256-kxrtJ3/ishxpWENPHfy2JruM+A8x9XT/gnsqNkE1R5Q=";
  }) { system = "x86_64-linux"; };
in
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

    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode

      {
        plugin = latest.tmuxPlugins.resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-vim 'session'
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-capture-pane-contents 'on'
        '';
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-boot 'on'
          set -g @continuum-save-interval '10'
        '';
      }
      {
        plugin = tmuxPlugins.extrakto;
      }
      { plugin = inputs.minimal-tmux.packages.${pkgs.system}.default; }
    ];

  };
}
