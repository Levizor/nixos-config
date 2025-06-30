{ lib, ... }:
{
  programs.hyprlock = {
    enable = true;
    settings = lib.mkForce {
      general = {
        grace = 300;
        hide_cursor = true;
      };

      background = [
        {
          path = "screenshot";
          blur_passes = 3;
          blur_size = 8;
        }
      ];

    };
  };
}
