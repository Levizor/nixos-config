{pkgs, ...}:
{
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
        package = pkgs.dejavu_fonts;
	# package = pkgs.fira-code-symbols;
        name = "DejaVu Serif";
      };

      sansSerif = {
        # package = pkgs.dejavu_fonts;
	package = pkgs.fira-code-symbols;
        name = "DejaVu Sans";
      };

      monospace = {
        # package = pkgs.dejavu_fonts;
	package = pkgs.fira-code-symbols;
        name = "DejaVu Sans Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
