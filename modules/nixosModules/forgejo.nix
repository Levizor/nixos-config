{
  flake.nixosModules.forgejo =
    { pkgs, config, ... }:
    let
      myopts = config.myopts;
    in
    {
      services.forgejo = {
        enable = true;
        lfs.enable = true;
        database.type = "sqlite3";

        settings = {
          server = {
            DOMAIN = myopts.tailscale.address;
            ROOT_URL = "https://${myopts.tailscale.address}:8443/";
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
