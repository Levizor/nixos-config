{config, ...}:

{
	programs.zsh = {
		enable = true;
		dotDir = "zsh";
		enableCompletion = true;
		autosuggestion.enable = true;
		syntaxHighlighting.enable = true;
		historySubstringSearch.enable = true;

		shellAliases = {
			ll = "ls -l";
			la = "ls -la";
			upgrade = "sudo nixos-rebuild switch --flake /home/levizor/nix/ --impure";
			nixconf = "nvim ~/nix/nixos/configuration.nix";
			conf = "home-manager switch --flake /home/levizor/nix --impure";
		};

		history = {
			size = 10000;
			path = "${homePath}/zsh/history";
		};
	};

}
