{ config, pkgs, ...}: 
	let 
    unstable = import <nixos-unstable> {config = {allowUnfree = true;};}; 
	in 
{
  imports = [
    ./librewolf.nix
    ./git.nix
    ./wm/load.nix
    ./zsh/load.nix
  ];

	home = {
    enableNixpkgsReleaseCheck = false;
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
      lsd
      oh-my-posh
      ripgrep
      fzf
      ani-cli
		];
	};


	programs.neovim = {
		enable = true;
		defaultEditor = true;
	};

	programs.obs-studio = {
    enable = true;
	};
}
