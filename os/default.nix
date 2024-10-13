{ config, lib, pkgs, inputs, ... }:

  {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      "${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"
      ./disko-config.nix
      ./user.nix
      ./stylix.nix
      <home-manager/nixos>
    ];
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnsupportedSystem = true;
  

  security.polkit.enable = true;

  #bootloader
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/EFI";
      };
      grub = {
        enable = true;
        efiSupport = true;
        useOSProber = true;
      };
    };

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

  #graphics
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

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



  #services
  services = {
  # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;
    xserver.videoDrivers = ["nvidia"];
 
  #sddm
    displayManager.sddm = {
      enable = false;
      wayland.enable = true;
      theme = "catppuccin-mocha";
    };
    displayManager.ly = {
      enable = true;
    };
    printing.enable = true;

    pipewire = {
     enable = true;
     alsa.enable = true;
     alsa.support32Bit = true;
     pulse.enable = true;
    };

  };


  #hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.zsh.enable = true;

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
     wl-clipboard
     libnotify

     (inputs.nvix.packages.${system}.base.extend {
        config.colorschemes.tokyonight.settings.transparent = true;
     })
  ];





  system.stateVersion = "24.05"; 
}

