{ config, lib, pkgs, ... }:

  {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      "${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"
      ./disko-config.nix
      ./user.nix
    ];
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # boot.extraModulePackages = with config.boot.kernelPackages; [
  #   v4l2loopback
  # ];
  # boot.extraModprobeConfig = ''
  #   options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  # '';
  security.polkit.enable = true;

  #bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.

  #bluetooth
  hardware.bluetooth.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  
  security.sudo.extraConfig = ''
    moritz  ALL=(ALL) NOPASSWD: ${pkgs.systemd}/bin/systemctl'';

  services.pipewire = {
     enable = true;
     alsa.enable = true;
     alsa.support32Bit = true;
     pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  #sddm
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  #hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  #zsh
  programs.zsh.enable = true;
  environment.systemPackages = with pkgs; [
     curl
     vim
     home-manager
     git
     brightnessctl
     pulseaudioFull
     pavucontrol 
     clang
  ];
  
  # Enable CUPS to print documents.
  # services.printing.enable = true;
  system.stateVersion = "24.05"; # Did you read the comment?
}

