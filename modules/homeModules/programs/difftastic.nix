{
  flake.homeModules.difftastic = {
    programs.difftastic = {
      enable = true;
      git.enable = true;
      git.mode = "both";
      jujutsu.enable = true;

      options = {
        color = "always";
        sort-paths = true;
      };
    };
  };
}
