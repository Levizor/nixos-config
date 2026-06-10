{
  flake.nixosModules.steam =
    { pkgs, ... }:
    {
      programs = rec {
        steam = {
          enable = true;
          extraCompatPackages = with pkgs; [
            proton-ge-bin
          ];
        };
        gamemode.enable = true;
      };

      hardware = {
        steam-hardware.enable = true;
        graphics.enable = true;
        graphics.enable32Bit = true;
      };
    };
}
