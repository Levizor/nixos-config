{ inputs, ... }:
{
  flake.homeModules.vicinae =
    { pkgs, ... }:
    {
      imports = [
        inputs.vicinae.homeManagerModules.default
      ];
      services.vicinae = {
        enable = true;
        systemd = {
          enable = true;
          autoStart = true;
          environment = {
            QT_SCALE_FACTOR = 1.25;
          };
        };
      };
    };
}
