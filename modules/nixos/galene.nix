{ config, ... }:
{
  services.galene = {
    enable = true;
    insecure = true;
    httpPort = 8443;
    httpAddress = "https://${config.myopts.tailscale.address}";
  };
}
