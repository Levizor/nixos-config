{ self, ... }:
{
  flake.homeModules.wm = {
    imports = with self.homeModules; [
      hyprland
      hyprlock
      lan-mouse
      mako
      wpaperd
      wlogout
    ];
  };
}
