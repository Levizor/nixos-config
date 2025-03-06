{
  description = "NixOS Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    minimal-tmux = {
      url = "github:niksingh710/minimal-tmux-status";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pipewire-screenaudio.url = "github:IceDBorn/pipewire-screenaudio";
    stable.url = "github:nixos/nixpkgs/nixos-24.11";
    stylix.url = "github:danth/stylix";
    nixvim = {
      url = "github:Levizor/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        default = nixpkgs.lib.nixosSystem {
          modules = [
            (
              { pkgs, modulesPath, ... }:
              {
                imports = [ (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix") ];
                networking.wireless.enable = false;
              }
            )
            ./hosts/default/configuration.nix
          ];
          specialArgs = {
            inherit inputs self system;
          };
        };
      };
    };
}
