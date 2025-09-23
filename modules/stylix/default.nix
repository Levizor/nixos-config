{
  inputs,
  pkgs,
  nixpkgs,
  lib,
  ...
}:
{
  imports = [ ./cyberdream.nix ];
  stylix = {
    enable = true;
    targets = {
      qt.enable = true;
      gtk.enable = true;
      zen-browser.profileNames = ["profile_0"];
    };

    fonts = {
      sizes = {
        terminal = 16;
        desktop = 14;
      };

      serif = {
        package = pkgs.fira-sans;
        name = "Fira Sans";
      };

      sansSerif = {
        package = pkgs.fira-sans;
        name = "Fira Sans";
      };

      monospace = {
        package = pkgs.nerd-fonts.fira-code;
        name = "FiraCode Nerd Font Mono";
      };
    };
  };
}
