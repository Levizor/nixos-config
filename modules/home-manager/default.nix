{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
    };
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

      xdg.enable = true;

      home = {
        sessionVariables = {
          STEAM_EXTRA_COMPAT_TOOLS_PATHS = "$\{HOME}/.local/Steam/compatabilitytools.d";
        };
        sessionPath = [
          "$HOME/.cargo/bin/"
        ];

        enableNixpkgsReleaseCheck = false;
        username = "levizor";
        homeDirectory = "/home/levizor";
        stateVersion = "24.05";
      };

      qt.enable = true;

      # qt = {
      #   enable = true;
      #   platformTheme.name = "qtct";
      #   style = {
      #     name = "kvantum";
      #   };
      # };
      # xdg.configFile."Kvantum/kvantum.kvconfig".source =
      #   (pkgs.formats.ini { }).generate "kvantum.kvconfig"
      #     {
      #       General.theme = "Utterly-Nord-Solid";
      #     };
      # xdg.configFile."Kvantum/Utterly-Nord-Solid".source =
      #   "${pkgs.utterly-nord-plasma}/share/Kvantum/Utterly-Nord-Solid";
    };
  };
}
