{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    mouse = true;
    keyMode = "vi";
    clock24 = true;
    tmuxp.enable = true;

    extraConfig = ''
      bind-key f resize-pane -Z 
    '';

    plugins = with pkgs; [
      # {
      #   plugin = tmuxPlugins.resurrect;
      #   extraConfig = ''
      #   set -g @resurrect-strategy-nvim 'session
      #   set -g @plugin 'tmux-plugins/tmux-resurrect'
      #   '';
      # }
      {
        plugin = tmuxPlugins.cpu;
        extraConfig = "set -g @plugin 'tmux-plugins/tmux-cpu'";
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '30' # minutes
          set -g status-right 'CS: #{continuum_status}'
        '';
      }
    ];
      
  };
}
