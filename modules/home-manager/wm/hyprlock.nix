{ lib, ... }:
{
  programs.hyprlock = {
    enable = true;
    settings = lib.mkForce {
      general = {
        grace = 300;
        hide_cursor = true;
        no_fade_in = false;
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
