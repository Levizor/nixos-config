{ inputs, ... }:
{
  flake.nixosModules.cachyos-kernel = { pkgs, ... }: {

    nixpkgs.overlays = [
      inputs.cachyos.overlays.pinned
    ];

    boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;

    nix.settings.substituters = [ "https://cache.lantian.pub/lantian" ];
    nix.settings.trusted-public-keys = [ "lantian:WVGO7vsRMSEN+h7Lp7kv6SAmrkEXgUGbbXm7jMDjBuQ=" ];
  };
}
