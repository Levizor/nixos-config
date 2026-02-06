{
  flake.nixosModules.funnel =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      mkFunnel =

        name: localport: publicport: {
          systemd.services."${name}-funnel" = {
            description = "Run Tailscale Funnel on ${name}";

            after = [ "tailscaled.service" ];
            wants = [ "tailscaled.service" ];

            wantedBy = [ "multi-user.target" ];

            serviceConfig = {
              Type = "simple";

              ExecStart = "${lib.getExe pkgs.tailscale} funnel --https ${toString publicport} 127.0.0.1:${toString localport}";

              Restart = "on-failure";
              RestartSec = "10s";

              User = "root";
            };
          };
        };
    in
    lib.mkMerge [
      {
        services.tailscale.enable = true;
      }
      (mkFunnel "searx" 8080 443)
      (mkFunnel "forgejo" 4545 8443)
    ];
}
