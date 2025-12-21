{ inputs, ... }:
{
  imports = [
    inputs.lan-mouse.homeManagerModules.default
  ];

  programs.lan-mouse = {
    enable = true;
    systemd = true;
  };
}
