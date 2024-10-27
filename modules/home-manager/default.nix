{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: let
  unstable = import <nixos-unstable> {config = {allowUnfree = true;};};
in {
  home-manager = {
    # useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "backup";
    users.levizor = {
      imports = [
        ./wm
        ./zsh/load.nix
        ./packages.nix
        ./programs
        ./terminals
      ];

      home = {
        sessionVariables = {
          STEAM_EXTRA_COMPAT_TOOLS_PATHS = "$\{HOME}/.local/Steam/compatabilitytools.d";
        };
        enableNixpkgsReleaseCheck = false;
        username = "levizor";
        homeDirectory = "/home/levizor";
        stateVersion = "24.05";
      };
      # stylix.targets.hyprpaper.enable = lib.mkForce false;
      stylix.targets.bat.enable = false;

      qt = {
        enable = true;
        platformTheme.name = "qtct";
        style = {
          name = "kvantum";
        };
      };
      xdg.configFile."Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
        General.theme = "Utterly-Nord-Solid";
      };
      xdg.configFile."Kvantum/Utterly-Nord-Solid".source = "${pkgs.utterly-nord-plasma}/share/Kvantum/Utterly-Nord-Solid";
    };
  };
}
