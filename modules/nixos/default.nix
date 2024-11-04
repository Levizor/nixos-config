{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config = {
    allowUnfree = true;
    allowUnsupportedSystem = true;
    permittedInsecurePackages = [
      "floorp-unwrapped-11.19.0"
    ];

    packageOverrides = pkgs: rec {
      # sddm-slice = pkgs.callPackage ./sddm.nix {};
      wpaperd = pkgs.callPackage ./wpaperd.nix {};
    };
  };
  imports = [
    ./user.nix
    ./environment.nix
  ];

  # security.rtkit.enable = true;

  security = {
    polkit.enable = true;

    sudo = {
      wheelNeedsPassword = false;
      extraConfig = ''
        moritz  ALL=(ALL) NOPASSWD: ${pkgs.systemd}/bin/systemctl'';
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

  #services
  services = {
    tlp.enable = true;
    displayManager.ly = {
      enable = false;
      settings = {
        animation = "doom";
        hide_borders = true;
      };
    };
    displayManager.sddm = {
      enable = false;
      wayland.enable = true;
      # theme = "sddm-slice";
    };
    upower = {
      enable = true;
    };
    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      windowManager = {
        i3 = {
          enable = true;
        };
      };
      videoDrivers = ["nvidia"];
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
    platformTheme = "gtk2";
  };

  # programs.wireshark.enable = true;
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
