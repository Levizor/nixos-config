{ config, lib, pkgs, modulesPath, ... }:
{
  users.users.levizor= {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" "NetworkManager" "input" "audio" "jackaudio"]; # Enable ‘sudo’ for the user.
  };
}
