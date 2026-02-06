{
  nixosModules.forgejo =
    { pkgs, myopts, ... }:
    {
      services.forgejo = {
        enable = true;
        database.type = "sqlite3";

        settings = {
          server = {
            DOMAIN = myopts.tailscale.address;
            ROOT_URL = "https://${myopts.tailscale.address}:4545/";
            HTTP_PORT = 4545;
            START_SSH_SERVER = false;
          };

          service = {
            DISABLE_REGISTRATION = true;
          };

          actions = {
            ENABLED = true;
          };
        };
      };

    };
}
