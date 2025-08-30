{
  inputs,
  lib,
  pkgs,
  config,
  ...
}:
let
  myopts = config.myopts;
in
{
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [
      "root"
      "levizor"
    ];
  };
  imports = [
    ./networking.nix
    ./user.nix
    ./environment.nix
    ./services.nix
  ];

  time.timeZone = "Europe/Warsaw";

  security = {
    rtkit.enable = true;
    polkit.enable = true;

    sudo = {
      wheelNeedsPassword = false;
      extraConfig = ''moritz  ALL=(ALL) NOPASSWD: ${pkgs.systemd}/bin/systemctl'';
    };
  };

  boot = {
    # kernelPackages = pkgs.linuxPackages_6_1;
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  hardware = {
    enableAllFirmware = true;
    bluetooth.enable = myopts.hardware;
    graphics.enable = myopts.hardware;
    graphics.enable32Bit = myopts.hardware;
  };

  programs = {
    zsh = {
      enable = true;
      #required to use zsh over bash when using nix-shell
      promptInit = ''
        ${pkgs.any-nix-shell}/bin/any-nix-shell zsh --info-right | source /dev/stdin
      '';
    };

    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

    wayfire = {
      enable = true;
      plugins = with pkgs.wayfirePlugins; [
        wcm
        wf-shell
        wayfire-plugins-extra
      ];
    };

    steam = {
      enable = myopts.steam;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };

    gamemode.enable = myopts.steam;
    wireshark.enable = myopts.additionalPackages;

  };

  system.stateVersion = "24.11";
}
