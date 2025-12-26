{
  pkgs,
  lib,
  inputs,
  modulesPath,
  config,
  outputs,
  ...
}:
{
  myopts = {
    server = true;
    hardware = false;
  };

  imports = [
    inputs.disko.nixosModules.disko
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./hardware-configuration.nix
    ./disko-config.nix
    ./../../modules/nixos/user.nix
    inputs.home-manager.nixosModules.home-manager
    ./home.nix
    inputs.nix-minecraft.nixosModules.minecraft-servers
    ./minecraft.nix
  ];

  nixpkgs = {
    overlays = [
      inputs.nix-minecraft.overlay
    ];
    config = {
      allowUnfree = true;
      allowUnsupportedSystem = true;
    };

  };

  home-manager.extraSpecialArgs = {
    inherit (config) myopts;
  };

  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

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

  system.stateVersion = "24.11";
}
