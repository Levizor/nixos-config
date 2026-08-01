{
  flake.homeModules.fzf = {
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      tmux = {
        enableShellIntegration = true;
      };
    };
  };
}
