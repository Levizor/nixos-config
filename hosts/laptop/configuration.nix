{
  pkgs,
  inputs,
  mylib,
  outputs,
  config,
  lib,
  ...
}:
{
  networking.hostName = "nixlaptop";

  myopts = {
    additionalPackages = true;
    nh.host = "laptop";
  };

  imports = [
    ./hardware-configuration.nix
    ./disko-config.nix
    inputs.disko.nixosModules.disko

    ../../modules/home-manager

    ../../modules/stylix
    inputs.stylix.nixosModules.stylix
  ]
  ++ mylib.useModules ./../../modules/nixos [
    "common"
    "battery"
    "console"
    "environment"
    "filesystems"
    "flatpak"
    "graphical"
    "hardware"
    "networking"
    "nvim"
    "printing"
    "sound"
    "steam"
    "tailscale"
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

  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
  };

  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [
    quickemu
  ];
}
