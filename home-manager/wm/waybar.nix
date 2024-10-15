{pkgs, ...}:
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
    layer = "top";
    position = "top";
    height = 30;
    output = [
      "eDP-1"
      "HDMI-A-1"
    ];
    modules-left = [ "hyprland/workspaces" "hyprland/language" ];
    modules-center = [ "hyprland/window" "custom/hello-from-waybar" ];
    modules-right = [ "temperature" ];

    "hyprland/workspaces" = {
      disable-scroll = true;
      all-outputs = true;
    };
    "custom/hello-from-waybar" = {
      format = "hello {}";
      max-length = 40;
      interval = "once";
      exec = pkgs.writeShellScript "hello-from-waybar" ''
        echo "from within waybar"
      '';
    };
  };
    };
  };
}
