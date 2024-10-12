{lib, ...}:
{
  programs.wpaperd = {
    enable = true;

    settings = {
      default = {
        duration = "12h";
        mode = "center";
        sorting = "ascending"; 
      };

      any = {
        path = lib.mkForce "/home/levizor/Pictures/Wallpapers/moons.jpg";
      };


    };

  };
}
