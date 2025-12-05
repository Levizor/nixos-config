{
  pkgs,
  lib,
  ...
}:
{
  networking = {
    wireless = {
      enable = false;
      iwd.enable = true;
    };
    firewall = {
      enable = true;
      trustedInterfaces = [
        "docker0"
      ];
    };
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
      plugins = with pkgs; [
        networkmanager-openvpn
        networkmanager-sstp
      ];
    };
  };

}
