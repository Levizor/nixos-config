{
  inputs,
  outputs,
  config,
  modulesPath,
  mylib,
  lib,
  ...
}:
{

  # nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  networking.firewall.enable = lib.mkForce false;

  myopts.hostName = "nixiso";

  imports = [
    inputs.stylix.nixosModules.stylix
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
    ../../modules/stylix
    ../../modules/home-manager
  ]
  ++ mylib.useModules ./../../modules/nixos [
    "common"
    "hardware"
    "battery"
    "graphical"
    "networking"
    "printing"
    "sound"
    "nvim"
    "filesystems"
    "environment"
  ];

  home-manager.extraSpecialArgs = {
    inherit (config) myopts;
  };

  isoImage.squashfsCompression = "gzip -Xcompression-level 1";
}
