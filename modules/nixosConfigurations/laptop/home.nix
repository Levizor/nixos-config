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
      nixpkgs.config.allowUnfree = true;
      home.packages = with pkgs; [
        # laptop specific packages
        stremio-linux-shell
        duf
        fd
        bat
        cmatrix
        ffmpeg
        fzf
        ripgrep
        tlrc
        typst

        inputs.nix-scribe.packages.${system}.default
        # google-cloud-sdk

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
        # jetbrains.rider
        jetbrains-toolbox
        jetbrains.idea
        # jetbrains.pycharm
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
        inputs.nix-index-database.homeModules.default

        weathr
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
        wm
      ];

      programs.nix-index.enable = true;
      programs.nix-index.enableZshIntegration = true;
      programs.nix-index-database.comma.enable = true;

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
