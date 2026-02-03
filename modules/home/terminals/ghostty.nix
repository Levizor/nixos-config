{
  flake.homeModules.ghostty = {
    programs.ghostty = {
      enable = true;
      enableZshIntegration = true;
      installBatSyntax = true;
      installVimSyntax = true;
    };
  };
}
