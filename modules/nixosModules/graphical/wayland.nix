{ inputs, ... }:
{
  flake.nixosModules.wayland =
    { pkgs, ... }:
    {
      imports = [ inputs.mango.nixosModules.mango ];

      programs = {
        hyprland = {
          enable = true;
          # package = null;
          # portalPackage = null;
          # package = inputs.stable.legacyPackages.${pkgs.stdenv.hostPlatform.system}.hyprland;
          # portalPackage =
          #   inputs.stable.legacyPackages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
        };

        wayfire = {
          enable = false;
          plugins = with pkgs.wayfirePlugins; [
            wcm
            wf-shell
            wayfire-plugins-extra
          ];
        };

        niri = {
          enable = false;
        };

        mango = {
          enable = true;
        };
      };

      services.xserver.windowManager = {
        qtile = {
          enable = true;
        };
        i3 = {
          enable = true;
        };
      };

      environment.systemPackages = with pkgs; [
        wl-clipboard
      ];

    };
}
