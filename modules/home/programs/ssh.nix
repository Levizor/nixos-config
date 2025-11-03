{
  config,
  pkgs,
  user,
  ...
}:

{
  programs.ssh = {
    enableDefaultConfig = false;
    enable = true;
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = user;
        identityFile = "~/.ssh/github";
        identitiesOnly = true;
      };

      "github-pjatk.com" = {
        hostname = "github.com";
        user = user;
        identityFile = "~/.ssh/github-pjatk";
        identitiesOnly = true;
      };

      "aur.archlinux.org" = {
        user = "aur";
        identityFile = "~/.ssh/aur";
      };

      "*" = {
        forwardAgent = false;
        addKeysToAgent = "no";
        compression = false;
        serverAliveInterval = 0;
        serverAliveCountMax = 3;
        hashKnownHosts = false;
        userKnownHostsFile = "~/.ssh/known_hosts";
        controlMaster = "no";
        controlPath = "~/.ssh/master-%r@%n:%p";
        controlPersist = "no";
      };
    };
  };
}
