{ self, inputs, ... }:
{
  flake.nixosModules.home-manager =
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

        backupCommand = "sh -c 'rm -f \"$1\".backup && mv \"$1\" \"$1\".backup' --";

        users."${user}" = {
          imports = [
            self.homeModules.common
          ];
        };
      };
    };

  flake.homeModules.common = { config, user, ... }: {
    home = {

      enableNixpkgsReleaseCheck = false;
      username = user;
      homeDirectory = "/home/${user}";
      stateVersion = "26.05";

      sessionVariables = {
        STEAM_EXTRA_COMPAT_TOOLS_PATHS = "$\{HOME}/.local/Steam/compatabilitytools.d";
        CARGO_HOME = "${config.xdg.dataHome}/.local/share/cargo";
        XDG_CACHE_HOME = "${config.home.homeDirectory}/.cache";
        # XDG_STATE_HOME = "${config.home.homeDirectory}/.local/.state";
      };

      sessionPath = [
        "$HOME/.local/share/cargo/bin/"
      ];
    };

    xsession.initExtra = "xrdb -merge $XDG_CONFIG_HOME/X11/xresources";

    xdg = {
      enable = true;
    };

  };
}
