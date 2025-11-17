{ pkgs, ... }:
{
  programs = rec {
    steam = {
      enable = true;
      # remotePlay.openFirewall = true;
      # dedicatedServer.openFirewall = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
    gamemode.enable = steam.enable;
  };
  hardware = {
    graphics.enable = true;
    graphics.enable32Bit = true;
  };
}
