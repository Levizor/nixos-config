{
  flake.homeModules.kdeconnect = {
    services.kdeconnect = {
      enable = true;
      indicator = true;
    };
  };
}
