{ inputs, ... }:
{
  flake.nixosModules.common =
    {
      config,
      system,
      user,
      ...
    }:
    {
      imports = [
        inputs.home-manager.nixosModules.home-manager
      ];
      home-manager = {
        extraSpecialArgs = {
          inherit
            system
            user
            ;
          inherit (config) myopts;
        };

        backupFileExtension = "backup";

        users."${user}" = {
          home = {
            sessionVariables.STEAM_EXTRA_COMPAT_TOOLS_PATHS = "$\{HOME}/.local/Steam/compatabilitytools.d";
            sessionPath = [
              "$HOME/.cargo/bin/"
            ];

            enableNixpkgsReleaseCheck = false;
            username = user;
            homeDirectory = "/home/${user}";
            stateVersion = "26.05";
          };
        };
      };
    };
}
