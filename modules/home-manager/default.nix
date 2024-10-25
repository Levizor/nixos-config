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
        ./floorp.nix
        ./git.nix
        ./wm
        ./zsh/load.nix
        ./lsd.nix
        ./mako.nix
        ./packages.nix
        ./programs
        ./terminals
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
      };
    };
  };
}
