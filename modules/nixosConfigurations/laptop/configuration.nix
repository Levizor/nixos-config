{
  inputs,
  self,
  ...
}:
{
  flake.nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.laptop
    ];
  };

  flake.nixosModules.laptop =
    {
      pkgs,
      mylib,
      config,
      lib,
      modPath,
      user,
      system,
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
      };

      imports = with self.nixosModules; [
        # graphical
        niri
        i3
        umbriel
        ly
        xdg
        stylix
        steam

        self.diskoConfigurations.laptop
        common
        home-manager
        battery
        docker
        environment
        filesystems
        flatpak
        hardware
        networking
        nvim
        printing
        sound
        tailscale
        snapper
        virtualisation
        sops
        # openclaw
        # peerix
      ];

      # connect nixos and home-manager configurations
      home-manager.users.${user}.imports = [
        self.homeModules.laptop
      ];

      nixpkgs.overlays = [
        inputs.cachyos.overlays.pinned
      ];

      boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;

      services = {
        auto-cpufreq = {
          # enable = true;
        };

        openssh = {
          enable = false;
          settings = {
            PermitRootLogin = "no";
            PasswordAuthentication = false;
          };
        };
      };

      programs = {
        kdeconnect.enable = true;
        # Required for JetBrains Rider: icu
        nix-ld = {
          enable = true;
          libraries = with pkgs; [
            libx11
            libsm
            fontconfig
            libice
            icu
            freetype
            glib
          ];
        };
      };

      # specialisation."noFirewall".configuration = {
      #   networking.firewall.enable = lib.mkForce false;
      # };

      stylix.targets.grub.enable = false;
      boot = {
        # For virtual camera in OBS
        kernelModules = [ "v4l2loopback" ];
        extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];

        loader.grub = {
          enable = true;
          efiSupport = true;
          device = "nodev";
          theme = self.packages.${system}.lain-grub-theme;
        };

        loader.efi.canTouchEfiVariables = true;
      };

      hardware.amdgpu.opencl.enable = true;

    };
}
