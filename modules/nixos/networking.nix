{
  pkgs,
  lib,
  ...
}:
{
  networking = {
    firewall = {
      enable = true;
      trustedInterfaces = [
        "docker0"
      ];
    };
    networkmanager = {
      enable = true;
      plugins = with pkgs; [
        networkmanager-openvpn
        networkmanager-sstp
      ];
    };
  };

  specialisation."noFirewall".configuration = {
    networking.firewall.enable = lib.mkForce false;
  };
}
