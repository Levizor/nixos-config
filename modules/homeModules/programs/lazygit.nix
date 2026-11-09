{
  flake.homeModules.lazygit = {
    programs.lazygit = {
      enable = true;
      settings = {
        git = {
          diffRenderers = [
            {
              type = "extDiff";
              command = "difft --color=always --display=inline --background={{colorScheme}} --context={{diffContext}}";
              name = "difftastic (inline)";
            }
            {
              type = "extDiff";
              command = "difft --color=always --display=side-by-side --background={{colorScheme}} --context={{diffContext}}";
              name = "difftastic (side-by-side)";
            }
            {
              type = "rawGit";
              name = "git default";
            }
          ];
        };
      };
    };
  };
}
