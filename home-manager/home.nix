{ config, pkgs, ...}: 
	let 
    unstable = import <nixos-unstable> {config = {allowUnfree = true;};}; 
	in 
{
  imports = [
    ./zsh.nix
    ./librewolf.nix
  ];
	home = {
		username = "levizor";
		homeDirectory = "/home/levizor/";
		stateVersion = "24.05";

		packages = with pkgs; [
			neofetch
			btop
			telegram-desktop
			webcord
			fuzzel
      hyprpicker
      tree
      kitty
      librewolf
      ungoogled-chromium
      brave
      unstable.clipse
      zathura
      cinnamon.nemo
      nomacs
      mpv
      wlogout
      grimblast
      easyeffects
      bluetuith
      vivid
      lsd
      oh-my-posh
      ripgrep
		];
	};


	programs.neovim = {
		enable = true;
		defaultEditor = true;
	};

	programs.obs-studio = {
    		enable = true;
    		# plugins = with pkgs.obs-studio-plugins; [
    		# 			wlrobs
    		#   	obs-backgroundremoval
    		#   	obs-pipewire-audio-capture
    		# ];
	};
}
