{pkgs, ...}:
{

  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = ["FiraCode" "DroidSansMono"];})
  ];
  stylix={
    enable = true;

    polarity = "either";
    image = ./moons.jpg;
    targets = {
    	grub.useImage = true;
    };

    opacity = {
	terminal = 0.7;
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
