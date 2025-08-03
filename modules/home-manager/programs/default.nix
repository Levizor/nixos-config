{ inputs, pkgs, ... }:
{
  imports = [
    ./distrobox.nix
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

  programs.mpv.enable = true;
}
