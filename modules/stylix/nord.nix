{inputs, pkgs, nixpkgs, lib, ...}:
{

  # fonts.packages = with pkgs; [
  #   (nerdfonts.override {fonts = ["FiraCode" "DroidSansMono"];})
  # ];

  environment.systemPackages = with pkgs;
    [
      libsForQt5.qt5ct
      libsForQt5.qtstyleplugin-kvantum
    ];
  environment.variables.QT_QPA_PLATFORMTHEME = lib.mkForce "qt5ct";

  nixpkgs.config.qt5 = {
    enable = true;
    platformTheme = "qt5ct";
    style = {
      package = pkgs.utterly-nord-plasma;
      name = "Utterly Nord Plasma";
    };
  };

  stylix={
    enable = true;
    image = ./moons.jpg;

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
        package = pkgs.nerdfonts.override {fonts = ["FiraCode"];};
        name = "FiraCodeNerdFont";
      };

      sansSerif = {
        package = pkgs.nerdfonts.override {fonts = ["FiraCode"];};
        name = "FiraCodeNerdFont";
      };

      monospace = {
        package = pkgs.nerdfonts.override {fonts = ["FiraCode"];};
        # package = pkgs.dejavu_fonts;
        name = "FiraCodeNerdFontMono";
      };

    };
  };
}
