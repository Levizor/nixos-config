{
  pkgs,
  inputs,
  mylib,
  outputs,
  config,
  lib,
  user,
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

    ../../modules/stylix
    inputs.stylix.nixosModules.stylix

    ../../modules/home/common.nix
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

  home-manager = {
    users."${user}" = {
      imports = mylib.useModules ./../../modules/home (
        lib.flatten [
          (mylib.prefixList "programs/" [
            "btop"
            "direnv"
            "zen"
            "chromium"
            "fzf"
            "git"
            "keepassxc"
            "mako"
            "nh"
            "obs"
            "ssh"
            "vicinae"
            "zathura"
          ])
          (mylib.prefixList "terminals/" [
            "kitty"
            "tmux"
          ])
          "wm"
          "zsh"
          "packages"
        ]
      );
    };
  };

  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];

  boot.kernelModules = [ "v4l2loopback" ];

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
