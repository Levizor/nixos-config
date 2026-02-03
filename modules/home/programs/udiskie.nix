{
  flake.homeModules.udiskie = {
    services.udiskie = {
      enable = true;
      tray = "always";
    };
  };
}
