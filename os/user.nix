{ config, lib, pkgs, modulesPath, ... }:
{
  users.users.levizor= {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" "NetworkManager" "input" "audio" "wireshark"]; # Enable ‘sudo’ for the user.
  };


}
