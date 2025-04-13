{
  pkgs,
  lib,
  inputs,
  modulesPath,
  outputs,
  ...
}:
{
  imports = [
    inputs.disko.nixosModules.disko
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./hardware-configuration.nix
    ./disko-config.nix
    ./../../modules/nixos/user.nix
    inputs.home-manager.nixosModules.home-manager
    ./home.nix
  ];

  services = {
    openssh.enable = true;
  };

  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  environment = {
    systemPackages = with pkgs; [
      btop
      curl
      fastfetch
      git
      inputs.nixvim.packages."${system}".default
      killall
      ncurses
      python3
      ripgrep
      tmux
      unzip
      vim
      zip
    ];

    enableAllTerminfo = true;
  };

  users.users.root = {
    initialPassword = "lol123";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB5O6fGFVOhzBoAea+v0f+ciZB7u2NWKr4Xw0CsFJFZ7 levizor@nixos"
    ];

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

}
