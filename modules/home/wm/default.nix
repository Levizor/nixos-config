{ inputs, ... }:
{
  imports = [
    ./hyprland.nix
    ./wlogout.nix
    ./hyprlock.nix
    ./wpaperd.nix
  ];
}
