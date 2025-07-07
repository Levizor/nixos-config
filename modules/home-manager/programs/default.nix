{ inputs, pkgs, ... }:
{
  imports = [
    ./ssh.nix
    ./zathura.nix
    ./btop.nix
    ./fuzzel.nix
    ./firefox.nix
    ./git.nix
    ./lsd.nix
    ./mako.nix
    ./cava.nix
    ./nh.nix
    ./chromium.nix
  ];
}
