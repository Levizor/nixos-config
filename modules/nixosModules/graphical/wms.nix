{ inputs, ... }:
{

  flake.nixosModules.hyprland = {
    programs.hyprland = {
      enable = true;
      # package = null;
      # portalPackage = null;
      # package = inputs.stable.legacyPackages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      # portalPackage =
      #   inputs.stable.legacyPackages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
  };

  flake.nixosModules.wayfire = {
    programs.wayfire = {pkgs, ...}:{
      enable = false;
      plugins = with pkgs.wayfirePlugins; [
        wcm
        wf-shell
        wayfire-plugins-extra
      ];
    };
  };

  flake.nixosModules.niri = {
    programs.niri = {
      enable = true;
    };
  };
  
  flake.nixosModules.umbriel = {
    programs.umbriel = {
      enable = true;
    };
  };  

  flake.nixosModules.mango = {
    programs.mango = {
      enable = true;
    };
  };

  flake.nixosModules.i3 = {
    services.xserver.windowManager = {
      i3 = {
        enable = true;
      };
    };
  };
}
