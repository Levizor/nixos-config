{ inputs, pkgs, ... }:
{
  imports = [
    ./ssh.nix
    ./zathura.nix
    ./btop.nix
    ./fuzzel.nix
    ./floorp.nix
    ./git.nix
    ./lsd.nix
    ./mako.nix
    ./cava.nix
    ./nh.nix
  ];
  programs.brave.enable = true;

}
