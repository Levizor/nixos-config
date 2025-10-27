{ config, ... }:
{
  services.searx = {
    enable = true;
    settings = {
      server = {
        port = "8080";
        bind_address = "0.0.0.0";
        secret_key = "$SEARX_SECRET_KEY";
        base_url = "https://${config.myopts.tailscale.address}";
      };

      search = {
        favicon_resolver = "duckduckgo";
      };
    };
  };
}
