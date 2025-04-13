{
  pkgs,
  lib,
  inputs,
  modulesPath,
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
  ];

  services = {
    openssh.enable = true;
  };

  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  environment.systemPackages = with pkgs; [
    fastfetch
    git
    python3
    curl
    vim
    zip
    unzip
    killall
    btop
    tmux
    inputs.nixvim.packages."${system}".default
    ripgrep
  ];

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
