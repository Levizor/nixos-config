{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystem = true;
    permittedInsecurePackages = [
      "floorp-unwrapped-11.19.0"
      "freeimage-unstable-2021-11-01"
    ];

    packageOverrides = pkgs: rec {
      kew = pkgs.callPackage ./kew.nix { };
    };
  };
  imports = [
    ./user.nix
    ./environment.nix
    ./services.nix
  ];

  security = {
    polkit.enable = true;

    sudo = {
      wheelNeedsPassword = false;
      extraConfig = ''moritz  ALL=(ALL) NOPASSWD: ${pkgs.systemd}/bin/systemctl'';
    };
  };

  #bootloader
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    plymouth = {
      enable = true;
    };
  };

  networking.hostName = "nixos"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  hardware = {
    #bluetooth
    bluetooth.enable = true;
    graphics.enable = true;
    graphics.enable32Bit = true;
    nvidia = {
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
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
    ];
  };

  #hyprland
  programs.hyprland = {
    enable = true;
  };

  programs.hyprlock.enable = true;

  # qt = {
  #   enable = true;
  #   platformTheme = lib.mkForce "gtk2";
  # };

  programs.wireshark.enable = true;
  programs.zsh.enable = true;
  programs.zsh.promptInit = ''
    ${pkgs.any-nix-shell}/bin/any-nix-shell zsh --info-right | source /dev/stdin
  '';
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };
  programs.gamemode.enable = true;

  system.stateVersion = "24.05";
}
