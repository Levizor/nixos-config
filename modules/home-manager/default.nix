{
  config,
  pkgs,
  lib,
  outputs,
  inputs,
  myopts,
  ...
}:
{
  home-manager = {
    extraSpecialArgs = {
      inherit inputs outputs myopts;
    };
    backupFileExtension = "backup";
    users.levizor = {
      imports = [
        ./wm
        ./zsh
        ./packages.nix
        ./programs
        ./terminals
      ];

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

    };

  };
}
