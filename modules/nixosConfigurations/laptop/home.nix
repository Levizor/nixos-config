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

  flake.homeModules.laptop =
    { pkgs, ... }:
    {

      home.packages = with pkgs; [
        # laptop specific packages
        duf
        fd
        bat
        cmatrix
        ffmpeg
        fzf
        ripgrep
        tlrc
        typst
        cachix

        telegram-desktop
        heroic
        inputs.tray-tui.packages.${system}.tray-tui
        # tray-tui
        inputs.dark-text.packages.${system}.default
        # android-tools
        ani-cli
        cargo
        # filezilla
        hyprland-workspaces-tui
        jetbrains.rider
        jetbrains-toolbox
        # jetbrains.idea-ultimate
        jetbrains.pycharm
        pinta
        networkmanagerapplet
        nix-prefetch-github
        obsidian
        onlyoffice-desktopeditors
        qbittorrent
        thunderbird
        timg
        # ungoogled-chromium
        vesktop
        pear-desktop
        yt-dlp
        lazygit
        gemini-cli
      ];

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
      wallpapers.packs = [
        "picturesque"
        "alena-aenami"
      ];
    };
}
