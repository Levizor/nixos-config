{ pkgs, user, ... }:
{
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
        "${user}"
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
