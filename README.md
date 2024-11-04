# Install 
```
sudo nix run --extra-experimental-features "nix-command flakes" 'github:nix-community/disko#disko-install' -- --flake 'github:Levizor/nixos-config#default' --disk main /dev/nvme0n1
```
