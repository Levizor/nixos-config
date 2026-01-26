# nixos-config

## Description

This is a full fledged, modular nixos configuration for multiple hosts, including laptop, lab, vps machine and iso image.
Right now configuration is suited for one user only.

![diagram](./.github/diagram.svg)

Each host specifies which nixos and home-manager modules it requires.
Example:

```nix
# hosts/laptop/configuration.nix

  imports = [
    ./hardware-configuration.nix
    ./disko-config.nix
  ]
  ++ mylib.useModules (modPath + "/nixos") [
    "battery"
    "console"
    "docker"
    "environment"
    "filesystems"
    # "flatpak"
    "graphical"
    "hardware"
    "networking"
    "nvim"
    "printing"
    "sound"
    "steam"
    "stylix"
    "tailscale"
  ];

  home-manager = {
    users."${user}" = {
      imports = mylib.useModules (modPath + "/home") (
        lib.flatten [
          (mylib.prefixList "programs/" [
            "btop"
            "chromium"
            "direnv"
            "fzf"
            "git"
            "keepassxc"
            "mako"
            "mpv"
            "nh"
            "obs"
            "ssh"
            "vicinae"
            "zathura"
            "zen"
          ])
          (mylib.prefixList "terminals/" [
            "kitty"
            "tmux"
          ])
          "wm"
          "zsh"
          "packages"
        ]
      );

      home.packages = [
        # laptop specific packages
      ];
    };
  };

```

## Inputs

| Input         | URL                                                  |
| ------------- | ---------------------------------------------------- |
| nixpkgs       | https://github.com/NixOS/nixpkgs/tree/nixos-unstable |
| stable        | https://github.com/NixOS/nixpkgs/tree/nixos-25.05    |
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
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode disko hosts/<host>/disko-config.nix
```

or do the mounting yourself.

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
