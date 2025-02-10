{ pkgs, ... }:
{
  stylix = {

    polarity = "dark";
    image = ./moons.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/synth-midnight-dark.yaml";

    cursor = {
      package = pkgs.phinger-cursors;
      name = "phinger-cursors-dark";
      size = 32;
    };
    opacity = {
      terminal = 0.6;
    };

  };
}
