{ self, inputs, ... }:
{
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
        # inputs.wallpapers.homeManagerModules.default

        weathr
        btop
        git
        nh
        ssh
        mpv
        kdeconnect
        kitty
        tmux
        zsh
        hyprland
        # wpaperd
        lan-mouse
      ];

      programs.weathr.settings.location = {
        auto = false;
        latitude = 52.2298;
        longitude = 21.0118;
      };

      home.packages = with pkgs; [
        timg
      ];
      # wallpapers.packs = [ "vertical" ];
    };
}
