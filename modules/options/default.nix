{ lib, ... }:
{
  options = {
    myopts.additionalPackages = lib.mkEnableOption "Enable additional packages in Home Manager";
  };

  config = {
    myopts.additionalPackages = false;
  };

}
