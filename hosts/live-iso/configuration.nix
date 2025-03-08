{
  inputs,
  outputs,
  config,
  modulesPath,
  lib,
  ...
}:
{
  nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystem = true;
  };
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  networking.firewall.enable = false;
  networking.networkmanager.enable = lib.mkForce false;
  services.openssh.enable = true;

  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    ../../modules/nixos
    inputs.disko.nixosModules.disko
    inputs.stylix.nixosModules.stylix
    ../../modules/stylix

    ../../modules/home-manager
    inputs.home-manager.nixosModules.home-manager
  ];
  home-manager.extraSpecialArgs = {
    inherit (config) myopts;
  };

  isoImage.squashfsCompression = "gzip -Xcompression-level 1";
}
