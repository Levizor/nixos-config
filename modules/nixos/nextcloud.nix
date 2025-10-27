{ config, myopts, ... }:
{
  services.nextcloud = {
    enable = true;

    hostName = config.networking.hostName;
    https = false;

    config.trusted_domains = [
      config.hostName
    ];
    cron.enable = true;

  };
}
