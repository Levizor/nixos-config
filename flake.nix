{
  description = "NixOS Config";

  inputs = {
    pipewire-screenaudio.url = "github:IceDBorn/pipewire-screenaudio";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
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
            ./hosts/default/configuration.nix
          ];
          specialArgs = {
            inherit inputs self system;
          };
        };
      };
    };
}
