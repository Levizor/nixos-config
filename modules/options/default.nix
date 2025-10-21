{ lib, ... }:
{
  options = with lib.types; {
    myopts = {
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
      hostName = lib.mkOption {
        type = str;
        default = "nixos";
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
