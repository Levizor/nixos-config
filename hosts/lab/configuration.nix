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
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnsupportedSystem = true;
    };
  };

  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./../../modules/nixos/user.nix
    ./hardware-config.nix
    ./disko-configuration.nix
    ./home.nix
  ];

  myopts.server = true;

  services.openssh.enable = true;

  environment = {
    enableAllTerminfo = true;
    systemPackages = [
      inputs.nixvim.packages."${system}".default
    ];
    variables.EDITOR = "nvim";
  };

  programs = {
    nano.enable = false;
    zsh = {
      enable = true;
      #required to use zsh over bash when using nix-shell
      promptInit = ''
        ${pkgs.any-nix-shell}/bin/any-nix-shell zsh --info-right | source /dev/stdin
      '';
    };
  };

  home-manager.extraSpecialArgs = {
    inherit (config) myopts;
  };

  system.stateVersion = "25.05";
}
