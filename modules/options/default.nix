{
  inputs,
  lib,
  config,
  pkgs,
  system,
  ...
}@args:
{
  options = with lib.types; {
    myopts = rec {
      additionalPackages = lib.mkEnableOption "Enable additional packages in Home Manager";
      server = lib.mkEnableOption "Server configuration";
      git = {
        user = lib.mkOption {
          type = str;
          default = null;
        };
        email = lib.mkOption {
          type = str;
          default = null;
        };
      };

      nh.host = lib.mkOption {
        type = str;
        default = "nixos";
      };

      tailscale = {
        magicDns = lib.mkOption {
          type = str;
          example = "worm-chameleon.ts.net";
        };

        hostName = lib.mkOption {
          type = str;
          default = config.networking.hostName;
        };

        address =
          let
            cfg = config.myopts.tailscale;
          in
          lib.mkOption {
            type = str;
            default =
              if (cfg.hostName != "" && cfg.magicDns != null) then
                "${cfg.hostName}.${cfg.magicDns}"
              else
                throw ''
                  The tailscale address is required, but tailscale.hostName or tailscale.magicDns is not provided.
                '';
          };

        ip = lib.mkOption { type = str; };

      };

      monitors = lib.mkOption {
        type = nullOr (
          listOf (
            submodule (
              { config, ... }:
              {
                options = {
                  name = lib.mkOption {
                    type = str;
                  };
                  config = lib.mkOption {
                    type = str;
                  };
                };
              }
            )
          )
        );
        default = null;
      };

      wallpaperPack = lib.mkOption {
        type = str;
        default = "picturesque";
      };

      browser = lib.mkOption {
        type = nullOr package;
        default = inputs.zen-browser.packages."${system}".twilight;
        description = "The browser to use";
      };

    };
  };

  config = {
    myopts = {
      additionalPackages = lib.mkDefault false;
      server = lib.mkDefault false;
    };
  };
}
