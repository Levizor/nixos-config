{ inputs, config, pkgs, ...}:
	let
    unstable = import <nixos-unstable> {config = {allowUnfree = true;};};
	in
{

  home-manager = {
    # useUserPackages = true;
    # useGlobalPkgs = true;
    backupFileExtension="backup";
    users.levizor = {

      imports = [
        inputs.home-manager.nixosModules.home-manager
        ./floorp.nix
        ./git.nix
        ./wm
        ./zsh/load.nix
        ./alacritty.nix
        ./foot.nix
        ./lsd.nix
        ./mako.nix
        ./zellij.nix
      ];

      home = {

        sessionVariables = {
          STEAM_EXTRA_COMPAT_TOOLS_PATHS =
            "$\{HOME}/.local/Steam/compatabilitytools.d";
        };
        enableNixpkgsReleaseCheck = false;
        username = "levizor";
        homeDirectory = "/home/levizor";
        stateVersion = "24.05";

        packages = with pkgs; [
          telegram-desktop
          tree
          alacritty
          ungoogled-chromium
          brave
          clipse
          nemo
          nomacs
          mpv
          grimblast
          easyeffects
          bluetuith
          vivid
          ripgrep
          fzf
          ani-cli
          protonup
          teams-for-linux
          obsidian
          zoom-us
          hyprpicker
          hyprpaper
          loupe
          youtube-music
          vesktop
          jetbrains-toolbox
          # imagemagick
          networkmanagerapplet
          keepassxc
          yt-dlp
          cmatrix
          tlrc
          scenebuilder
        ];
      };


      programs = {
        zathura = {
          enable = true;
          options = {
            selection-clipboard = "clipboard";
          };
        };
        swaylock = {
          enable = true;
        };
        obs-studio = {
            enable = true;
        };

        btop = {
            enable = true;
            settings = {
              vim_keys = true;
              force_tty = true;
            };
        };

        bat = {
            enable = true;
        };

        fzf = {
            enable = true;
            enableZshIntegration = true;
        };

        fuzzel = {
            enable = true;
          settings = {
            main = {
              terminal = "foot";
            };
          };
        };
      };
    };

  };

}
