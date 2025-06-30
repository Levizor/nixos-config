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
  ];

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

  specialisation.performance.configuration = {
    powerManagement.cpuFreqGovernor = "performance";
  };

    
  programs.gamemode.enable = true;
}
