{ lib, ... }:
{
  options = {
    myopts = {
      additionalPackages = lib.mkEnableOption "Enable additional packages in Home Manager";
      steam = lib.mkEnableOption "Enable steam";
    };
  };

  config = {
    myopts = {
      additionalPackages = lib.mkDefault false;
      steam = lib.mkDefault false;
    };
  };

}
