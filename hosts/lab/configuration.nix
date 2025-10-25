{
  inputs,
  outputs,
  system,
  user,
  modulesPath,
  pkgs,
  config,
  mylib,
  lib,
  ...
}:
{
  networking.hostName = "nixlab";

  myopts = {
    server = true;
    nh.host = "lab";
  };

  imports = [
    inputs.disko.nixosModules.disko
    inputs.stylix.nixosModules.stylix
    ./hardware-configuration.nix
    ./disko-config.nix
    ../../modules/stylix
    ./cage.nix
    ./funnel.nix

    ./../../modules/home/common.nix
  ]
  ++ mylib.useModules ./../../modules/nixos [
    "common"
    "graphical/xserver"
    "networking"
    "console"
    "environment"
    "filesystems"
    "sound" # :)
    "nvim"
    "tailscale"
    "searx"
  ];

  home-manager = {
    users."${user}" = {
      imports = mylib.useModules ./../../modules/home (
        lib.flatten [
          (mylib.prefixList "programs/" [
            "btop"
            "direnv"
            "git"
            "nh"
            "ssh"
          ])
          (mylib.prefixList "terminals/" [
            "kitty"
            "tmux"
          ])
          "zsh"
        ]
      );

    };
  };

  services.openssh.enable = true;

  system.stateVersion = "25.05";

  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 8192;
      cores = 4;
    };
  };

  environment.systemPackages = with pkgs; [
    sox
  ];
}
