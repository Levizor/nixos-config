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

      input-field = {
        size = "200, 50";
        position = "0, -20";
        halign = "center";
        valign = "center";
        outer_color = "rgb(151515)";
        inner_color = "rgb(200, 200, 200)";
        font_color = "rgb(10, 10, 10)";
        placeholder_text = "<i>Input Password...</i>";
        rounding = -1;
      };

    };
  };
}
