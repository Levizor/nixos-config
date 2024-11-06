{lib, ...}: {
  programs.wpaperd = {
    enable = true;

    settings = {
      default = {
        duration = "12h";
        mode = "center";
        sorting = "random";
        initial-transition = true;
        transition-time = 1000;
        transition = {
          doom = {};
          # dissolve = { line-width = 0.05;
          #   spread-clr = [0.37 0.51 0.67];
          #   hot-clr = [0.71 0.56 0.68];
          #   intensity = 0.1;
          # };
        };
      };

      any = {
        path = lib.mkForce "/home/levizor/Pictures/Wallpapers/Nord/";
      };
    };
  };
}
