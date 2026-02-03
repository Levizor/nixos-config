{
  flake.homeModules.fuzzel = {
    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          terminal = "kitty -1";
        };
      };
    };
  };
}
