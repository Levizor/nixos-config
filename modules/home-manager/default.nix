{
  config,
  pkgs,
  lib,
  mylib,
  outputs,
  inputs,
  myopts,
  system,
  user,
  ...
}:
let
  stateVersion = "25.05";
in
{
  home-manager = {
    extraSpecialArgs = {
      inherit
        inputs
        outputs
        myopts
        mylib
        system
        user
        ;
    };

    backupFileExtension = "backup";

    users.root = {
      imports = [
        ./zsh
        ./terminals
      ];
      home = {
        username = "root";
        homeDirectory = "/root";
        stateVersion = stateVersion;
      };
    };

    users."${user}" = {
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
        username = user;
        homeDirectory = "/home/${user}";
        stateVersion = stateVersion;
      };

    };

  };
}
