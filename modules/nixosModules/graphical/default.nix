{ self, ... }:
{
  flake.nixosModules.graphical = {
    imports = [
      self.nixosModules.xdg
      self.nixosModules.wayland
      self.nixosModules.displayManager
      self.nixosModules.xserver
    ];
  };
}
