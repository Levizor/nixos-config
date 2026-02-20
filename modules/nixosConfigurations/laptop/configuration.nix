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
        self.diskoConfigurations.laptop

        common
        battery
        docker
        environment
        filesystems
        flatpak
        graphical
        hardware
        networking
        nvim
        printing
        sound
        steam
        stylix
        tailscale
        snapper
        virtualisation
      ];

      # connect nixos and home-manager configurations
      home-manager = {
        users.${user} = {
          imports = [
            self.homeModules.laptop
          ];
        };
      };

      nixpkgs.overlays = [
        inputs.cachyos.overlays.pinned
      ];

      boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;

      nix.settings.substituters = [ "https://attic.xuyh0120.win/lantian" ];
      nix.settings.trusted-public-keys = [ "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc=" ];

      services = {
        auto-cpufreq = {
          enable = true;
        };

        openssh = {
          enable = true;
          settings = {
            PermitRootLogin = "no";
            PasswordAuthentication = false;
          };
        };
      };

      programs = {
        kdeconnect.enable = true;
        # Required for JetBrains Rider
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
      boot = {
        kernelModules = [ "v4l2loopback" ];
        extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];

        loader.grub = {
          enable = true;
          efiSupport = true;
          device = "nodev";
        };

        loader.efi.canTouchEfiVariables = true;
      };

      hardware.amdgpu.opencl.enable = true;
    };
}
