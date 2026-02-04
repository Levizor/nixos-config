{ inputs, self, ... }:
{
  flake.nixosConfigurations.iso = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.iso
    ];
  };

  flake.nixosModules.iso =
    {
      modulesPath,
      lib,
      user,
      modPath,
      ...
    }:
    {

      networking = {
        hostName = "nixiso";
        firewall.enable = lib.mkForce false;
      };

      imports = with self.nixosModules; [
        (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
        stylix
        hardware
        battery
        graphical
        networking
        printing
        sound
        nvim
        filesystems
        environment
      ];

      home-manager = {
        users."${user}" = {
          imports = with self.homeModules; [
            btop
            git
            vicinae
            zathura
            zen
            kitty
            tmux
            hyprland
            zsh
          ];

          home.packages = [
            # iso specific packages
          ];
        };
      };

      isoImage.squashfsCompression = "gzip -Xcompression-level 1";
    };
}
