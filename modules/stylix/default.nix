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
    targets.qt.enable = true;

    fonts = {
      sizes = {
        terminal = 16;
        desktop = 14;
      };

      serif = {
        package = pkgs.vegur;
        name = "Vegur";
      };

      sansSerif = {
        package = pkgs.texlivePackages.opensans;
        name = "Opensans";
      };

      monospace = {
        package = pkgs.nerd-fonts.fira-mono;
        name = "FiraMonoNerdFontMono";
      };
    };
  };
}
