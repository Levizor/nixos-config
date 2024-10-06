{ config, pkgs, ...}: 

	let 
		homePath = "/home/levizor";
	in {
	home = {
		username = "levizor";
		homeDirectory = "${homePath}";
		stateVersion = "24.05";

		packages = with pkgs; [
			neofetch
			btop
			telegram-desktop
		];
	};

	programs.zsh = {
		enable = true;
		enableCompletion = true;
		autosuggestion.enable = true;
		syntaxHighlighting.enable = true;

		shellAliases = {
			ll = "ls -l";
			la = "ls -la";
			upgrade = "sudo nixos-rebuild switch --flake /home/levizor/nix/ --impure";
			nixconf = "nvim ~/nix/nixos/configuration.nix";
			conf = "home-manager switch --flake /home/levizor/nix&&exec zsh";
		};

		history = {
			size = 10000;
			path = "${homePath}/zsh/history";
		};
	};

	programs.neovim = {
		enable = true;
		defaultEditor = true;
	};

}
