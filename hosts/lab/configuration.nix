{
  inputs,
  system,
  modulesPath,
  pkgs,
  config,
  mylib,
  lib,
  ...
}:
{
  imports = [
    inputs.disko.nixosModules.disko
    inputs.stylix.nixosModules.stylix
    ./hardware-configuration.nix
    ./disko-config.nix
    ./home.nix
    ../../modules/stylix
    ./cage.nix
  ]
  ++ mylib.useModules ./../../modules/nixos [
    "common"
    "networking"
    "console"
    "environment"
    "filesystems"
    "sound" # :)
    "nvim"
    "tailscale"
  ];

  myopts = {
    server = true;
    hostName = "nixlab";
  };

  services.openssh.enable = true;

  home-manager.extraSpecialArgs = {
    inherit (config) myopts;
  };

  system.stateVersion = "25.05";

  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 8192;
      cores = 4;
    };
  };
}
