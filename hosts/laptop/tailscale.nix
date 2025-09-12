{ pkgs, ... }:
{
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "server";
  };
}
