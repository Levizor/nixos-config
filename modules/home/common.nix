{
  config,
  inputs,
  outputs,
  myopts,
  mylib,
  system,
  user,
  ...
}:
{
  home-manager = {
    extraSpecialArgs = {
      inherit
        inputs
        outputs
        mylib
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
        stateVersion = "25.05";
      };
    };

  };

}
