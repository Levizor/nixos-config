{
  pkgs,
  mylib,
  config,
  lib,
  user,
  modPath,
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
    # For virtual machines
    # ./virtual.nix
  ]
  ++ mylib.useModules (modPath + "/nixos") [
    "battery"
    "console"
    "docker"
    "environment"
    "filesystems"
    # "flatpak"
    "graphical"
    "hardware"
    "networking"
    "nvim"
    "printing"
    "sound"
    "steam"
    "stylix"
    "tailscale"
  ];

  home-manager = {
    users."${user}" = {
      imports = mylib.useModules (modPath + "/home") (
        lib.flatten [
          (mylib.prefixList "programs/" [
            "xdg"
            "btop"
            "chromium"
            "direnv"
            "fzf"
            "git"
            "keepassxc"
            "mpv"
            "nh"
            "obs"
            "ssh"
            "vicinae"
            "zathura"
            "zen"
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

      home.packages = [
        # laptop specific packages
      ];
    };
  };

  services.auto-cpufreq = {
    enable = true;
  };

  # Required for JetBrains Rider
  programs = {
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        icu
      ];
    };
  };

  # specialisation."noFirewall".configuration = {
  #   networking.firewall.enable = lib.mkForce false;
  # };


  # For virtual camera in OBS
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];

  boot.kernelModules = [ "v4l2loopback" ];
}
