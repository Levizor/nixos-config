{lib, ...}:
{
  programs.wpaperd = {
    enable = true;

    settings = {
      default = {
        duration = "12h";
        mode = "center";
        sorting = "random";
        initial-transition = true;
        transition = {
          glitch-displace = {

          };
        };
      };

      any = {
        path = lib.mkForce "/home/levizor/Pictures/Wallpapers/Nord/";
      };


    };

  };
}
