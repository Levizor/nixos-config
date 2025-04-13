{ lib, ... }:
{
  options = {
    myopts = {
      additionalPackages = lib.mkEnableOption "Enable additional packages in Home Manager";
      steam = lib.mkEnableOption "Enable steam";
      sound = lib.mkEnableOption "Enable sound";
      hardware = lib.mkEnableOption "Enable hardware stuff (bluetooth, graphic settings)";
      server = lib.mkEnableOption "Server flag configuration";
    };
  };

  config = {
    myopts = {
      additionalPackages = lib.mkDefault false;
      steam = lib.mkDefault false;
      sound = lib.mkDefault true;
      hardware = lib.mkDefault true;
      server = lib.mkDefault false;
    };
  };

}
