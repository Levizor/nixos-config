{ self, inputs, ... }:
{
  flake.homeConfigurations.laptop =
    { pkgs, ... }:
    inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [
        self.homeModules.laptop
      ];
    };

  flake.homeModules.laptop = {
    imports = with self.homeModules; [
      inputs.wallpapers.homeManagerModules.default

      helix
      distrobox
      xdg
      btop
      chromium
      direnv
      fzf
      git
      keepassxc
      mpv
      nh
      obs
      ssh
      vicinae
      zathura
      zen
      kdeconnect
      kitty
      tmux
      zsh
      packages
      wm
    ];

    programs.lan-mouse.settings = {
      clients = [
        {
          hostname = "nixlab";
          position = "right";
          activate_on_startup = true;
        }
      ];
    };

    home.packages = [
      # laptop specific packages
    ];

    wallpapers.packs = [
      "picturesque"
      "alena-aenami"
    ];
  };
}
