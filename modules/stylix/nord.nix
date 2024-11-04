{
  inputs,
  pkgs,
  nixpkgs,
  lib,
  ...
}: {
  stylix = {
    enable = true;
    image = ./moons.jpg;
    polarity = "dark";

    cursor = {
      package = pkgs.nordzy-cursor-theme;
      name = "Nordzy-cursors";
      size = 32;
    };

    base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";

    opacity = {
      terminal = 0.8;
    };

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
        package = pkgs.vegur;
        name = "Vegur";
      };

      monospace = {
        package = pkgs.nerdfonts.override {fonts = ["FiraCode"];};
        # package = pkgs.dejavu_fonts;
        name = "FiraCodeNerdFontMono";
      };
    };
  };
}
