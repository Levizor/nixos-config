{config, pkgs, ...}:
{
  programs.nh = {
    enable = true;
    flake = "/home/levizor/nix";
  };
}
