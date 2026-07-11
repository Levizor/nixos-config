{ self, ... }:
{
  flake.homeModules.wm = {
    imports = with self.homeModules; [
      hyprland
      hyprlock
      mako
      wlogout
    ];
  };
}
