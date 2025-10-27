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
    monitors = [
      {
        name = "eDP-1";
        config = "1920x1080@60, 0x0, 1,";
      }
      {
        name = "HDMI-A-1";
        config = "preferred, auto, 1,";
      }
    ];

    wallpaperPack = "picturesque";
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
            "mpv"
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
