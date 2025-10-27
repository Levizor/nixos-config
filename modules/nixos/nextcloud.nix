{
  config,
  myopts,
  pkgs,
  ...
}:
let
  hostName = config.networking.hostName;
in
{
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud32;

    hostName = hostName;
    https = true;

    settings = {
      trusted_domains = [ myopts.tailscale.address ];
      overwritewebroot = "/nextcloud";
    };

    config = {
      dbtype = "sqlite";
      adminpassFile = "/var/lib/nextcloud/admin-pass-secret";
    };
  };

}
