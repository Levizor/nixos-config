{ self, inputs, ... }:
{
  flake.nixosConfigurations.lab = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.lab
    ];
  };

  flake.nixosModules.lab =
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

      imports = with self.nixosModules; [
        self.diskoConfigurations.lab

        common

        funnel
        stylix
        wayland
        networking
        environment
        filesystems
        sound # :)
        nvim
        tailscale
        searx
        # "attic"
      ];

      home-manager.users.${user}.imports = [
        self.homeModules.lab
      ];

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
      ];

      virtualisation.vmVariant = {
        virtualisation = {
          memorySize = 8192;
          cores = 4;
        };
      };
    };
}
