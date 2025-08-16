{ pkgs, ... }:
{
  networking = {
    hostName = "nixos";
    networkmanager = {
      enable = true;
      plugins = with pkgs; [
        networkmanager-sstp
      ];
    };
  };
}
