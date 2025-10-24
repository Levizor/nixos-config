{
  config,
  pkgs,
  lib,
  ...
}:

{
  services.tailscale.enable = true;

  systemd.services.tailscale-funnel = {
    description = "Run Tailscale Funnel on 127.0.0.1:8080";

    after = [ "tailscaled.service" ];
    wants = [ "tailscaled.service" ];

    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "simple";

      ExecStart = "${lib.getExe pkgs.tailscale} funnel 127.0.0.1:8080";

      Restart = "on-failure";
      RestartSec = "10s";

      User = "root";
    };
  };
}
