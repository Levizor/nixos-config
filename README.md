# nixos-config

## Description

This is a full fledged, modular nixos configuration for multiple hosts, including laptop, lab, vps machine and iso image.
Utilizes [flake-parts](https://flake.parts) to construct a [dendritic pattern](https://github.com/mightyiam/dendritic) configuration.

![diagram](./.github/diagram.svg)

Each host specifies which nixos and home-manager modules it requires.
Example:

```nix
# modules/nixosConfigurations/laptop/configuration.nix

  flake.nixosModules.laptop =
    {
      pkgs,
      mylib,
      config,
      lib,
      modPath,
      user,
      ...
    }:
    {
      networking.hostName = "nixlaptop";

      myopts = {
        additionalPackages = true;
        nh.host = "laptop";
        monitors = [
          {
            name = "eDP-1";
            config = "1920x1080@60, 0x0, 1,";
          }
          {
            name = "HDMI-A-1";
            config = "preferred, auto, 1,";
          }
        ];
      };

      imports = with self.nixosModules; [
        self.diskoConfigurations.laptop

        common
        battery
        docker
        environment
        filesystems
        flatpak
        graphical
        hardware
        networking
        nvim
        printing
        sound
        steam
        stylix
        tailscale
        snapper
        virtualisation
      ];

      # connect nixos and home-manager configurations
      home-manager = {
        users.${user} = {
          imports = [
            self.homeModules.laptop
          ];
        };
      };
    };

  flake.homeModules.laptop = {
    imports = with self.homeModules; [
      inputs.wallpapers.homeManagerModules.default

      helix
      distrobox
      xdg
      btop
      chromium
      direnv
      fzf
      git
      keepassxc
      mpv
      nh
      obs
      ssh
      vicinae
      zathura
      zen
      kdeconnect
      kitty
      tmux
      zsh
      packages
      wm
    ];

    programs.lan-mouse.settings = {
      clients = [
        {
          hostname = "nixlab";
          position = "right";
          activate_on_startup = true;
        }
      ];
    };

    home.packages = [
      # laptop specific packages
    ];

    wallpapers.packs = [
      "picturesque"
      "alena-aenami"
    ];
  };

```

## Inputs

| Input         | URL                                                  |
| ------------- | ---------------------------------------------------- |
| nixpkgs       | https://github.com/NixOS/nixpkgs/tree/nixos-unstable |
| stable        | https://github.com/NixOS/nixpkgs/tree/nixos-25.05    |
| flake-parts   | https://github.com/hercules-ci/flake-parts           |
| import-tree   | https://github.com/vic/import-tree                   |
| disko         | https://github.com/nix-community/disko               |
| stylix        | https://github.com/danth/stylix                      |
| nixvim        | https://github.com/Levizor/nixvim                    |
| home-manager  | https://github.com/nix-community/home-manager        |
| minimal-tmux  | https://github.com/niksingh710/minimal-tmux-status   |
| zen-browser   | https://github.com/0xc000022070/zen-browser-flake    |
| tray-tui      | https://github.com/Levizor/tray-tui                  |
| dark-text     | https://github.com/vimjoyer/dark-text                |
| vicinae       | https://github.com/vicinaehq/vicinae                 |
| nix-minecraft | https://github.com/Infinidoge/nix-minecraft          |
| cachyos       | https://github.com/xddxdd/nix-cachyos-kernel         |
| wallpapers    | https://github.com/Levizor/Wallpapers                |
| lan-mouse     | https://github.comfeschber/lan-mouse                 |

## Installation

To install the system clone this repository:

```sh
git clone https://github.com/Levizor/nixos-config
```

Then, for drives formatting and mounting run disko with

```sh
# WARNING! This action will format drives set under disko-config.nix!
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode disko modules/nixosConfigurations/<host>/disko-config.nix
```

or do the mounting yourself, in which case it's required to update hardware configuration to include the filesystem layout.

Then install with

```sh
sudo nixos-install --flake .#<host>

```

## Updates

To update the system, run:

```sh
nix flake update
```

and rebuild:
```
sudo nixos-rebuild switch --flake ".#<host>"
```
