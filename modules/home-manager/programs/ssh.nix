{
  config,
  pkgs,
  user,
  ...
}:

{
  programs.ssh = {
    enableDefaultConfig = true;
    enable = true;
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = user;
        identityFile = "~/.ssh/github";
        identitiesOnly = true;
      };

      "aur.archlinux.org" = {
        user = "aur";
        identityFile = "~/.ssh/aur";
      };
    };
  };
}
