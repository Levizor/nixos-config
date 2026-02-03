{ inputs, self, ... }:
{
  flake.nixosConfigurations.minimal = {
    modules = self.nixosModules.minimal;
  };

  flake.nixosModules.minimal =
    { user, ... }:
    {
      imports = with self.nixosModules; [
        self.diskoConfigurations.minimal

        common

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

      home-manager.users.${user}.imports = with self.homeModules; [
        btop
        git
        nh
        ssh
        mpv
        kitty
        tmux
        zsh
        hyprland
        mako
      ];

    };
}
