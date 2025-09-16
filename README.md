# nixos-config

My personal NixOS configuration. Includes laptop and vps hosts.

## Install

```
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode disko hosts/<host>/disko-config.nix
sudo nixos-install --flake .#<host>
```
