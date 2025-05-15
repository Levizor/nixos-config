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

  hardware.nvidia = {
    modesetting.enable = true;
    open = lib.mkForce false;

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:2:0:0";
    };
  };

  specialisation = {
    gaming-time.configuration = {
      hardware.nvidia = {
        prime.sync.enable = lib.mkForce true;
        prime.offload = {
          enable = lib.mkForce false;
          enableOffloadCmd = lib.mkForce false;
        };
      };
    };
  };

  programs = {
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        icu
      ];
    };
  };
}
