{ config, pkgs, ...}: 
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
        ./floorp.nix
        ./git.nix
        ./wm
        ./zsh/load.nix
        ./alacritty.nix
        ./foot.nix
        ./lsd.nix
        ./mako.nix
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
          neofetch
          telegram-desktop
          webcord
          tree
          alacritty
          ungoogled-chromium
          brave
          clipse
          zathura
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
          mangohud
          teams-for-linux
          obsidian
          zoom-us
          hyprpicker
          hyprpaper
          loupe
          youtube-music
          vesktop
        ];
      };


      programs = {
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
