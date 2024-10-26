{inputs, pkgs, ...}:
{

  # fonts.packages = with pkgs; [
  #   (nerdfonts.override {fonts = ["FiraCode" "DroidSansMono"];})
  # ];
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
