{ pkgs, lib, ... }:
{
  services = {
    minecraft-servers = {
      enable = true;
      eula = true;

      servers.smp = {
        enable = true;

        serverProperties = {
          server-port = 25566;
        };
      };

    };

  };
}
