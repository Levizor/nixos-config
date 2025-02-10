{ pkgs, ... }:
{
  stylix = {

    polarity = "dark";
    image = ./moons.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";

    cursor = {
      package = pkgs.nordzy-cursor-theme;
      name = "Nordzy-cursors";
      size = 32;
    };
    opacity = {
      terminal = 0.8;
    };

  };
}
