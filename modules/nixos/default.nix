{ config, lib, pkgs, inputs, ... }:

  {
  imports =
    [
      ./user.nix
    ];
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnsupportedSystem = true;

  nixpkgs.config.permittedInsecurePackages = [
    "floorp-unwrapped-11.19.0"
  ];

  nixpkgs.config.packageOverrides = pkgs: rec {
    sddm-slice = pkgs.callPackage ./sddm.nix {};
  };


  security.polkit.enable = true;
  security.rtkit.enable = true;

  #bootloader
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    plymouth = {
      enable = true;
    };
  };

  networking.hostName = "nixos"; # Define your hostname.

  #bluetooth
  hardware.bluetooth.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.


  security.sudo.extraConfig = ''
    moritz  ALL=(ALL) NOPASSWD: ${pkgs.systemd}/bin/systemctl'';

  security.sudo = {
    wheelNeedsPassword = false;
  };

  hardware.graphics.enable = true;
  #nvidia
  hardware.nvidia = {
    modesetting.enable = true;
    open = false;

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:2:0:0";
    };
  };

  # specialisation = {
  #   gaming-time.configuration = {
  #     hardware.nvidia = {
  #       prime.sync.enable = lib.mkForce true;
  #       prime.offload = {
  #         enable = lib.mkForce false;
  #         enableOffloadCmd = lib.mkForce false;
  #       };
  #     };
  #   };
  # };
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [

    ];
  };

  programs.wireshark.enable = true;


  programs.regreet = {
    enable = false;
    settings = {
      background = {
        fit = "Cover";
      };
      GTK = {
        application_prefer_dark_theme = true;
      };
    };
    cageArgs = ["-s" "-m" "last"];
  };

  #services
  services = {
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "sddm-slice";
    };
    upower = {
      enable = true;
    };
  # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;
    xserver = {
      enable = true;
      windowManager = {
        i3 = {
          enable = true;
        };

      };      videoDrivers = ["nvidia"];
    };

    greetd = {
      enable = false;
    };

    printing.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

  };


  #hyprland
  programs.hyprland = {
    enable = true;
  };

  qt = {
    enable = true;
    platformTheme="gtk2";
  };

  # programs.wireshark.enable = true;
  programs.zsh.enable = true;
  programs.zsh.promptInit = ''
    ${pkgs.any-nix-shell}/bin/any-nix-shell zsh --info-right | source /dev/stdin
  '';
  programs.steam = {
  enable = true;
  gamescopeSession.enable = true;
  };
  programs.gamemode.enable = true;


  environment.systemPackages = with pkgs; [
     curl
     vim
     git
     brightnessctl
     pulseaudioFull
     pavucontrol
     clang
     clang-tools
     cmake
     wl-clipboard
     libnotify
     killall
     rustup
     openssl
     lxqt.lxqt-policykit

     (inputs.nvix.packages.${system}.base.extend {
        config.colorschemes.tokyonight.settings.transparent = true;
     })

    pkgs.libsForQt5.qt5.qtgraphicaleffects
    (callPackage ./sddm.nix {})
  ];
  environment.variables = {
    EDITOR = "nvim";
  };

  system.stateVersion = "24.05";
}
