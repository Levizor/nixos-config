{ pkgs, ... }:
{
  programs = rec {
    steam = {
      enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
    gamemode.enable = true;
  };

  hardware = {
    graphics.enable = true;
    graphics.enable32Bit = true;
  };
}
