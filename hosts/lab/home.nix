{
  inputs,
  outputs,
  myopts,
  mylib,
  system,
  user,
  ...
}:
{
  home-manager = {
    extraSpecialArgs = {
      inherit inputs outputs mylib user system;
    };
    backupFileExtension = "backup";
    users.levizor = {
      imports = mylib.useModules ./../../modules/home-manager [
        "zsh"
        "terminals/tmux"
        "programs/nh"
        "programs/git"
        "programs/btop"
	"programs/ssh"
	"programs/direnv"
      ];

      home = {
        enableNixpkgsReleaseCheck = false;
        username = "levizor";
        homeDirectory = "/home/levizor";
        stateVersion = "25.05";
      };

      programs = {
        tmux.prefix = "C-a";
      };
    };
  };
}
