{ config, pkgs, ... }:

{
  programs.ssh = {
    enableDefaultConfig = true;
    enable = true;
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "levizor";
        identityFile = "~/.ssh/github";
        identitiesOnly = true;
      };

      "aur.archlinux.org" = {
        user = "aur";
        identityFile = "~/.ssh/aur";
      };
    };
  };
}
