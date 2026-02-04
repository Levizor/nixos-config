{ inputs, ... }:
{
  flake.homeModules.lan-mouse = {
    imports = [
      inputs.lan-mouse.homeManagerModules.default
    ];

    programs.lan-mouse = {
      enable = true;
      systemd = true;
    };
  };
}
