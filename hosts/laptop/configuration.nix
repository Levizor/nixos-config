{
  pkgs,
  inputs,
  outputs,
  config,
  lib,
  ...
}:
{
  nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystem = true;
  };

  myopts = {
    additionalPackages = true;
    steam = true;
  };

  imports = [
    ./hardware-configuration.nix
    ./disko-config.nix
    inputs.disko.nixosModules.disko

    ../../modules/nixos

    ../../modules/home-manager
    inputs.home-manager.nixosModules.home-manager

    ../../modules/stylix
    inputs.stylix.nixosModules.stylix
    ./tailscale.nix
  ];

  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];

  boot.kernelModules = [ "v4l2loopback" ];

  home-manager.extraSpecialArgs = {
    inherit (config) myopts;
  };

  programs = {
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        icu
      ];
    };
  };

  programs.gamemode.enable = true;

  virtualisation = {
    docker = {
      enable = true;
    };

    libvirtd = {
      enable = true;
    };
  };

  programs.virt-manager.enable = true;
  environment.systemPackages = with pkgs; [
    wget
    quickemu
  ];
}
