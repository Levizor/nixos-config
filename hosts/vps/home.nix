{
  inputs,
  outputs,
  myopts,
  ...
}:
{
  home-manager = {
    extraSpecialArgs = {
      inherit inputs outputs myopts;
    };
    backupFileExtension = "backup";
    users.levizor = {
      imports =
        let
          homePath = ./../../modules/home-manager;
          programPath = (homePath + "/programs");
        in
        [
          (homePath + "/zsh")
          (homePath + "/terminals/tmux.nix")
          (programPath + "/nh.nix")
          (programPath + "/git.nix")
          (programPath + "/lsd.nix")
          (programPath + "/fzf.nix")
        ];

      home = {
        sessionPath = [
          "$HOME/.cargo/bin/"
        ];

        enableNixpkgsReleaseCheck = false;
        username = "levizor";
        homeDirectory = "/home/levizor";
        stateVersion = "24.05";
      };

      programs = {
        tmux.prefix = "C-a";
      };
    };
  };
}
