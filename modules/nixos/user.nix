{ config, lib, pkgs, modulesPath, ... }:
{
  users.defaultUserShell = pkgs.zsh;
  users.users.levizor= {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "input" "audio" "wireshark"]; # Enable ‘sudo’ for the user.
  };


}
