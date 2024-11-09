{inputs, pkgs, ...}:
{
  imports = [
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
}
