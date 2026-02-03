{
  flake.homeModules.fzf = {
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
      tmux = {
        enableShellIntegration = true;
      };
    };
  };
}
