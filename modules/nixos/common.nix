{ pkgs, user, ... }:
{

  myopts = {
    git = {
      user = "Levizor";
      email = "levizor@disroot.org";
    };

    tailscale = {
      magicDns = "worm-chameleon.ts.net";
    };
  };

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [
      "root"
      user
    ];
    extra-substituters = [ "https://vicinae.cachix.org" ];
    extra-trusted-public-keys = [ "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc=" ];
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users."${user}" = {
      shell = pkgs.zsh;
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "networkmanager"
        "input"
        "audio"
        "wireshark"
        "minecraft"
        "libvirtd"
        "docker"
      ];
      initialPassword = "password";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKu2iVrpee6R9cf80o7lu1qqf9EnEDdquqn5kJir+Lbk levizor@nixlaptop"
      ];
    };
  };

  programs = {
    zsh = {
      enable = true;
      #required to use zsh over bash when using nix-shell
      promptInit = ''
        ${pkgs.any-nix-shell}/bin/any-nix-shell zsh --info-right | source /dev/stdin
      '';
    };
  };

  security = {
    sudo = {
      wheelNeedsPassword = false;
      extraConfig = ''moritz  ALL=(ALL) NOPASSWD: ${pkgs.systemd}/bin/systemctl'';
    };
  };

  time.timeZone = "Europe/Warsaw";

  system.stateVersion = "25.05";

}
