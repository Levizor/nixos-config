{ config, ... }:
{
  services.searx = {
    enable = true;
    settings = {
      server = {
        port = "8080";
        bind_address = "0.0.0.0";
        secret_key = "$SEARX_SECRET_KEY";
      };
    };
  };
}
