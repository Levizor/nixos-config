{
  inputs,
  pkgs,
  nixpkgs,
  lib,
  ...
}:
{
  imports = [
    inputs.stylix.nixosModules.stylix
    ./cyberdream.nix
  ];
  stylix = {
    enable = true;
    targets = {
      qt.enable = true;
      gtk.enable = true;
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
