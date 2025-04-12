# Install

## If enough memory (doubt)

```
sudo nix run --extra-experimental-features "nix-command flakes" 'github:nix-community/disko#disko-install' -- --flake 'github:Levizor/nixos-config#default' --disk main /dev/nvme0n1
```

## Standard

```
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode disko hosts/<host>/disko-config.nix
sudo nixos-install --flake .#<host>
```
