{
  flake.nixosModules.hardware =
    { pkgs, ... }:
    {
      hardware = {
        enableAllFirmware = false;
        bluetooth.enable = true;
        graphics.enable = true;
        graphics.enable32Bit = true;
      };
      environment.systemPackages = with pkgs; [
        bluetuith
      ];
    };
}
