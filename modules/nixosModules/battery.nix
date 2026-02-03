{
  flake.nixosModules.battery = {
    services = {
      tlp.enable = true;
      upower = {
        enable = true;
      };
    };
  };
}
