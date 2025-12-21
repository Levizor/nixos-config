{ pkgs, inputs, ... }:
{
  programs = {
    hyprland = {
      enable = true;
      # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      # portalPackage =
      #   inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
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
  };

  environment.systemPackages = with pkgs; [
    wl-clipboard
  ];

}
