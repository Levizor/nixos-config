{ config, pkgs, ...}: 
	let 
    unstable = import <nixos-unstable> {config = {allowUnfree = true;};}; 
	in 
{
  imports = [
    # ./stylix.nix
    ./librewolf.nix
    ./git.nix
    ./wm/load.nix
    ./zsh/load.nix
    ./alacritty.nix
    ./foot.nix
    ./lsd.nix
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
		      hyprpicker
		      tree
		      alacritty
		      librewolf
		      ungoogled-chromium
		      brave
		      clipse
		      zathura
		      nemo
		      nomacs
		      mpv
		      wlogout
		      grimblast
		      easyeffects
		      bluetuith
		      vivid
		      oh-my-posh
		      ripgrep
		      fzf
		      ani-cli
		      protonup
		      mangohud
		      teams-for-linux
		];
	};


	programs = {
		obs-studio = {
		    enable = true;
		};

		btop = {
		    enable = true;
		    settings = {
			vim_keys = true;
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
		};
	};

  services.mako.enable = true;



	
}
