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
        common
        self.diskoConfigurations.lab

        home-manager

        funnel
        stylix
        networking
        environment
        filesystems
        sound # :)
        nvim
        tailscale
        searx
        forgejo
        devcook
        # "attic"
      ];

      home-manager.users.${user}.imports = [
        self.homeModules.lab
      ];

      programs.nix-ld = {
        enable = true;
        libraries = with pkgs; [
          # kdePackages.krdp
        ];
      };

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


  flake.homeConfigurations.lab =
    { pkgs, ... }:
    inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        self.homeModules.lab
      ];
    };

  flake.homeModules.lab =
    { pkgs, ... }:
    {
      imports = with self.homeModules; [
        btop
        git
        ssh
        tmux
        zsh
      ];

      home.packages = with pkgs; [
        # timg
      ];
      # wallpapers.packs = [ "vertical" ];
    };
}
