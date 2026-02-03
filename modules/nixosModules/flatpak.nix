{
  flake.nixosModules.flatpak = {
    services.flatpak.enable = true;
    xdg.portal.enable = true;
  };
}
