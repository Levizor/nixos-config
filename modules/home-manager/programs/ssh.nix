{ config, pkgs, ... }:

{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "levizor";
        identityFile = "~/.ssh/github";
        identitiesOnly = true;
      };
    };
  };
}
