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
  };

  imports = [
    ./hardware-configuration.nix
    ./disko-config.nix
    ./funnel.nix
  ]
  ++ mylib.useModules ./../../modules/nixos [
    "stylix"
    "graphical/wayland"
    "networking"
    "environment"
    "filesystems"
    "sound" # :)
    "nvim"
    "tailscale"
    "searx"
    # "attic"
  ];

  home-manager = {
    users."${user}" = {
      imports = [
        inputs.wallpapers.homeManagerModules.default
      ]
      ++ mylib.useModules ./../../modules/home (
        lib.flatten [
          (mylib.prefixList "programs/" [
            "xdg"
            "btop"
            "direnv"
            "git"
            "nh"
            "ssh"
            "mpv"
            "zen"
            "kdeconnect"
          ])
          (mylib.prefixList "terminals/" [
            "kitty"
            "tmux"
          ])
          "zsh"
          "wm/hyprland"
          "wm/wpaperd"
          "wm/lan-mouse"
        ]
      );
      wayland.windowManager.hyprland.xwayland.enable = false;
      home.packages = with pkgs; [
        timg
      ];
      wallpapers.packs = [ "vertical" ];
    };
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      kdePackages.krdp
    ];
  };

  programs.hyprland.xwayland.enable = false;
  programs.kdeconnect.enable = true;

  services = {
    openssh.enable = true;
    getty.autologinUser = user;
  };

  environment.systemPackages = with pkgs; [
    sox
    lan-mouse
  ];

  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 8192;
      cores = 4;
    };
  };
}
