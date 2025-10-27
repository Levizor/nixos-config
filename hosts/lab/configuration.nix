{
  inputs,
  user,
  pkgs,
  mylib,
  lib,
  ...
}:
{
  networking.hostName = "nixlab";

  myopts = {
    nh.host = "lab";
    monitors = [
      {
        name = "DP-1";
        config = "preferred, auto, 1, transform, 1";
      }
    ];

    wallpaperPack = "vertical";
  };

  imports = [
    inputs.disko.nixosModules.disko
    inputs.stylix.nixosModules.stylix
    ./hardware-configuration.nix
    ./disko-config.nix
    ../../modules/stylix
    # ./cage.nix
    ./searx-funnel.nix

    ./../../modules/home/common.nix
  ]
  ++ mylib.useModules ./../../modules/nixos [
    "graphical/wayland"
    "networking"
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
          "wm/hyprland"
          "wm/wpaperd"
        ]
      );
      wayland.windowManager.hyprland.xwayland.enable = false;
    };
  };

  programs.hyprland.xwayland.enable = false;

  services = {
    openssh.enable = true;
    getty.autologinUser = user;
  };

  environment.systemPackages = with pkgs; [
    sox
  ];

  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 8192;
      cores = 4;
    };
  };
}
