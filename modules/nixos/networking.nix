{ pkgs, lib, ... }:
{
  specialisation."noFirewall".configuration = {
    networking.firewall.enable = lib.mkForce false;
  };
  networking = {
    hostName = "nixos";
    firewall = {
      enable = true;
      trustedInterfaces = [
        "docker0"
      ];
    };
    networkmanager = {
      enable = true;
      plugins = with pkgs; [
        networkmanager-sstp
      ];
    };
  };
}
