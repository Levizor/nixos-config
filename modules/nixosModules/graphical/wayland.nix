{ inputs, ... }:
{
  flake.nixosModules.wayland =
    { pkgs, ... }:
    {
      imports = [ inputs.mango.nixosModules.mango ];

      programs = {
        hyprland = {
          enable = true;
          package = inputs.stable.legacyPackages.${pkgs.stdenv.hostPlatform.system}.hyprland;
          portalPackage =
            inputs.stable.legacyPackages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
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

      environment.systemPackages = with pkgs; [
        wl-clipboard
      ];

    };
}
