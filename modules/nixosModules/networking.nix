{
  flake.nixosModules.networking =
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
            "tailscale0"
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
    };
}
