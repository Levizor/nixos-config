{ inputs, ... }:
{
  flake.nixosModules.devcook =
    { pkgs, config, ... }:
    let
      myopts = config.myopts;
    in
    {
      imports = [ inputs.devcook.nixosModules.default ];

      services.devcook = {
        enable = true;
        port = 8080;
        domain = myopts.tailscale.address;
        autoUpdate = {
          enable = true;
          interval = "5m";
          gitRepo = "https://github.com/Levizor/devcook";
        };
      };
    };
}
