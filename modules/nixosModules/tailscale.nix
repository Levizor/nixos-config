{
  flake.nixosModules.tailscale = {
    services.tailscale = {
      enable = true;
      openFirewall = true;
      useRoutingFeatures = "server";
    };
  };
}
